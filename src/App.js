import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Log from './pages/login'
import Dashboard from './pages/dashboard';
import { UserProvider } from './context/UserContext';
const App = () => {
  return (
    <div>
      <UserProvider>
        <Routes>
          <Route path="/" element={<Log />} />
          <Route path="/dashboard" element={<Dashboard />} />
        </Routes>
      </UserProvider>
    </div>
  );
};

export default App;