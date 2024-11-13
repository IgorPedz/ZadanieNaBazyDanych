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
  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setShowModal(false);

    // Basic validation
    if (!email || !password || (!isLogin && (!confirmPassword || password !== confirmPassword))) {
      setError('Proszę wypełnić wszystkie pola poprawnie!');
      setShowModal(true);
      return;
    }

    // Prepare data to send to backend
    const data = {
      email,
      password,
      ...(isLogin ? {} : { username, confirmPassword })
    };

    try {
      const response = await fetch('http://localhost/auth.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
      });

      const result = await response.json();
      
      if (result.error) {
        setError(result.message);
        setShowModal(true);
      } else {
        // handle success (e.g. store user data or redirect)
        console.log(result.message);
      }
    } catch (err) {
      setError('Wystąpił błąd po stronie serwera.');
      setShowModal(true);
    }
};


  // Handle reset password form submission
  const handleResetSubmit = async (e) => {
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

    try {
      const response = await fetch('http://localhost/reset-password.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email: resetEmail })
      });
      const result = await response.json();

      if (result.error) {
        setError(result.error);
        setShowModal(true);
      } else {
        setResetSuccess(true);
      }
    } catch (err) {
      setError('Wystąpił błąd po stronie serwera.');
      setShowModal(true);
    }
  };

  // Close any modal
  const closeModal = () => {
    setShowModal(false);
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
              <div className="forgot-div">
                <button type="button" className="forgot-password" onClick={() => setShowResetModal(true)}>
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
    </div>
  );
};

export default Form;
