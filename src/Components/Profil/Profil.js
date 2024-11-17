import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import './Profil.css';

const Profile = () => {
  const { username } = useParams();
  const [user, setUser] = useState(null);

  useEffect(() => {
    const decodedUsername = decodeURIComponent(username);

    const fetchUserData = async () => {
      try {
        const simulatedData = {
          name: decodedUsername, 
          email: `${decodedUsername.toLowerCase().replace(' ', '.')}@example.com`,
          nickname: decodedUsername.split(' ')[0], 
          bio: 'Web developer passionate about React and JavaScript.',
          birthdate: '1990-01-01',
          country: 'Polska',
          profilePicture: 'https://i.pravatar.cc/150?img=1',
        };

        setUser(simulatedData);
      } catch (error) {
        console.error('Error fetching user data:', error);
        setUser(null);
      }
    };

    fetchUserData();
  }, [username]); 

  if (!user) return <div>Loading...</div>;

  return (
    <div className="profile-container">
      <div className="profile-header">
        <img
          src={user.profilePicture}
          alt="Profile"
          className="profile-picture"
        />
        <div className="profile-info">
          <h2>{user.name}<span className="nickname">@{user.nickname}</span></h2>
          <p>{user.email}</p>
        </div>
      </div>

      <div className="profile-details">
        <div className="profile-bio">
          <h3>Bio:</h3>
          <p>{user.bio}</p>
        </div>

        <div className="profile-extra">
          <p><strong>Data Urodzenia:</strong> {user.birthdate}</p>
          <p><strong>Kraj:</strong> {user.country}</p>
        </div>
      </div>
    </div>
  );
};

export default Profile;
