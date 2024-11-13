import React from 'react';
import Snowfall from './Components/Snowfall/Snowfall'; // Efekt śniegu
import LoginRegisterForm from './Components/LogRegisterForm/LoginRegisterForm'; // Formularz logowania/rejestracji
import Motto from './Components/Motto/motto' // motto pod obrazkiem
import './globalstyles/App.css'; // Globalne style


function App() {
  return (
    <div className="container">
      <div className='app'>
      <Snowfall /> {/* Efekt spadającego śniegu */}
        <Motto />
        <LoginRegisterForm /> {/* Formularz logowania/rejestracji */}
      </div>

    </div>
    
  );
}

export default App;