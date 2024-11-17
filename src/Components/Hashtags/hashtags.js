import React from 'react';
import './hashtags.css';

const TopHashtags = ({onHashtagClick}) => {
  const hashtags = [
    { hashtag: '#Normalni', count: 2500 },
    { hashtag: '#Lewacy', count: 1800 },
    { hashtag: '#To', count: 1400 },
    { hashtag: '#Oksymoron', count: 1200 },
    { hashtag: '#xD', count: 1000 },
    { hashtag: '#PiStoSzansa', count: 5000 },
    { hashtag: '#Trump', count: 1800 },
    { hashtag: '#Kamala2024', count: 1400 },
    { hashtag: '#To', count: 1200 },
    { hashtag: '#NajlepszyŻartRoku', count: 620 },
  ];

  return (
    <div className="top-hashtags">
      <h2 className='hashtag-header'>Najpopularniejsze Hashtagi</h2>
      <ul className="hashtag-list">
        {hashtags.map((item, index) => (
          <li key={index} className="hashtag-item">
            <span onClick={() => onHashtagClick(item.hashtag)} className="hashtag">{item.hashtag}</span>
            <span className="hashtag-count">{item.count} posts</span>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default TopHashtags;
