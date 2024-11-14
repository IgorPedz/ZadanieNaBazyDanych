import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Form from '../Components/LogRegisterForm/LoginRegisterForm';
import Snowfall from '../Components/Snowfall/Snowfall';
import Motto from '../Components/Motto/motto';
import './login.css';

const Login = () => {
  return (
    <div className="login-container">
      <Snowfall />
      <div className="content-container">
        <Motto />
        <Form />
      </div>
    </div>
  );
};

export default Login;
