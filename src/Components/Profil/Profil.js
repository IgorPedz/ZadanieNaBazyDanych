import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { user, useUser } from '../../context/UserContext'; // Kontekst użytkownika
import ProfIMG from '../../Components/FileDownload/FileDownload';
import './Profil.css';

const Profile = ({visit}) => {
  const { username } = useParams();
  const { user } = useUser(); // Zalogowany użytkownik
  const [profileData, setProfileData] = useState(null);
  const [isEditing, setIsEditing] = useState(false); // Sprawdzamy, czy profil jest w trybie edycji
  const [editedData, setEditedData] = useState({}); // Dane edytowanego profilu
  const [visitCount, setVisitCount] = useState(0); // Licznik odwiedzin

  // Sprawdzamy, czy zalogowany użytkownik może edytować profil
  const isCurrentUser = user && user.nick === username;

  useEffect(() => {
    const fetchUserData = async () => {
      try {
        const response = await fetch(`http://localhost/Profil.php?username=${username}`);
        const data = await response.json();

        if (data.status === 'success') {
          setProfileData(data.data); // Ustawienie danych użytkownika
          setEditedData(data.data); // Ustawienie początkowych wartości w edytowanych danych

          // Zwiększenie liczby odwiedzin tylko, jeśli to jest profil użytkownika
          if (isCurrentUser) {
            setVisitCount(data.data.visitCount || 0); // Jeśli jest licznik odwiedzin, ustawiamy go
          }
        } else {
          console.error('Błąd pobierania danych:', data.message);
        }
      } catch (error) {
        console.error('Błąd podczas pobierania danych:', error);
      }
    };

    fetchUserData();

    // Zwiększamy licznik odwiedzin, gdy załadujemy profil
    if (isCurrentUser) {
      const updateVisitCount = async () => {
        try {
          const response = await fetch('http://localhost/UpdateVisitCount.php', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({
              username: user.nick, // Zalogowany użytkownik
            }),
          });

          const result = await response.json();
          if (result.status === 'success') {
            setVisitCount(result.newVisitCount); // Zaktualizowana liczba odwiedzin
          } else {
            console.error('Błąd aktualizacji liczby odwiedzin:', result.message);
          }
        } catch (error) {
          console.error('Błąd podczas wysyłania zapytania do serwera:', error);
        }
      };
    }

  }, [username, user.nick, isCurrentUser]);

  const handleEditToggle = () => {
    if (isCurrentUser) {
      setIsEditing((prev) => !prev); // Przełączamy tryb edycji
    }
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setEditedData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSaveChanges = async () => {
    try {
      const response = await fetch('http://localhost/ProfilChange.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          username: user.nick, // Zalogowany użytkownik
          ...editedData, // Edytowane dane
        }),
      });

      const text = await response.text(); // Zmiana na .text(), aby odczytać surową odpowiedź

      console.log('Odpowiedź z serwera:', text); // Zalogowanie odpowiedzi w konsoli

      const data = JSON.parse(text); // Próba parsowania odpowiedzi na JSON

      if (data.status === 'success') {
        setProfileData((prevData) => ({
          ...prevData,
          ...editedData,
        }));
        setIsEditing(false);
      } else {
        console.error('Błąd podczas zapisywania zmian:', data.message);
      }
    } catch (error) {
      console.error('Błąd podczas wysyłania zapytania do serwera:', error);
    }
  };

  if (!user || !profileData) return <div>Loading...</div>;

  return (
    <div className="profile-container">
      <div className="profile-header">
        {console.log(user.id)}
        <div className="profile-info">
        <ProfIMG userId={user.id} />
          <h2>{profileData.Imie} {profileData.Nazwisko}<span className="nickname">@{profileData.Nick}</span></h2>
          <p>{profileData.Email}</p>
        </div>
        {isCurrentUser && (
              <p><strong>Liczba odwiedzin:</strong> {visit}</p>
              )}
      </div>

      <div className="profile-details">
        {isEditing ? (
          <div className="profile-edit">
            <div>
              <label>Imię:</label>
              <input
                type="text"
                name="Imie"
                value={editedData.Imie || ''}
                onChange={handleInputChange}
              />
            </div>
            <label>Nazwisko:</label>
              <input
                type="text"
                name="Nazwisko"
                value={editedData.Nazwisko || ''}
                onChange={handleInputChange}
              />
            <div>
              <label>Nickname:</label>
              <input
                type="text"
                name="Nick"
                value={editedData.Nick || ''}
                onChange={handleInputChange}
              />
            </div>
            <div>
              <label>Email:</label>
              <input
                type="email"
                name="Email"
                value={editedData.Email || ''}
                onChange={handleInputChange}
              />
            </div>
            <div>
              <label>Bio:</label>
              <input
                type="text"
                name="Bio"
                value={editedData.Bio || ''}
                onChange={handleInputChange}
              />
            </div>
            <div>
              <label>Data Urodzenia:</label>
              <input
                type="text"
                name="Data_Urodzenia"
                value={editedData.Data_Urodzenia || ''}
                onChange={handleInputChange}
              />
            </div>
            <div>
              <label>Kraj:</label>
              <input
                type="text"
                name="Kraj"
                value={editedData.Kraj || ''}
                onChange={handleInputChange}
              />
            </div>
            <button className="save-button" onClick={handleSaveChanges}>Zapisz zmiany</button>
            <button className="del-button" onClick={handleEditToggle}>Anuluj</button>
          </div>
        ) : (
          <div className="profile-view">
            <div className="profile-bio">
              <h3>Bio:</h3>
              <p>{profileData.Bio}</p>
            </div>

            <div className="profile-extra">
              <p><strong>Data Urodzenia:</strong> {profileData.Data_Urodzenia}</p>
              <p><strong>Kraj:</strong> {profileData.Kraj}</p>
            </div>
              
            {isCurrentUser && (
              <button className="edit-button" onClick={handleEditToggle}>Edytuj profil</button>
            )}
          </div>
        )}
      </div>
    </div>
  );
};

export default Profile;
