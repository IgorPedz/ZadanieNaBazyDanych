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

  const toggleModal = () => {
    setIsModalOpen(!isModalOpen);
    setErrorMessage('');  
  };

  const handleKeyChange = (e) => {
    setAdminKey(e.target.value);
  };

  const goAdmin = (e) => {
    e.preventDefault();  
    const correctKey = 'b1f8a6c9e2d5e04b7f9a'; 

    if (adminKey === correctKey) {
      navigate('/admin');  
    } else {
      setErrorMessage('Niepoprawny klucz zabezpieczeń');  
    }
  };

  return (
    <div>
      <button className="admin-button" onClick={toggleModal}>
        <FontAwesomeIcon icon={faUser} size="2x" />
      </button>

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
              {errorMessage && <div className="error-message">{errorMessage}</div>}  
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
