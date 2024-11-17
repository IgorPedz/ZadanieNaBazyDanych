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

const Dashboard = () => {
  const { user, logout } = useUser(); 
  const [activeTab, setActiveTab] = useState('posts'); 
  const navigate = useNavigate(); 
  const [selectedHashtag, setSelectedHashtag] = useState('');
  const [isSettingsModalVisible, setIsSettingsModalVisible] = useState(false); 

  const handleHashtagClick = (hashtag) => {
    setSelectedHashtag(hashtag); 
    console.log(hashtag);
  };

  useEffect(() => {
    if (!user) {
      window.location.href = '/';
    }
  }, [user]);

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

  return (
    <div className="background">
      {user ? (
        <div className="dashboard-content">
          <div onClick={() => { handleAdditionalActions(user.username); }} className="user-info">
            <h1>Witaj, {user.username}!</h1>
            <img 
              src={`https://i.pravatar.cc/150?img=12`} 
              alt="User profile" 
              className="profile-image"
            />
          </div>
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
          />
        </div>
        <div className="Main-content">
          {activeTab === 'posts' ? <Posts handleAdditionalActions={handleAdditionalActions} onHashtagClick={handleHashtagClick} /> : activeTab === 'stories' ? <Stories /> : activeTab === 'profil' ? <Profil /> : null}
          <span className="hash">
            <Hashtags onHashtagClick={handleHashtagClick} />
          </span>
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
