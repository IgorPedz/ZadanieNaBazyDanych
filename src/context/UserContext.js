import React, { createContext, useState, useEffect, useContext } from 'react';

const UserContext = createContext();

export const UserProvider = ({ children }) => {
  const [user, setUser] = useState(null);

  // Przy pierwszym renderze, sprawdź czy są zapisane dane użytkownika w localStorage
  useEffect(() => {
    const storedUser = localStorage.getItem('user');
    if (storedUser) {
      setUser(JSON.parse(storedUser)); // Jeśli dane są w localStorage, ustaw je w stanie
    }
  }, []);

  // Funkcja logowania - zapisuje dane użytkownika w stanie i localStorage
  const login = (userData) => {
    setUser(userData);
    localStorage.setItem('user', JSON.stringify(userData)); // Zapisuje dane w localStorage
  };

  // Funkcja wylogowania - usuwa dane użytkownika z stanu i localStorage
  const logout = () => {
    setUser(null);
    localStorage.removeItem('user'); // Usuwa dane użytkownika z localStorage
  };
  // Funkcja, która wysyła zapytanie do backendu PHP, aby uzyskać userID na podstawie e-maila

  return (
    <UserContext.Provider value={{ user, login, logout }}>
      {children}
    </UserContext.Provider>
  );
};

export const useUser = () => useContext(UserContext);
