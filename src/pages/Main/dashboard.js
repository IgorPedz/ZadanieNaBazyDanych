import React, { useState, useEffect } from 'react';
import { Helmet } from 'react-helmet';
import { useUser } from '../../context/UserContext'; 
import { useNavigate } from 'react-router-dom';
import Logo_male from '../../assets/Pictures/logo-error.png';
import './dashboard.css';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faSignOutAlt, faCog } from '@fortawesome/free-solid-svg-icons';
import Navbar from '../../Components/Navbar/navbar';
import Posts from '../../Components/Posts/posts';
import Hashtags from '../../Components/Hashtags/hashtags';
import Stories from  '../../Components/Stories/Stories'; 
import Profil from '../../Components/Profil/Profil';
import SettingsModal from '../../Components/Settings/Settings'; 
import Fan from  '../../Components/FriendsAndObservers/FriendsAndObservers'
import Chat from '../../Components/Chat/Chat'
import ProfIMG from '../../Components/FileDownload/FileDownload'
import Cookies from 'js-cookie'

const Dashboard = () => {
  const { user, logout } = useUser(); 
  const [activeTab, setActiveTab] = useState('posts'); 
  const navigate = useNavigate(); 
  const [selectedHashtag, setSelectedHashtag] = useState('');
  const [isSettingsModalVisible, setIsSettingsModalVisible] = useState(false); 
  const [currentChat, setCurrentChat] = useState(null); // Użytkownik, z którym prowadzimy czat

  // Funkcja otwierająca czat
  const handleOpenChat = (friendUsername) => {
    setCurrentChat(friendUsername); // Otwieramy czat z wybranym znajomym
  };

  // Funkcja zamykająca czat
  const handleCloseChat = () => {
    setCurrentChat(null); // Zamykamy czat
  };

  // Funkcja obsługująca kliknięcie na hashtag
  const handleHashtagClick = (hashtag) => {
    setSelectedHashtag(hashtag); 
    console.log(hashtag);
  };

  useEffect(() => {
    if (!user) {
      navigate('/'); // Przekierowanie, jeśli użytkownik nie jest zalogowany
      console.log('Brak uzytkownika!');
    }

  }, [user, navigate]); // Zależy od 'user' i 'navigate'

  // Funkcja do zarządzania przełączaniem tabów
  const handleAdditionalActions = (username) => {
    setActiveTab('profil'); 
    navigate(`/dashboard/${username}`);
  };

  const showSettingsModal = () => {
    setIsSettingsModalVisible(true);
  };

  const hideSettingsModal = () => {
    setIsSettingsModalVisible(false);
  };
  let currentVisitCount = Cookies.get('visitCount');

  return (
    <div className="background">
      {user ? (
        <div className="dashboard-content">        
          <div onClick={() => { handleAdditionalActions(user.nick); }} className="user-info">
            <h1>Witaj, {user.username}!</h1>
            <ProfIMG userId={user.id} />
          </div>
          <Fan handleAdditionalActions={handleOpenChat}/>
        </div>
      ) : (
        <div className="login-prompt">
          <img src={Logo_male} alt="Fuse-logo" className="login-logo" />
          <p>Zapraszamy z powrotem! :)</p>
        </div>
      )}
      <div className="dashboard-container">
        <Helmet>
          <title>Fuse</title>
        </Helmet>
        
        <div className="dashboard-navbar">
          <Navbar 
            onTabChange={setActiveTab}
            selectedHashtag={selectedHashtag}
            onHashtagClick={handleHashtagClick}
          />
        </div>
        
        <div className="Main-content">
          {activeTab === 'posts' ? <Posts handleAdditionalActions={handleAdditionalActions} onHashtagClick={handleHashtagClick} /> : activeTab === 'stories' ? <Stories /> : activeTab === 'profil' ? <Profil visit = {currentVisitCount}/> : null}
          <span className="hash">
            <Hashtags onHashtagClick={handleHashtagClick} />
          </span>
          {currentChat && <Chat friendUsername={currentChat} onClose={handleCloseChat} />}
        </div>
      </div>

      <SettingsModal 
        isVisible={isSettingsModalVisible} 
        onClose={hideSettingsModal} 
      />

      <div className="footer">
        <p className="copy"></p>
        <FontAwesomeIcon 
          className="settings"
          icon={faCog}
          size="2x"
          color="#1da1f2"
          onClick={showSettingsModal} 
        />
        <FontAwesomeIcon 
          className="logout"
          icon={faSignOutAlt}
          size="2x"
          color="#1da1f2"
          onClick={logout}
        />
      </div>
    </div>
  );
};

export default Dashboard;
