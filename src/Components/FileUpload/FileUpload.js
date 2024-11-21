import React, { useState } from 'react';
import { useUser } from '../../context/UserContext'
import './FileUpload.css'; // Dodajemy import do pliku CSS

const ProfileImageUploader = () => {
  const [image, setImage] = useState(null);
  const [preview, setPreview] = useState(null);
  const [uploading, setUploading] = useState(false);
  const [message, setMessage] = useState('');
  const { user, logout } = useUser(); 

  const handleImageChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      const imageUrl = URL.createObjectURL(file);
      setImage(file);
      setPreview(imageUrl);
    }
  };

  const handleRemoveImage = () => {
    setImage(null);
    setPreview(null);
  };

  const handleSubmit = async () => {
    if (!image) {
      alert('Proszę wybrać zdjęcie!');
      return;
    }

    const formData = new FormData();
    formData.append('image', image);
    
    try {
      setUploading(true);
      setMessage('Trwa ładowanie...');

      const response = await fetch(`http://localhost/file.php?id=${user.id}}`, {
        method: 'POST',
        body: formData,
      });
      console.log(response)
      const result = await response.json();
      setUploading(false);

      if (response.ok) {
        setMessage('Zdjęcie zostało pomyślnie zapisane!');
      } else {
        setMessage(result.message || 'Wystąpił błąd podczas przesyłania.');
      }
    } catch (error) {
      setUploading(false);
      setMessage('Wystąpił błąd, spróbuj ponownie.');
    }
  };

  return (
    <div className="profile-image-uploader">
      <h2>Załaduj zdjęcie profilowe</h2>

      {preview ? (
        <div className="image-preview">
          <img src={preview} alt="Podgląd zdjęcia profilowego" />
          <button className="remove-btn" onClick={handleRemoveImage}>×</button>
        </div>
      ) : (
        <div>
          <input type="file" id="imageInput" accept="image/*" onChange={handleImageChange} />
          <label htmlFor="imageInput">Wybierz zdjęcie</label>
        </div>
      )}

      <div>
        <button onClick={handleSubmit} disabled={!image || uploading}>
          {uploading ? 'Ładowanie...' : 'Zapisz zdjęcie'}
        </button>
      </div>

      {message && <p>{message}</p>}
    </div>
  );
};

export default ProfileImageUploader;
