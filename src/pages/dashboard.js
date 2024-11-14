import React, { useEffect } from 'react';
import { Helmet } from 'react-helmet';
import { useUser } from '../context/UserContext'; 
import Logo_male from '../assets/Pictures/logo-error.png'
import './dashboard.css'
const Dashboard = () => {
  const { user, logout } = useUser(); // Pobieramy user i logout z kontekstu
    console.log(user)
  // Sprawdzamy, czy użytkownik jest zalogowany. Jeśli nie, przekierowujemy na stronę główną.
  useEffect(() => {
    if (!user) {
      window.location.href = '/'; // Jeśli użytkownik nie jest zalogowany, przekieruj na stronę główną
    }
  }, [user]);

  return (
    <div>
      <Helmet>
        <title>Fuse</title>
      </Helmet>
      {user ? (
        <div>
          <h1>Witaj, {user.username || 'Nieznany użytkownik'}!</h1>
          <p>Twój adres e-mail: {user.email || 'Brak adresu email'}</p>
          
          {/* Przycisk wylogowania */}
          <button onClick={logout}>Wyloguj się</button>
        </div>
      ) : (
        <p className='Logout-text'><img src={Logo_male} alt ='Fuse-logo'/>Zapraszamy z powrotem... :)!</p>
      )}
    </div>
  );
};

export default Dashboard;
