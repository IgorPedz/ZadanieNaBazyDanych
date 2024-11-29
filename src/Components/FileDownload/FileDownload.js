import React, { useState, useEffect } from 'react';

const ProfileImage = ({ userId }) => {
  const [imageUrl, setImageUrl] = useState(null);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true); // State for loading

  useEffect(() => {
    // Funkcja pobierająca link do zdjęcia profilowego
    const fetchImage = async () => {
      try {
        const response = await fetch(`http://localhost/downloadFile.php?user_id=${userId}`);

        if (!response.ok) {
          // Handling non-200 responses (e.g., 404, 500)
          throw new Error(`Błąd: ${response.statusText}`);
        }

        const data = await response.json();

        if (data.status === 'success') {
          setImageUrl(data.link_zdjecia);
          setError(null); // Reset error if successful
        } else {
          setError(data.message || 'Nie znaleziono zdjęcia.');
        }
      } catch (err) {
        // Improved error handling
        setError(err.message || 'Błąd połączenia z serwerem.');
      } finally {
        setLoading(false); // Set loading to false when done
      }
    };

      fetchImage();
  
      const intervalId = setInterval(fetchImage, 5000);

    return () => {
      setLoading(false); // Cleanup in case the component is unmounted
      clearInterval(intervalId)
    };
  }, [userId]); // Ładowanie zdjęcia przy zmianie userId
  
  return (
    <div>
      {loading ? (
        <p>Ładowanie zdjęcia...</p>
      ) : error ? (
        <p>{error}</p>
      ) : imageUrl ? (
        <div className="profile-image-container">
          <img src={`http://localhost/${imageUrl}`} alt="Zdjęcie profilowe" className="profile-image" />
        </div>
      ) : (
        <img src='http://localhost/uploads/basic.jfif' alt="Zdjęcie profilowe" className="profile-image" />
      )}
    </div>
  );
};

export default ProfileImage;
