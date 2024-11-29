import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom'; 
import './searchbar.css';

const SearchBar = ({ onSearch, selectedHashtag }) => {
  const [query, setQuery] = useState(selectedHashtag);

  const navigate = useNavigate();

  // Handle input change and set query
  const handleSearch = (e) => {
    setQuery(e.target.value); 
  };

  // Handle the "Enter" key press to search
  const handleKeyDown = (e) => {
    if (e.key === 'Enter') { 
      console.log('Szukam:', query);
      if (onSearch) onSearch(query); // Call onSearch if provided
      navigate(`/dashboard/search?query=${query}`); // Corrected URL format
    }
  };

  // Update query when selectedHashtag changes
  useEffect(() => {
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
