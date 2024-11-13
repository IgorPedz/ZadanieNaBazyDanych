import React, { useState } from 'react';
import Modal from '../Modals/Modal'; // Assuming you have a Modal component for error messages
import './LoginRegisterForm.css';

const Form = () => {
  const [isLogin, setIsLogin] = useState(true);
  const [email, setEmail] = useState('');
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [error, setError] = useState('');
  const [showModal, setShowModal] = useState(false);
  const [showResetModal, setShowResetModal] = useState(false);
  const [resetEmail, setResetEmail] = useState('');
  const [resetSuccess, setResetSuccess] = useState(false);

  // Toggle form between Login and Register
  const toggleForm = () => {
    setError('');
    setShowModal(false);
    setIsLogin(!isLogin);
  };

  // Handle form submission (Login or Register)
  const handleSubmit = (e) => {
    e.preventDefault();
  
    // Clear previous error when starting new validation
    setError('');
    setShowModal(false);
  
    // Basic validation
    if (!email || !password || (!isLogin && (!confirmPassword || password !== confirmPassword))) {
      setError('Proszę wypełnić wszystkie pola poprawnie!');
      setShowModal(true);
      return;
    }
  
    // Add email format validation
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (!emailRegex.test(email)) {
      setError('Podaj poprawny adres email!');
      setShowModal(true);
      return;
    }

    // Logging and submitting the form (you could replace this with an API call)
    console.log('Formularz wysłany');
 
  };
  

  // Handle reset password form submission
  const handleResetSubmit = (e) => {
    e.preventDefault();

    if (!resetEmail) {
      setError('Proszę podać adres email!');
      setShowModal(true);
      return;
    }

    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (!emailRegex.test(resetEmail)) {
      setError('Podaj poprawny adres email!');
      setShowModal(true);
      return;
    }

    // Simulate successful reset request (In a real app, you'd call an API here)
    setResetSuccess(true);
    setShowResetModal(false);
  };

  // Close any modal
  const closeModal = () => {
    setShowModal(false);
  };

  // Show the password reset modal
  const openResetModal = () => {
    setError('');
    setShowModal(false);
    setShowResetModal(true);
  };

  // Close reset modal
  const closeResetModal = () => {
    setShowResetModal(false);
  };

  return (
  <div className="form-container">
      {/* Toggle buttons between Login and Register */}
      <div className="form-buttons">
        <button
          className={`toggle-button ${isLogin ? 'active' : ''}`}
          onClick={toggleForm}
        >
          Logowanie
        </button>
        <button
          className={`toggle-button ${!isLogin ? 'active' : ''}`}
          onClick={toggleForm}
        >
          Rejestracja
        </button>
      </div>

      {/* Login / Register form content */}
      <div className={`form-content ${isLogin ? 'form-show-login' : 'form-show-register'}`}>
        <h2>{isLogin ? 'Logowanie' : 'Rejestracja'}</h2>

        <form onSubmit={handleSubmit}>
          {/* Login form fields */}
          {isLogin ? (
            <>
              <div className="form-group">
                <label htmlFor="email">E-mail</label>
                <input
                  type="email"
                  id="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  required
                />
              </div>
              <div className="form-group">
                <label htmlFor="password">Hasło</label>
                <input
                  type="password"
                  id="password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  required
                />
              </div>
              {/* Forgot Password link */}
              <div className='forgot-div'>
                <button type="button" className="forgot-password" onClick={openResetModal}>
                  Zapomniałeś hasła?
                </button>
              </div>
            </>
          ) : (
            <>
              {/* Registration form fields */}
              <div className="form-group">
                <label htmlFor="username">Imię</label>
                <input
                  type="text"
                  id="username"
                  value={username}
                  onChange={(e) => setUsername(e.target.value)}
                  required
                />
              </div>
              <div className="form-group">
                <label htmlFor="surname">Nazwisko</label>
                <input
                  type="text"
                  id="surname"
                  required
                />
              </div>
              <div className="form-group">
                <label htmlFor="email">Adres e-mail</label>
                <input
                  type="email"
                  id="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  required
                />
              </div>
              <div className="form-group">
                <label htmlFor="password">Hasło</label>
                <input
                  type="password"
                  id="password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  required
                />
              </div>
              <div className="form-group">
                <label htmlFor="confirmPassword">Powtórz hasło</label>
                <input
                  type="password"
                  id="confirmPassword"
                  value={confirmPassword}
                  onChange={(e) => setConfirmPassword(e.target.value)}
                  required
                />
              </div>
            </>
          )}

          <button type="submit" className="form-submit" disabled={!email || !password || (!isLogin && !confirmPassword)}>
            {isLogin ? 'Zaloguj się' : 'Zarejestruj się'}
          </button>
        </form>
      </div>

      {/* Modal wyświetlający błąd */}
      {showModal && <Modal message={error} onClose={closeModal} />}

      {/* Reset Password Modal */}
      {showResetModal && (
        <div className="modal">
          <div className="modal-content">
            <h3>Resetowanie hasła</h3>
            <p>Podaj adres e-mail, na który wyślemy link do resetowania hasła:</p>
            <form onSubmit={handleResetSubmit}>
              <div className="form-group">
                <label htmlFor="resetEmail">E-mail</label>
                <input
                  type="email"
                  id="resetEmail"
                  value={resetEmail}
                  onChange={(e) => setResetEmail(e.target.value)}
                  required
                />
              </div>
              <button type="submit" className="form-forgot">
                Wyślij link
              </button>
              <button type="button" className="form-forgot" onClick={closeResetModal}>
                Anuluj
              </button>
            </form>
            {resetSuccess && <p className="success-message">Link do resetowania hasła został wysłany na Twój e-mail!</p>}
          </div>
        </div>
      )}
    </div>
  );
};

export default Form;
