import { useState, useEffect } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faHeart, faHeartBroken } from '@fortawesome/free-solid-svg-icons';

const CommentLikes = ({ like, commentId, userId }) => {
  const [liked, setLiked] = useState(false); // Stan polubienia
  const [likeCount, setLikeCount] = useState(like || 0); // Liczba polubień, ustawiamy na wartość 'like' z props, domyślnie 0
  const [loading, setLoading] = useState(true); // Stan ładowania danych

  // Załadowanie stanu polubienia i liczby polubień po załadowaniu komponentu
  useEffect(() => {
    const fetchCommentLikes = async () => {
      try {
        const response = await fetch(`http://localhost/getCommLikes.php?commentId=${commentId}&userId=${userId}`);
        
        if (!response.ok) {
          throw new Error('Błąd przy pobieraniu danych o polubieniach');
        }

        const data = await response.json();
        
        if (data) {
          setLiked(data.liked === 1); // Ustawiamy, czy komentarz jest polubiony
          setLikeCount(data.likeCount || 0); // Jeśli brak danych o liczbie polubień, ustawiamy 0
        }
      } catch (error) {
        console.error('Błąd przy pobieraniu danych o polubieniach:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchCommentLikes(); // Uruchamiamy funkcję pobierającą dane po załadowaniu komponentu
  }, [commentId, userId, like]); // Zmieniamy tylko wtedy, gdy commentId, userId lub like się zmieni

  const handleLikeClick = async () => {
    const newLiked = !liked;
  
    try {
      // Wysyłamy dane o polubieniu komentarza
      const response = await fetch('http://localhost/toggleCommLike.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `commentID=${commentId}&userID=${userId}`,
      });

      if (!response.ok) {
        throw new Error('Błąd podczas wykonywania żądania');
      }
  
      // Odczytujemy odpowiedź jako JSON
      const data = await response.json();
  
      // Jeśli odpowiedź serwera jest sukcesem, zaktualizuj stan
      if (data.success) {
        setLiked(newLiked);
        setLikeCount(data.newLikeCount !== undefined ? data.newLikeCount : 0); // Ustawiamy nową liczbę polubień, domyślnie 0
      } else {
        throw new Error('Błąd serwera: brak sukcesu w odpowiedzi');
      }
  
    } catch (error) {
      console.error('Błąd podczas wykonywania żądania:', error);
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
        <FontAwesomeIcon
          icon={liked ? faHeart : faHeartBroken} // Zmieniamy ikonę na pełne lub puste serce
          style={{
            color: liked ? 'red' : 'white', // Czerwone serce jeśli polubione, białe jeśli nie
            fontSize: '24px', // Ustawiamy rozmiar ikony
            transition: 'color 0.2s ease', // Płynna zmiana koloru
          }}
        />
        <span className='Like'> {likeCount}</span> {/* Wyświetlamy liczbę polubień, nawet 0 */}
      </button>
    </div>
  );
};

export default CommentLikes;
