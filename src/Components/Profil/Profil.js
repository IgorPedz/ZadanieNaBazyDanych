import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { useUser } from '../../context/UserContext'; // User context
import ProfIMG from '../../Components/FileDownload/FileDownload';
import File from '../FileUpload/FileUpload'
import './Profil.css';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faComment } from '@fortawesome/free-solid-svg-icons';
import Like from '../LikeButton/LikeButton'
import LikeComment from '../LikeComment/LikeComm'
import Modal from '../Modals/Modal'
const Profile = ({visit}) => {
  const { username } = useParams();
  const { user } = useUser(); // Logged in user
  const [profileData, setProfileData] = useState(null);
  const [isEditing, setIsEditing] = useState(false); // Edit mode flag
  const [editedData, setEditedData] = useState({}); // Edited profile data
  const [setVisitCount] = useState(0); // Visit count
  const [userID, setUserID] = useState(null); // User ID
  const [posts, setPosts] = useState([]); // Posts
  const [isFriend, setIsFriend] = useState(false);
  const [message, setMessage] = useState(""); // Wiadomość statusu operacji
  const [isFollowing, setIsFollowing] = useState(false);
  const [commentsVisibility, setCommentsVisibility] = useState({});

  const [showModal, setShowModal] = useState(false);
  const [error, setError] = useState('');

  const isCurrentUser = user && user.nick === username; // Check if the profile belongs to the logged in user
  const formatDate = (date) => {
    const validDate = new Date(date);
  
    // Check if the date is valid
    if (isNaN(validDate)) {
      return 'Niepoprawna data';
    }
  
    return new Intl.DateTimeFormat('pl-PL', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    }).format(validDate);
  };
  const handleToggleComments = (postId) => {
    setCommentsVisibility(prevState => ({
      ...prevState,
      [postId]: !prevState[postId]
    }));
  };

  useEffect(() => {
    const fetchUserData = async () => {
      try {
        const response = await fetch(`http://localhost/Profil.php?username=${username}`);
        const data = await response.json();
        if (data.status === 'success') {
          setProfileData(data.data); // Set user data
          setEditedData(data.data); // Set initial edited data
  
          const ID = data.data.ID_uzytkownika;
          console.log('Profil: '+data.data.ID_uzytkownika)
          setUserID(ID);  // Save user ID to state
  
          if (isCurrentUser) {
            setVisitCount(data.data.visitCount || 0); // Set visit count
          }
        } else {
          console.error('Error fetching data:', data.message);
        }
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };
  
    fetchUserData();
    
  }, [username, user.nick, isCurrentUser]);
  useEffect(() => {
    if (userID) {
      fetchPosts(userID);  // Fetch posts after userID is set
    }
  }, [userID]);  // This effect will run when `userID` changes
  
  const fetchPosts = async (ID) => {
    try {
      const response = await fetch(`http://localhost/GetUserPosts.php?user_id=${ID}`); // Poprawiony parametr URL
      const data = await response.json();
      console.log(data);
  
      // Sprawdzanie, czy odpowiedź zawiera posty
      if (Array.isArray(data) && data.length > 0) {
        setPosts(data); // Ustawienie danych postów
      } else {
        console.error('No posts found or error fetching posts:', data.error || 'Unknown error');
      }
    } catch (error) {
      console.error('Error fetching posts:', error);
    }
  };
  
  const closeModal = () => {
    setShowModal(false);
  };


  const handleEditToggle = () => {
    if (isCurrentUser) {
      setIsEditing((prev) => !prev); // Toggle edit mode
    }
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setEditedData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSaveChanges = async () => {
    try {
      const response = await fetch('http://localhost/ProfilChange.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          username: user.nick,
          ...editedData,
        }),
      });

      const text = await response.text();
      const data = JSON.parse(text);

      if (data.status === 'success') {
        setProfileData((prevData) => ({
          ...prevData,
          ...editedData,
        }));
        setIsEditing(false);
      } else {
        console.error('Error saving changes:', data.message);
      }
    } catch (error) {
      console.error('Error sending request to server:', error);
    }
  };

  const checkIfFollowing = async () => {
    try {
      const response = await fetch('http://localhost/follow-check.php', {  // Endpoint sprawdzający, czy użytkownik obserwuje
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          followerId: userID,
          followedId: user.id,
        }),
      });

      const data = await response.json();
      if (data.isFollowing) {
        console.log("Użytkownik już obserwuje!");
        setIsFollowing(true);
      } else {
        console.log("Użytkownik nie obserwuje.");
        setIsFollowing(false);
      }
    } catch (err) {
      console.error('Błąd przy sprawdzaniu statusu obserwowania:', err);
    }
  };

  // Zaktualizuj status obserwowania przy załadowaniu komponentu
  useEffect(() => {
    // Sprawdzanie localStorage przed pierwszym renderowaniem
    const savedFollowState = localStorage.getItem(`follow_${user.id}_${userID}`);
    if (savedFollowState !== null) {
      setIsFollowing(JSON.parse(savedFollowState));
    } else {
      checkIfFollowing(); // Jeżeli nie ma w localStorage, sprawdź stan w bazie
    }
  }, [user.id, userID]);

  useEffect(() => {
    // Sprawdzanie, czy stan obserwowania jest zapisany w localStorage
    const savedFollowState = localStorage.getItem(`follow_${user.id}_${userID}`);
    if (savedFollowState !== null) {
      setIsFollowing(JSON.parse(savedFollowState)); // Jeśli zapisano stan, ustawiamy go
    }
  }, [user.id, userID]);
  useEffect(() => {
    const savedFriendRequestState = localStorage.getItem(`friendRequestSent_${user.id}_${userID}`);
    if (savedFriendRequestState !== null) {
      setIsFriend(JSON.parse(savedFriendRequestState)); // Jeżeli zapisano stan, ustawiamy go
    }
  }, [user.id, userID]);
  const handleFollow = async () => {
    try {
      const url = isFollowing ? 'http://localhost/unfollow.php' : 'http://localhost/follow.php';  // Wybór odpowiedniego endpointu
      const response = await fetch(url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          followerId: userID,
          followedId: user.id,
        }),
      });

      const data = await response.json();
      console.log('Odpowiedź z serwera:', data);  // Zaloguj odpowiedź z backendu

      if (data.message === 'Użytkownik został zaobserwowany.' || data.message === 'Obserwowanie zostało usunięte.') {
        const newFollowState = !isFollowing; // Zmieniamy stan na przeciwstawny
        setIsFollowing(newFollowState); // Ustawiamy stan w aplikacji

        // Zapiszemy nowy stan w localStorage
        localStorage.setItem(`follow_${user.id}_${userID}`, JSON.stringify(newFollowState));
        setShowModal(true)
        setError(data.message)
      } else {
        alert(data.error || 'Wystąpił problem.');
      }
    } catch (err) {
      console.error('Błąd przy próbie zapisu obserwacji:', err);
    }
  };

  const handleFriendRequest = async (userId, profileId) => {
    try {
      const url = isFriend
        ? "http://localhost/removeFriend.php"
        : "http://localhost/sendFriendRequest.php";
  
      const requestData = {
        sender_id: userId,
        receiver_id: profileId,
      };
  
      console.log("Wysyłam dane:", requestData);
  
      const response = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(requestData),
      });
  
      if (!response.ok) {
        throw new Error("Błąd odpowiedzi z serwera: " + response.status);
      }
  
      const textResponse = await response.text();  // Pobierz odpowiedź jako tekst
      console.log("Surowa odpowiedź:", textResponse);  
  
      let data;
      try {
        data = JSON.parse(textResponse);  // Parsuj odpowiedź ręcznie
        console.log("Parsed data:", data);
        setShowModal(true)
        setError(data.error)
      } catch (error) {
        console.log("Błąd parsowania JSON:", error);
      }
      
      if (data && data.success) {
        setMessage(data.success); // Ustawiamy wiadomość sukcesu
        setIsFriend(!isFriend); // Zmieniamy stan znajomości
        // Zapiszemy stan zaproszenia w localStorage
        const newFriendState = !isFriend; 
        localStorage.setItem(`friendRequestSent_${userId}_${profileId}`, JSON.stringify(newFriendState));
  
      } else {
        setMessage(data ? data.error : "Nieoczekiwany błąd.");
      }
    } catch (error) {
      setMessage("Wystąpił błąd podczas przetwarzania zaproszenia: " + error.message);
    }
  };
  

  if (!user || !profileData) return <div>Loading...</div>;

  return (
    <div className="profile-container">
      <div className="profile-header">
        <div className="profile-info">
          <ProfIMG userId={userID} />
          <h2>{profileData.Imie} {profileData.Nazwisko}<span className="nickname">@{profileData.Nick}</span></h2>
          <p>{profileData.Email}</p>
        </div>
        {isCurrentUser ? (
          <p><strong>Liczba odwiedzin:</strong> {visit}</p>
        ) : (
          <>
          <div className='profil-activities'>
            <button  onClick={() => handleFriendRequest(user.id,userID)}
            className="friend-button" 
            >
              {isFriend ? 'Usuń ze Znajomych' : 'Zaproś do Znajomych'}
              
            </button>
            <button
        className="observ-button"
        onClick={handleFollow}
        disabled={isFollowing === null} // Możesz dodać warunek, który uniemożliwi kliknięcie, dopóki status nie będzie znany
      >
        {isFollowing ? 'Przestań obserwować' : 'Zaobserwuj'}
      </button>
          </div>
          </>
        )}
        {console.log('Jestem na profilu id: '+userID+' Ja mam id: '+user.id)}
      </div>

      <div className="profile-details">
        {isEditing ? (
          <div className="profile-edit">
            <File userId={userID}/>
            <div>
              <label>Imię:</label>
              <input
                type="text"
                name="Imie"
                value={editedData.Imie || ''}
                onChange={handleInputChange}
              />
            </div>
            <label>Nazwisko:</label>
            <input
              type="text"
              name="Nazwisko"
              value={editedData.Nazwisko || ''}
              onChange={handleInputChange}
            />
            <div>
              <label>Nickname:</label>
              <input
                type="text"
                name="Nick"
                value={editedData.Nick || ''}
                onChange={handleInputChange}
              />
            </div>
            <div>
              <label>Email:</label>
              <input
                type="email"
                name="Email"
                value={editedData.Email || ''}
                onChange={handleInputChange}
              />
            </div>
            <div>
              <label>Bio:</label>
              <input
                type="text"
                name="Bio"
                value={editedData.Bio || ''}
                onChange={handleInputChange}
              />
            </div>
            <div>
              <label>Data Urodzenia:</label>
              <input
                type="text"
                name="Data_Urodzenia"
                value={editedData.Data_Urodzenia || ''}
                onChange={handleInputChange}
              />
            </div>
            <div>
              <label>Kraj:</label>
              <input
                type="text"
                name="Kraj"
                value={editedData.Kraj || ''}
                onChange={handleInputChange}
              />
            </div>
            <button className="save-button" onClick={handleSaveChanges}>Zapisz zmiany</button>
            <button className="del-button" onClick={handleEditToggle}>Anuluj</button>
          </div>
        ) : (
          <div className="profile-view">
            <div className="profile-bio">
              <h3>Bio:</h3>
              <p>{profileData.Bio}</p>
            </div>

            <div className="profile-extra">
              <p><strong>Data Urodzenia:</strong> {profileData.Data_Urodzenia}</p>
              <p><strong>Kraj:</strong> {profileData.Kraj}</p>
            </div>

            {isCurrentUser && (
              <button className="edit-button" onClick={handleEditToggle}>Edytuj profil</button>
            )}
          </div>
        )}
<div className="profile-posts">
  {isEditing ? (
    // If the user is editing, render nothing (empty <p> element).
    <p></p>
  ) : (
    // Render posts when not editing
    posts.length > 0 ? (
      <ul>
        {posts.map((post) => (
          <div className="post" key={post.id}>
            {console.log(post)}
            <div className="post-header">
              <ProfIMG userId={userID} />
              <div className="post-info">
                <div>
                  <span className="post-username">
                    {profileData.Imie} {profileData.Nazwisko}
                  </span>
                  <span className="post-nickname">
                    @{profileData.Nick}
                  </span>
                </div>
                <span className="post-date">
                  {post.date}
                </span>
              </div>
            </div>
            <span className="post-title">{post.title}</span>
            <div className="post-content">{post.content}</div>
                            <div className="post-hashtags">
                {Array.isArray(post.hashtags) && post.hashtags.length > 0 ? (
                  post.hashtags.map((hashtag, index) => (
                    <span
                      className="hashtag"
                      key={index}
                    >
                      <strong>{hashtag}</strong>
                    </span>
                  ))
                ) : (
                  <p>Brak hasztagów.</p>
                )}
              </div>
            <div className="footer">
              <Like like={post.likeCount} postId={post.id} userId={user.id} />
              <button
                className="comment-button"
                onClick={() => handleToggleComments(post.id)}
              >
                <FontAwesomeIcon icon={faComment} />
                <span className="comment-count">{post.comments.length}</span>
              </button>
            </div>
            {/* Comments section visibility based on the state */}
            {commentsVisibility[post.id] && (
              <div className="comments-section">
                {/* Render comments here */}
                {post.comments.map((comment) => (
                  <div key={comment.id} className="comment">
                     <div className="post-info">
                    <div className="comment-header">
                      <img
                        className="post-avatar"
                        src={`http://localhost/${comment.prof || '/uploads/basic.jfif'}`}
                        alt="Commenter profile"
                      />
                        <span className="post-username">
                          {comment.auth}
                        </span>
                        <span className="post-nickname">
                          @{comment.comm_nick}
                        </span>
                      </div>
                      <span className="post-date">
                          {formatDate(comment.publishedAt)}
                        </span>
                    </div>
                    <div className="post-content">{comment.content}</div>
                    <LikeComment like = {comment.like} commentId = {comment.id} userId = {user.id}/>
                  </div>
                ))}
              </div>
            )}
          </div>
        ))}
      </ul>
    ) : (
      <p>Uzytkownik nie zamieścił żadnego posta.</p>
    )
  )}
    </div>
    {showModal && <Modal message={error} closeModal={closeModal} />}
  </div>
  
</div>
    
  );
};

export default Profile;
