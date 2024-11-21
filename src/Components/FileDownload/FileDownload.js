import React, { useState, useEffect } from 'react';

const ProfileImage = ({ userId  }) => {
  const [imageUrl, setImageUrl] = useState(null);
  const [error, setError] = useState(null);

  useEffect(() => {
    // Funkcja pobierająca link do zdjęcia profilowego
    const fetchImage = async () => {
      try {
        const response = await fetch(`http://localhost/downloadFile.php?user_id=${userId}`);
        const data = await response.json();

        if (data.status === 'success') {
          setImageUrl(data.link_zdjecia);
        } else {
          setError(data.message || 'Nie znaleziono zdjęcia.');
        }
      } catch (err) {
        setError('Błąd połączenia z serwerem.');
      }
    };

    fetchImage();
  }, [userId]); // Ładowanie zdjęcia przy zmianie userId

  return (
    <div>
      {imageUrl ? (
        <div className="profile-image-container">
          <img src={imageUrl} alt="Zdjęcie profilowe" className="profile-image" />
        </div>
      ) : error ? (
        <p>{error}</p>
      ) : (
        <p>Ładowanie zdjęcia...</p>
      )}
    </div>
  );
};

export default ProfileImage;
