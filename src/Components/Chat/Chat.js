import React, { useState, useEffect } from 'react';
import './Chat.css';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faMinus, faExpand} from '@fortawesome/free-solid-svg-icons';

const Chat = ({ friendUsername, onClose }) => {
  const [messages, setMessages] = useState([]);
  const [newMessage, setNewMessage] = useState('');
  const [isMinimized, setIsMinimized] = useState(false); // Nowy stan dla minimalizacji
  
  // Użytkownik aktualnie zalogowany (symulowane dane)
  const currentUser = 'Ty';

  useEffect(() => {
    // Symulujemy załadowanie wiadomości
    const fetchMessages = () => {
      setMessages([
        { sender: 'Jan Kowalski', text: 'Cześć, jak się masz?' },
        { sender: 'Ty', text: 'Dobrze, a Ty?' },
      ]);
    };

    fetchMessages();
  }, [friendUsername]);

  const handleSendMessage = () => {
    if (newMessage) {
      setMessages([...messages, { sender: currentUser, text: newMessage }]);
      setNewMessage('');
    }
  };

  const toggleMinimize = () => {
    setIsMinimized(!isMinimized);
  };

  return (
    <div className={`chat-container ${isMinimized ? 'minimized' : ''}`}>
      <div className="chat-header">
        <h3>Rozmowa z {friendUsername}</h3>
        <div className="chat-header-buttons">
          <button onClick={toggleMinimize} className="minimize-chat">
          <FontAwesomeIcon icon={isMinimized ? faExpand : faMinus} size="lg" />
          </button>
          <button onClick={onClose} className="close-chat">X</button>
        </div>
      </div>

      {!isMinimized && (
        <div className="chat-messages">
          {messages.map((message, index) => (
            <div
              key={index}
              className={`message ${message.sender === currentUser ? 'sent' : 'received'}`}
            >
              <strong>{message.sender}: </strong> {message.text}
            </div>
          ))}
        </div>
      )}

      {!isMinimized && (
        <div className="chat-input">
          <input 
            type="text" 
            value={newMessage}
            onChange={(e) => setNewMessage(e.target.value)}
            placeholder="Napisz wiadomość..."
          />
          <button onClick={handleSendMessage}>Wyślij</button>
        </div>
      )}
    </div>
  );
};

export default Chat;
