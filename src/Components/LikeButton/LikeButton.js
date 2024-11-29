import { useState, useEffect } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faHeart, faHeartBroken } from '@fortawesome/free-solid-svg-icons';

const PostLikes = ({ like, postId, userId }) => {
  const [liked, setLiked] = useState(false); // Stan polubienia
  const [likeCount, setLikeCount] = useState(like); // Liczba polubień, ustawiamy na wartość 'like' z props, domyślnie 0
  const [loading, setLoading] = useState(true); // Stan ładowania danych

  // Załadowanie stanu polubienia i liczby polubień po załadowaniu komponentu
  useEffect(() => {
    const fetchPostLikes = async () => {
      try {
        const response = await fetch(`http://localhost/getPostsLikes.php?postId=${postId}&userId=${userId}`);
        
        // Sprawdzamy, czy odpowiedź z serwera jest prawidłowa
        if (response.ok) {
          const data = await response.json();
          if (data) {
            setLiked(data.liked === 1); // Ustawiamy, czy post jest polubiony
            setLikeCount(data.likeCount || like); // Ustawiamy liczbę polubień lub domyślnie 0
          }
        } else {
          console.error('Błąd serwera przy pobieraniu danych');
        }
      } catch (error) {
        console.error('Błąd przy pobieraniu danych o polubieniach:', error);
      } finally {
        setLoading(false); // Po załadowaniu danych, zmieniamy stan ładowania
      }
    };

    fetchPostLikes(); // Uruchamiamy funkcję pobierającą dane po załadowaniu komponentu
  }, [postId, userId]); // Jeśli postId lub userId się zmienia, ponownie wykonamy zapytanie

  const handleLikeClick = async () => {
    // Tymczasowo zmieniamy stan na przeciwny, ale nie robimy optymistycznej zmiany
    const newLiked = !liked;
    
    try {
      const response = await fetch('http://localhost/toggleLike.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `postID=${postId}&userID=${userId}`,
      });

      if (!response.ok) {
        throw new Error('Błąd podczas wykonywania żądania');
      }

      const data = await response.json();
      if (!data.success) {
        throw new Error('Błąd serwera');
      }

      // Jeśli odpowiedź z serwera jest prawidłowa, aktualizujemy stan
      setLiked(newLiked); // Ustawiamy stan polubienia na odpowiedni
      setLikeCount(data.newLikeCount || like); // Ustawiamy zaktualizowaną liczbę polubień lub zachowujemy poprzednią, jeśli brak
    } catch (error) {
      console.error('Błąd podczas wykonywania żądania:', error);
      // W przypadku błędu, nie zmieniamy stanu
    }
  };

  if (loading) {
    return <div>Ładowanie...</div>;
  }

  return (
    <div>
      <button
        onClick={handleLikeClick}
        style={{ border: 'none', background: 'transparent', cursor: 'pointer' }}
      >
        {/* Ikona serca z Font Awesome */}
        <FontAwesomeIcon
          icon={liked ? faHeart : faHeartBroken} // Zmieniamy ikonę na pełne lub puste serce
          style={{
            color: liked ? 'red' : 'white', // Czerwone serce jeśli polubione, białe jeśli nie
            fontSize: '24px', // Ustawiamy rozmiar ikony
            transition: 'color 0.2s ease', // Płynna zmiana koloru
          }}
        />
        <span className='Like'> {likeCount}</span>
      </button>
    </div>
  );
};

export default PostLikes;
