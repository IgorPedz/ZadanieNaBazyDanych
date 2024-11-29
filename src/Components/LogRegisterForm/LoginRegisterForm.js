import React, { useState } from 'react';
import Modal from '../Modals/Modal'; 
import './LoginRegisterForm.css';
import $ from 'jquery'; 
import { useNavigate } from 'react-router-dom'; 
import { useUser } from '../../context/UserContext';
import { Helmet } from 'react-helmet';
import Cookies from 'js-cookie';

const Form = () => {
  const [isLogin, setIsLogin] = useState(true);
  const [email, setEmail] = useState('');
  const [username, setUsername] = useState('');
  const [surrname, setSurrname] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [error, setError] = useState('');
  const [successMessage, setSuccessMessage] = useState('');
  const [showModal, setShowModal] = useState(false);
  const [showResetModal, setShowResetModal] = useState(false);
  const [resetEmail, setResetEmail] = useState('');
  const [setResetSuccess] = useState(false);
  const [visitCount, setVisitCount] = useState(0); // Licznik wizyt
  const [country, setCountry] = useState('');  // New state for country
  const [dob, setDob] = useState('');  // New state for date of birth

  const { login } = useUser();
  window.history.pushState(null, '', window.location.href);
  window.history.replaceState(null, '', window.location.href);
  const navigate = useNavigate();

  const toggleForm = () => {
    setError('');
    setSuccessMessage('');
    setShowModal(false);
    setIsLogin(!isLogin);
  };

  const validatePassword = (password) => {
    const minLength = 8;
    const specialCharPattern = /[!@#$%^&*(),.?":{}|<>]/; 
    return password.length >= minLength && specialCharPattern.test(password);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    setError('');
    setSuccessMessage('');
    setShowModal(false);

    if (!validatePassword(password)) {
      setError('Hasło musi mieć co najmniej 8 znaków i zawierać przynajmniej jeden znak specjalny.');
      setShowModal(true);
      return;
    }

    const data = {
      email,
      password,
      country,
      dob,
      ...(isLogin ? {} : { username, surrname, confirmPassword })
    };

    $.ajax({
      url: 'http://localhost/auth.php', 
      method: 'POST',
      contentType: 'application/json',
      data: JSON.stringify(data),
      success: (response) => {
        if (response.error) {
          setError(response.message); 
          setSuccessMessage(''); 
        } else {
          setSuccessMessage(response.message);
          setError(''); 
          console.log(response)
          if (isLogin) {
            const userId = response.username.ID_uzytkownika;
            
            // Pobranie aktualnego liczniku odwiedzin z ciasteczek
            let currentVisitCount = Cookies.get(`visitCount_user_${userId}`);
            currentVisitCount = currentVisitCount ? parseInt(currentVisitCount) : 0;
            
            // Zwiększenie licznika o 1
            currentVisitCount += 1;
            
            // Ustawienie ciasteczka z nową liczbą odwiedzin
            Cookies.set(`visitCount_user_${userId}`, currentVisitCount, { expires: 365 });
            
            login({ username: response.username.Imie,  nameuser: response.username.Nazwisko, nick: response.username.Nick, id: response.username.ID_uzytkownika });
            navigate('/dashboard'); 
          }
        }
        setShowModal(true); 
      },
      error: (xhr, status, error) => {
        console.error('AJAX request failed:', status, error);
        setError('Wystąpił błąd po stronie serwera.');
        setShowModal(true); 
      }
    });
  };

  const handleResetSubmit = (e) => {
    e.preventDefault();

    if (!resetEmail) {
      setError('Proszę podać adres email!');
      return;
    }

    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (!emailRegex.test(resetEmail)) {
      setError('Podaj poprawny adres email!');
      return;
    }

    $.ajax({
      url: 'http://localhost/password_reset/reset_password.php',
      method: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({ email: resetEmail }),
      success: (result) => {
        // Sprawdzenie, czy odpowiedź jest w formacie JSON i próba jej parsowania
        try {
          console.log("Otrzymana odpowiedź z serwera:", result);  // Logowanie odpowiedzi z serwera
          const response = JSON.parse(result);  // Parsowanie odpowiedzi JSON
          console.log("Odpowiedź w formacie JSON:", response);  // Logowanie przetworzonej odpowiedzi JSON
    
          if (response.status === 'success') {
            // Jeśli odpowiedź zawiera status success, zamykamy modal
            console.log("Operacja zakończona sukcesem.");
            setShowResetModal(false);
          } else {
            // Jeśli odpowiedź zawiera błąd, ustawiamy komunikat o błędzie
            setError(response.message || 'Wystąpił błąd.');
          }
        } catch (error) {
          // Jeżeli odpowiedź nie jest poprawnym JSON-em
          console.error("Błąd parsowania odpowiedzi:", error);
          setError('Nie udało się przetworzyć odpowiedzi z serwera.');
        }
      },
      error: (err) => {
        console.error("Błąd przy wysyłaniu zapytania:", err);  // Logowanie błędu AJAX
        setError('Wystąpił błąd po stronie serwera.');
      }
    });
  };

  const closeModal = () => {
    setShowModal(false);
  };

  const closeResetModal = () => {
    setShowResetModal(false);
  };

  return (
    <div className="form-container">
      <Helmet>
        <title>{isLogin ? `Fuse - Logowanie` : 'Fuse - Rejestracja'}</title>
      </Helmet>
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

      <div className={`form-content ${isLogin ? 'form-show-login' : 'form-show-register'}`}>
        <h2>{isLogin ? 'Logowanie' : 'Rejestracja' }</h2>
        <form onSubmit={handleSubmit}>
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
              <div className="forgot-div">
                <button type="button" className="forgot-password" onClick={() => setShowResetModal(true)}>
                  Zapomniałeś hasła?
                </button>
              </div>
            </>
          ) : (
            <>
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
                <label htmlFor="surrname">Nazwisko</label>
                <input
                  type="text"
                  id="surrname"
                  value={surrname}
                  onChange={(e) => setSurrname(e.target.value)}
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
              <div className="form-group">
                <label htmlFor="country">Kraj</label>
                <input
                  type="text"
                  id="country"
                  value={country}
                  onChange={(e) => setCountry(e.target.value)}
                  required
                />
              </div>
              <div className="form-group">
                <label htmlFor="dob">Data urodzenia</label>
                <input
                  type="date"
                  id="dob"
                  value={dob}
                  onChange={(e) => setDob(e.target.value)}
                  required
                />
              </div>
            </>
          )}

          {/* Przycisk formularza */}
          <button
            type="submit"
            className="form-submit"
            disabled={
              !email || 
              !password || 
              (!isLogin && (!confirmPassword || password !== confirmPassword)) // Sprawdzanie, czy hasła się zgadzają przy rejestracji
            }
          >
            {isLogin ? 'Zaloguj się' : 'Zarejestruj się'}
          </button>
        </form>
      </div>

      {showModal && <Modal message={error || successMessage} closeModal={closeModal} />}
      {successMessage && <div className="success-message">{successMessage}</div>}
      {showResetModal && (
        <div className="reset-password-overlay">
          <div className="reset-password-modal">
            <h2>Resetowanie Hasła</h2>
            <form onSubmit={handleResetSubmit}>
              <div className="form-group">
                <label htmlFor="resetEmail">Adres e-mail</label>
                <input
                  type="email"
                  id="resetEmail"
                  value={resetEmail}
                  onChange={(e) => setResetEmail(e.target.value)}
                  required
                />
              </div>
              <button type="submit" className="form-submit">
                Zresetuj hasło
              </button>
              <button type="button" onClick={closeResetModal} className="cancel-button">
                Anuluj
              </button>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};

export default Form;
