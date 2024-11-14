// Modal.js
import React from 'react';
import './Modal.css';

const Modal = ({ message, closeModal }) => (
  <div className="modal-overlay" onClick={closeModal}>
    <div className="modal-content" onClick={(e) => e.stopPropagation()}>
      <p>{message}</p>
      <button onClick={closeModal}>Zamknij</button>
    </div>
  </div>
);

export default Modal;

