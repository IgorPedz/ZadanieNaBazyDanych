import React, { useState } from 'react';
import './FileUpload.css'
const FileUpload = ({ userId }) => {  // Assuming userId is passed as a prop
  const [file, setFile] = useState(null);
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(null);
  console.log(userId)
  const handleFileChange = (e) => {
    setFile(e.target.files[0]);
    setError(null);  // Reset error state if a new file is selected
  };

  const handleUpload = () => {
    if (!file) {
      setError("Najpierw wybierz plik!");
      return;
    }

    const formData = new FormData();
    formData.append('file', file);
    formData.append('user_id', userId);  // Pass user ID along with the file

    fetch('http://localhost/prof.php', {
      method: 'POST',
      body: formData,
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.status === 'success') {
          setSuccess("Profilowe pomyślnie zmienione!");
        } else {
          setError(data.message || 'Wystąpił błąd :(');
        }
      })
      .catch((err) => {
        setError('Wystąpił błąd :(');
        console.error('Wystąpił błąd :(:', err);
      });
  };

  return (
<div className="upload-container">
      <h3 className="upload-heading">Zmień profilowe</h3>
      <input 
        type="file" 
        onChange={handleFileChange} 
        className="file-input" 
      />
      <button onClick={handleUpload} className="upload-button">Zmień</button>

      {error && <p className="error-message">{error}</p>}
      {success && <p className="success-message">{success}</p>}
    </div>
  );
};

export default FileUpload;
