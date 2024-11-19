import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import './navbar.css';
import logo_male from '../../assets/Pictures/logo-error.png';
import Searchbar from '../Searchbar/searchbar';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCameraRetro,faCommentDots, faBars } from '@fortawesome/free-solid-svg-icons';
import Hashtags from '../Hashtags/hashtags'
import { useNavigate } from 'react-router-dom';

const Navbar = ({ onTabChange,selectedHashtag,onHashtagClick }) => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [isMobile, setIsMobile] = useState(false);
  const [isOpen, setIsOpen] = useState(false);
  const navigate = useNavigate();

  // Sprawdzenie szerokości okna i ustawienie stanu isMobile
  useEffect(() => {
    const handleResize = () => {
      if (window.innerWidth <= 768) {
        setIsMobile(true);
      } else {
        setIsMobile(false);
      }
    };

    handleResize(); // Sprawdzenie na początku
    window.addEventListener('resize', handleResize);

    return () => window.removeEventListener('resize', handleResize);
  }, []);

  const toggleMenu = () => {
    setIsMenuOpen(!isMenuOpen);
    setIsOpen(!isOpen);
  };

  const closeMenu = () => {
    setIsMenuOpen(false);
  };

  return (
    <div className="navbar">
      <div className="navbar-left">
        <Link to="/" className="navbar-logo">
          <img src={logo_male} alt="Logo" className="logo-img" />
        </Link>
        <Searchbar selectedHashtag={selectedHashtag} />
      </div>

      {isMobile && (
        <div className={`menu-toggle ${isOpen ? 'open' : ''}`} onClick={toggleMenu}>
          <FontAwesomeIcon icon={faBars} className="icon" />
        </div>
      )}

      {(!isMobile || isMenuOpen) && (
        <div className="list-options">
          {isMobile && isMenuOpen && (
            <div className="close-menu" onClick={closeMenu}>
                 <Hashtags onHashtagClick={onHashtagClick}/>              
            </div>
          )}

          <span onClick={() => {
              onTabChange('posts');  
             navigate('/dashboard'); 
            }} className="Icon-option">
            <h4 className="icon-header">Posty</h4>
            <FontAwesomeIcon className="icon" icon={faCommentDots} />
          </span>
          <span onClick={() => {
              onTabChange('stories');  
             navigate('/dashboard');  
            }} className="Icon-option">
            <h4 className="icon-header">Stories</h4>
            <FontAwesomeIcon className="icon" icon={faCameraRetro} />
          </span>
        </div>
      )}
    </div>
  );
};

export default Navbar;
