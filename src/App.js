import React from 'react';
import { Routes, Route } from 'react-router-dom';
import { UserProvider } from './context/UserContext';

import Log from './pages/Login/login'
import Dashboard from './pages/Main/dashboard';
import AdminPage from './pages/Admin/AdminPage'
import ErrorPage from './pages/Error/ErrorPage'
const App = () => {
  return (
    <div>
      <UserProvider>
        <Routes>
          <Route path="/" element={<Log />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/dashboard/:username" element={<Dashboard />} />
          <Route path="/admin" element={<AdminPage />} />
          <Route path="/*" element={<ErrorPage />} />
        </Routes>
      </UserProvider>
    </div>
  );
};

export default App;