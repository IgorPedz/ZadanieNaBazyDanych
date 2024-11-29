import React, { useState, useEffect } from 'react';
import './hashtags.css';

const TopHashtags = ({ onHashtagClick }) => {
  const [hashtags, setHashtags] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // Funkcja do pobierania danych o najpopularniejszych hasztagach z backendu
  useEffect(() => {
    const fetchHashtags = async () => {
      try {
        const response = await fetch('http://localhost/hashtags.php'); // Upewnij się, że URL jest poprawny
        if (!response.ok) {
          throw new Error('Nie udało się pobrać danych');
        }
        const data = await response.json();
        console.log("Dane zwrócone z PHP:", data); // Debugowanie odpowiedzi
        setHashtags(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchHashtags();
    const intervalId = setInterval(fetchHashtags, 5000);

    // Clear the interval when the component is unmounted to avoid memory leaks
    return () => clearInterval(intervalId);

  }, []);

  if (loading) {
    return <div>Ładowanie...</div>;
  }

  if (error) {
    return <div>Błąd: {error}</div>;
  }

  return (
    <div className="top-hashtags">
      <h2 className="hashtag-header">Najpopularniejsze Hasztagi</h2>
      <ul className="hashtag-list">
        {hashtags.slice(0, 10).map((item, index) => (
          <li key={index} className="hashtag-item">
            <span
              onClick={() => onHashtagClick(item.hashtag)}
              className="hashtag"
            >
              {item.hashtag}
            </span>
            <span className="hashtag-count">{item.count} postów</span>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default TopHashtags;
