// Modal.js
import React from 'react';
import './Modal.css';

const Modal = ({ message, onClose }) => {
  return (
    <div className="modal-overlay">
      <div className="modal">
        <h2>Błąd</h2>
        <p>{message}</p>
        <button onClick={onClose} className="modal-close-button">Zamknij</button>
      </div>
    </div>
  );
};

export default Modal;
