import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom'; 
import './searchbar.css';

const SearchBar = ({ selectedHashtag, onHashtagClick }) => {
  const [query, setQuery] = useState(selectedHashtag);
  const navigate = useNavigate();

  const handleSearch = (e) => {
    setQuery(e.target.value); 
  };

  const handleKeyDown = (e) => {
    if (e.key === 'Enter') { 
      console.log('Szukam:', query); 
      navigate(`/dashboard/search=${query}`); 
    }
  };

  React.useEffect(() => {
    setQuery(selectedHashtag);
  }, [selectedHashtag]);

  return (
    <div className="searchbar">
      <input
        type="text"
        placeholder="Szukaj..."
        className="search-input"
        value={query} 
        onChange={handleSearch} 
        onKeyDown={handleKeyDown} 
      />
    </div>
  );
};

export default SearchBar;
