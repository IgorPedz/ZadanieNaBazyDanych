import React from 'react';
import ReactDOM from 'react-dom';
import './globalstyles/index.css'; // Import globalnych stylów
import App from './App'; // Import głównego komponentu aplikacji
import reportWebVitals from './reportWebVitals'; // Opcjonalnie, do analizy wydajności

ReactDOM.render(
  <React.StrictMode>
    <App /> {/* Aplikacja */}
  </React.StrictMode>,
  document.getElementById('root') // Renderowanie aplikacji w elemencie root
);

// Jeśli chcesz mierzyć wydajność aplikacji, użyj reportWebVitals
reportWebVitals();