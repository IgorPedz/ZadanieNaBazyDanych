import React, { useState, useEffect } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faUserFriends, faEye, faCheck, faTimes } from '@fortawesome/free-solid-svg-icons';
import '../FriendsAndObservers/FriendsAndObservers.css';

const FriendsAndObservers = ({ userId, Profil, Chat}) => {
  const [areFriendsOpen, setAreFriendsOpen] = useState(false); // State for friends panel
  const [areObserversOpen, setAreObserversOpen] = useState(false); // State for followers panel
  const [followers, setFollowers] = useState([]);
  const [following, setFollowing] = useState([]);
  const [friends, setFriends] = useState([]);
  const [pendingRequests, setPendingRequests] = useState([]);

  // Function to fetch follow data from the server
  const fetchFollowData = async () => {
    try {
      const response = await fetch('http://localhost/followers.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ userId })
      });
      const data = await response.json();
      if (data.followers && data.following) {
        setFollowers(data.followers);
        setFollowing(data.following);
      }
    } catch (err) {
      console.error('Error fetching follow data:', err);
    }
  };

  // Fetch the data when the component mounts
  useEffect(() => {
    fetchFollowData();

    const intervalId = setInterval(fetchFollowData, 5000);

    // Clear the interval when the component is unmounted to avoid memory leaks
    return () => clearInterval(intervalId);
  }, [userId]);

  // Function to toggle the friends panel
  const toggleFriendsPanel = () => {
    setAreFriendsOpen(!areFriendsOpen);
    setAreObserversOpen(false);
  };

  // Function to toggle the followers panel
  const toggleObserversPanel = () => {
    setAreObserversOpen(!areObserversOpen);
    setAreFriendsOpen(false);
  };

  // Function to open chat with a friend
  const openChat = (friendUsername,friendID) => {
    Chat(friendUsername,friendID);
  };

  const fetchFriendsData = async () => {
    try {
      const response = await fetch('http://localhost/friends.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ userId })
      });
      const data = await response.json();
      console.log(data);
      if (data.friends) {
        setFriends(data.friends);
      }
      if (data.pending) {
        setPendingRequests(data.pending);
      }
    } catch (err) {
      console.error('Error fetching friends data:', err);
    }
  };

  useEffect(() => {
    fetchFriendsData();

    const intervalId = setInterval(fetchFriendsData, 5000);

    return () => clearInterval(intervalId);
  }, [userId]);

  // Function to accept a friend request
  const acceptFriendRequest = async (friendId) => {
    try {
      const response = await fetch('http://localhost/acceptFriendRequest.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ userId, friendId })
      });
      const data = await response.json();
      if (data.status === 'success') {
        // Update local state to reflect accepted request
        setPendingRequests(prevState => prevState.filter(request => request.ID_uzytkownika !== friendId));
        setFriends(prevState => [...prevState, { ID_uzytkownika: friendId, ...data.friend }]); // Add friend to the list
              }
    } catch (err) {
      console.error('Error accepting the friend request:', err);
    }
  };

  // Function to reject friend request
  const rejectFriendRequest = async (friendId) => {
    try {
      const response = await fetch('http://localhost/declineFriendRequest.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ userId, friendId })
      });
      const data = await response.json();
      if (data.status === 'success') {
        // Update local state to reflect rejected request
        setPendingRequests(prevState => prevState.filter(request => request.ID_uzytkownika !== friendId));
      }
    } catch (err) {
      console.error('Error rejecting the friend request:', err);
    }
  };

  return (
    <div className="Fan-container">
      <div className="buttons">
        <button className={`btn ${areFriendsOpen ? 'active' : ''}`} onClick={toggleFriendsPanel}>
          <FontAwesomeIcon icon={faUserFriends} size="lg" />
          <p>Znajomi</p>
        </button>

        <button className={`btn ${areObserversOpen ? 'active' : ''}`} onClick={toggleObserversPanel}>
          <FontAwesomeIcon icon={faEye} size="lg" />
          <p>Obserwacje</p>
        </button>
      </div>

      {/* Friends Panel */}
      {areFriendsOpen && (
        <div className={`list-section ${areFriendsOpen ? 'open' : ''}`}>
          <h2>Zaproszenia do Znajomych</h2>
          <ul>
            {pendingRequests.length === 0 ? (
              <li>Brak nowych zaproszeń!</li>
            ) : (
              pendingRequests.map((pending) => (
                <li key={pending.ID_uzytkownika}>
                  {pending.Imie} {pending.Nazwisko}
                  <button 
                    className="friend-btn yes"
                    onClick={() => acceptFriendRequest(pending.ID_uzytkownika)}
                  >
                    <FontAwesomeIcon icon={faCheck} size="lg" />
                  </button>
                  <button 
                    className="friend-btn no"
                    onClick={() => rejectFriendRequest(pending.ID_uzytkownika)}
                  >
                    <FontAwesomeIcon icon={faTimes} size="lg" />
                  </button>
                </li>
              ))
            )}
          </ul>

          <h2>Znajomi</h2>
          <ul>
            {friends.length === 0 ? (
              <li>Brak znajomych!</li>
            ) : (
              friends.map((friend) => (
                <li>
                  {console.log(friend)}
                  <span onClick={() => Profil(friend.Nick)} key={friend.ID_uzytkownika}>{friend.Imie} {friend.Nazwisko}</span>
                  <button className='message-btn' onClick={() => openChat(friend.Imie + friend.Nazwisko,friend.ID_uzytkownika)}>
                    Wyślij Wiadomość
                  </button>
                  <button 
                    className="friend-btn no"
                    onClick={() => rejectFriendRequest(friend.ID_uzytkownika)}
                  >
                    Usuń
                  </button>
                </li>
              ))
            )}
          </ul>
        </div>
      )}

      {/* Followers Panel */}
      {areObserversOpen && (
        <div className={`list-section ${areObserversOpen ? 'open' : ''}`}>
          <h2>Obserwujący</h2>
          <ul>
            {followers.length === 0 ? (
              <li>Brak obserwujących.</li>
            ) : (
              followers.map((follower) => (
                <li onClick={() => Profil(follower.Nick)} key={follower.ID_uzytkownika}>
                  {follower.Imie} {follower.Nazwisko}
                </li>
              ))
            )}
          </ul>

          <h2>Obserwowani</h2>
          <ul>
            {following.length === 0 ? (
              <li>Nie obserwujesz nikogo.</li>
            ) : (
              following.map((followed) => (
                <li onClick={() => Profil(followed.Nick)} key={followed.ID_uzytkownika}>
                  {followed.Imie} {followed.Nazwisko}
                </li>
              ))
            )}
          </ul>
        </div>
      )}
    </div>
  );
};

export default FriendsAndObservers;
