import React, { useEffect } from 'react';
import { Helmet } from 'react-helmet';
import { useUser } from '../context/UserContext'; 

const Dashboard = () => {
  const { user, logout } = useUser();

  console.log(user.username)
  useEffect(() => {
    if (!user) {
      window.location.href = '/'; 
    }
  }, [user]);

  return (
    <div>
      <Helmet>
        <title>Fuse</title>
      </Helmet>
      <p>Strona głowna</p>
    </div>
  );
};

export default Dashboard;