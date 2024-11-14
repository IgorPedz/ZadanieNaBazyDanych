import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Log from './pages/login'
import Dashboard from './pages/dashboard';
import { UserProvider } from './context/UserContext';
import AdminPage from './pages/AdminPage'
import ErrorPage from './pages/ErrorPage'
const App = () => {
  return (
    <div>
      <UserProvider>
        <Routes>
          <Route path="/" element={<Log />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/admin" element={<AdminPage />} />
          <Route path="/*" element={<ErrorPage />} />
        </Routes>
      </UserProvider>
    </div>
  );
};

export default App;