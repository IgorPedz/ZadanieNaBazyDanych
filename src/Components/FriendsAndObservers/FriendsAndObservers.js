import React, { useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faUserFriends, faEye } from '@fortawesome/free-solid-svg-icons';
import '../FriendsAndObservers/FriendsAndObservers.css';

const FriendsAndObservers = ({ handleAdditionalActions }) => {
  const [areFriendsOpen, setAreFriendsOpen] = useState(false); // Stan dla znajomych
  const [areObserversOpen, setAreObserversOpen] = useState(false); // Stan dla obserwatorów

  const friends = [
    { id: 1, username: 'Jan Kowalski', nickname: 'Kowal' },
    { id: 2, username: 'Anna Nowak', nickname: 'Nowakowa' },
  ];

  const observers = [
    { id: 3, username: 'Marek Wiśniewski', nickname: 'Marek' },
    { id: 4, username: 'Karolina Zielińska', nickname: 'Karo' },
  ];

  // Funkcja otwierająca/zamykająca panel znajomych
  const toggleFriendsPanel = () => {
    setAreFriendsOpen(!areFriendsOpen); 
    setAreObserversOpen(false); 
  };
  
  // Funkcja otwierająca/zamykająca panel obserwatorów
  const toggleObserversPanel = () => {
    setAreObserversOpen(!areObserversOpen); // Zmiana stanu panelu obserwatorów
    setAreFriendsOpen(false); 
  };

  // Funkcja otwierająca czat z danym znajomym
  const openChat = (friendUsername) => {
    handleAdditionalActions(friendUsername); // Przekazujemy użytkownika do funkcji, która otworzy czat
  };

  return (
    <div className="Fan-container">
      <div className="buttons">
        {/* Ikona dla znajomych */}
        <button className={`btn ${areFriendsOpen ? 'active' : ''}`} onClick={toggleFriendsPanel}>
          <FontAwesomeIcon icon={faUserFriends} size="lg" />
          <p>Znajomi</p>
        </button>

        {/* Ikona dla obserwatorów */}
        <button className={`btn ${areObserversOpen ? 'active' : ''}`} onClick={toggleObserversPanel}>
          <FontAwesomeIcon icon={faEye} size="lg" />
          <p>Obserwatorzy</p>
        </button>
      </div>

      {/* Panel znajomych */}
      {areFriendsOpen && (
        <div className={`list-section ${areFriendsOpen ? 'open' : ''}`}>
          <h2>Znajomi</h2>
          <ul>
            {friends.map(friend => (
              <li key={friend.id}>
                <span>{friend.username} (@{friend.nickname})</span>
                <button onClick={() => openChat(friend.username)} className="message-btn">
                  Wyślij wiadomość
                </button>
              </li>
            ))}
          </ul>
        </div>
      )}

      {/* Panel obserwatorów */}
      {areObserversOpen && (
        <div className={`list-section ${areObserversOpen ? 'open' : ''}`}>
          <h2>Obserwatorzy</h2>
          <ul>
            {observers.map(observer => (
              <li key={observer.id}>
                <span>{observer.username} (@{observer.nickname})</span>
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
};

export default FriendsAndObservers;
