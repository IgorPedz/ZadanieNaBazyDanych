import React from 'react';
import { useNavigate } from 'react-router-dom';  
import './ErrorPage.css'; 
import Logo_Error from '../../assets/Pictures/logo-error.png'

const ErrorPage = ({ errorMessage }) => {
  const navigate = useNavigate();  

  const goHome = () => {
    navigate('/'); 
  };

  return (
    <div className="errorPageContainer">
        <img src={Logo_Error} alt ='Fuse-logo' className='logo'/>
      <h1 className="errorTitle">Coś poszło nie tak...</h1>
      <p className="errorDescription">{errorMessage || "Wystąpił nieoczekiwany błąd. Proszę spróbować ponownie później."}</p>
      <button className="goBackButton" onClick={goHome}>Wróć na stronę główną</button> 
    </div>
  );
};

export default ErrorPage;