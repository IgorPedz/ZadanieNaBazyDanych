import React, { useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faUser } from '@fortawesome/free-solid-svg-icons';
import './Option.css';
import { useNavigate } from 'react-router-dom'; 

const SettingsButton = () => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [adminKey, setAdminKey] = useState('');  
  const [errorMessage, setErrorMessage] = useState('');  
  const navigate = useNavigate();  

  // Funkcja do otwierania/zakrywania panelu ustawień
  const toggleModal = () => {
    setIsModalOpen(!isModalOpen);
    setErrorMessage('');  
  };

  // Funkcja do obsługi zmiany w polu input
  const handleKeyChange = (e) => {
    setAdminKey(e.target.value);
  };

  // Funkcja do logowania się jako admin
  const goAdmin = (e) => {
    e.preventDefault();  // Zapobiegamy domyślnemu zachowaniu formularza
    const correctKey = 'b1f8a6c9e2d5e04b7f9a';  // Przykładowy klucz zabezpieczeń

    if (adminKey === correctKey) {
      navigate('/admin');  // Jeśli klucz jest poprawny, przechodzimy na stronę admina
    } else {
      setErrorMessage('Niepoprawny klucz zabezpieczeń');  // Jeśli klucz jest niepoprawny, wyświetlamy błąd
    }
  };

  return (
    <div>
      {/* Ikona zębatki */}
      <button className="admin-button" onClick={toggleModal}>
        <FontAwesomeIcon icon={faUser} size="2x" />
      </button>

      {/* Modal ustawień */}
      {isModalOpen && (
        <div className="settings-modal-overlay" onClick={toggleModal}>
          <div className="settings-modal" onClick={(e) => e.stopPropagation()}>
            <h2 className='header'>Admin</h2>
            <form onSubmit={goAdmin}>
              <div className="setting-option">
                <label className='option-row'>
                  Zaloguj się jako admin: 
                  <input
                    type="text"
                    className="admin-key-input"
                    placeholder="Wprowadź klucz zabezpieczeń"
                    value={adminKey}
                    onChange={handleKeyChange}
                  />
                </label>
              </div>
              <div className="setting-option">
                <button type="submit" className='option-button'>Zaloguj</button>
              </div>
              {errorMessage && <div className="error-message">{errorMessage}</div>}  {/* Wyświetlamy komunikat o błędzie */}
            </form>
            <button className="close-button" onClick={toggleModal}>
              Zamknij
            </button>
          </div>
        </div>
      )}
    </div>
  );
};

export default SettingsButton;
