import React, { useState, useEffect } from 'react';
import './Chat.css';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faMinus, faExpand } from '@fortawesome/free-solid-svg-icons';

const Chat = ({ currentName, currentUserId, friendUserId, friendUsername, onClose }) => {
  const [messages, setMessages] = useState([]);
  const [newMessage, setNewMessage] = useState('');
  const [isMinimized, setIsMinimized] = useState(false);

  // Fetch messages between the logged-in user and the friend
  useEffect(() => {
    const fetchMessages = async () => {
      const response = await fetch(
        `http://localhost/Chat.php?senderId=${currentUserId}&receiverId=${friendUserId}`
      );
      const data = await response.json();
      setMessages(data);
    };

    fetchMessages();
    const intervalId = setInterval(fetchMessages, 5000);

    // Clear the interval when the component is unmounted to avoid memory leaks
    return () => clearInterval(intervalId);
  }, [currentUserId, friendUserId]);
  // Send a new message to the server
  const handleSendMessage = async () => {
    if (newMessage.trim()) {
      const response = await fetch('http://localhost/Wyslij.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
          senderId: currentUserId,
          receiverId: friendUserId,
          text: newMessage,
        }),
      });

      const data = await response.json();

      if (data.status === 'success') {
        // Update messages with the new one
        setMessages((prevMessages) => [
          ...prevMessages,
          { sender_username: 'Ty', text: newMessage },
        ]);
        setNewMessage('');
      } else {
        console.error('Error sending message:', data.error);
      }
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
              className={`message ${message.sender_username === currentName ? 'sent' : 'received'}`}
            >
              <strong>{message.sender_username}: </strong> {message.Tresc}
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
