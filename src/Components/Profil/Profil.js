import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { useUser } from '../../context/UserContext'; // Kontekst użytkownika
import './Profil.css';

const Profile = () => {
  const { username } = useParams();
  const { user } = useUser(); // Zalogowany użytkownik
  const [profileData, setProfileData] = useState(null);
  const [isEditing, setIsEditing] = useState(false); // Sprawdzamy, czy profil jest w trybie edycji
  const [editedData, setEditedData] = useState({}); // Dane edytowanego profilu

  // Sprawdzamy, czy zalogowany użytkownik może edytować profil
  const isCurrentUser = user && user.username === username;

  useEffect(() => {
    const decodedUsername = decodeURIComponent(username);

    const fetchUserData = async () => {
      try {
        // Symulowane dane użytkownika
        const simulatedData = {
          name: decodedUsername,
          email: `${decodedUsername.toLowerCase().replace(' ', '.')}@example.com`,
          nickname: decodedUsername.split(' ')[0],
          bio: 'Web developer passionate about React and JavaScript.',
          birthdate: '1990-01-01',
          country: 'Polska',
          profilePicture: 'https://i.pravatar.cc/150?img=1',
        };

        setProfileData(simulatedData); // Ustawienie danych użytkownika
      } catch (error) {
        console.error('Error fetching user data:', error);
        setProfileData(null);
      }
    };

    fetchUserData();
  }, [username]);

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

  const handleSaveChanges = () => {
    // W prawdziwej aplikacji tutaj wysyłamy dane na serwer i zapisujemy je w bazie
    setProfileData((prevData) => ({
      ...prevData,
      ...editedData,
    }));
    setIsEditing(false);
  };

  if (!user) return <div>Loading...</div>;

  if (!profileData) return <div>Loading...</div>;

  return (
    <div className="profile-container">
      <div className="profile-header">
        <img
          src={profileData.profilePicture}
          alt="Profile"
          className="profile-picture"
        />
        <div className="profile-info">
          <h2>{profileData.name}<span className="nickname">@{profileData.nickname}</span></h2>
          <p>{profileData.email}</p>
        </div>
      </div>

      <div className="profile-details">
        {/* Tryb edycji */}
        {isEditing ? (
          <div className="profile-edit">
            <div>
              <label>Imię:</label>
              <input
                type="text"
                name="name"
                value={editedData.name || profileData.name}
                onChange={handleInputChange}
              />
            </div>
            <div>
              <label>Nickname:</label>
              <input
                type="text"
                name="nickname"
                value={editedData.nickname || profileData.nickname}
                onChange={handleInputChange}
              />
            </div>
            <div>
              <label>Email:</label>
              <input
                type="email"
                name="email"
                value={editedData.email || profileData.email}
                onChange={handleInputChange}
              />
            </div>
            <div>
              <label>Bio:</label>
              <input
                type="text"
                name="bio"
                value={editedData.bio || profileData.bio}
                onChange={handleInputChange}
              />
            </div>
            <div>
              <label>Data Urodzenia:</label>
              <input
                type="text"
                name="birthdate"
                value={editedData.birthdate || profileData.birthdate}
                onChange={handleInputChange}
              />
            </div>
            <div>
              <label>Kraj:</label>
              <input
                type="text"
                name="country"
                value={editedData.country || profileData.country}
                onChange={handleInputChange}
              />
            </div>
            <button className='save-button' onClick={handleSaveChanges}>Zapisz zmiany</button>
            <button className='del-button' onClick={handleEditToggle}>Anuluj</button>
          </div>
        ) : (
          // Tryb wyświetlania
          <div className="profile-view">
            <div className="profile-bio">
              <h3>Bio:</h3>
              <p>{profileData.bio}</p>
            </div>

            <div className="profile-extra">
              <p><strong>Data Urodzenia:</strong> {profileData.birthdate}</p>
              <p><strong>Kraj:</strong> {profileData.country}</p>
            </div>

            {isCurrentUser && (
              <button className='edit-button' onClick={handleEditToggle}>Edytuj profil</button>
            )}
          </div>
        )}
      </div>
    </div>
  );
};

export default Profile;
