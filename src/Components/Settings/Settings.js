import React from 'react';
import './Settings.css';

const SettingsModal = ({ isVisible, onClose }) => {
  if (!isVisible) return null;  

  return (
    <div className="overlay">
      <div className="content">
        <div className="header">
          <h2>Ustawienia</h2>
          <button onClick={onClose} className="close-btn">X</button>
        </div>
        <div className="body">
          <p>Tu bedą ustawienia :P</p>
        </div>
        <div className="footer">
          <button className='save-settings' onClick={onClose}>Zapisz</button>
        </div>
      </div>
    </div>
  );
};

export default SettingsModal;
