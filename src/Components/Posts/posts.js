import React, { useState, useEffect } from 'react';
import { useUser } from '../../context/UserContext'; 
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faComment } from '@fortawesome/free-solid-svg-icons';
import ProfIMG from '../../Components/FileDownload/FileDownload'
import './posts.css';

const PostFeed = ({ID, handleAdditionalActions, onHashtagClick }) => {
  const { user } = useUser(); // Pobieranie użytkownika z kontekstu
  const [newPost, setNewPost] = useState({
    title: '',
    content: '',
    hashtags: [],
  });

  const [posts, setPosts] = useState([]); // Posts from server
  const [showModal, setShowModal] = useState(false);
  const [currentPost, setCurrentPost] = useState(null);
  const [isEditing, setIsEditing] = useState(false);

  // States for loading and error handling  
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  // Fetch posts from the server when the component mounts
  useEffect(() => {
    if (!user) return;

    const fetchPosts = async () => {
      try {
        const response = await fetch('http://localhost/upload.php');
        if (!response.ok) {
          throw new Error('Błąd w odpowiedzi serwera');
        }
        const data = await response.json();
      
        console.log('Otrzymane dane:', data); // Debugging log
    
        if (Array.isArray(data)) {
          setPosts(data); // Update posts
        } else {
          console.error('Błąd w danych:', data);
          setError('Nieprawidłowy format danych.');
        }
      } catch (err) {
        console.error('Błąd podczas pobierania postów:', err);
        setError('Błąd podczas pobierania postów: ' + (err.message || 'Nieznany błąd'));
      } finally {
        setLoading(false); // Stop loading after data fetch
      }
    };

    fetchPosts();
  }, [user]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setNewPost({
      ...newPost,
      [name]: value,
    });
  };
  const handlePublish = async () => {
    if (newPost.title && newPost.content && newPost.hashtags && user) {
      // Tworzymy dane do wysłania
      const postData = {
        title: newPost.title,
        content: newPost.content,
        hashtags: newPost.hashtags.split(' '), // Zakładając, że hashtagi są rozdzielone spacjami
        author: user.nick,
        userID: user.id,
      };
  
      console.log("Dane do wysłania: ", postData); // Upewnij się, że dane są poprawnie utworzone
  
      try {
        const response = await fetch("download.php", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(postData), // Zamiana danych na JSON
        });
  
        const result = await response.json();
        console.log(result); // Zaloguj odpowiedź z serwera
  
        if (result.status === "success") {
          console.log('Post został pomyślnie dodany!');
  
          // Natychmiastowe dodanie nowego posta do stanu
          const newPostObj = {
            id: result.id, // Przypisanie id, które zwraca serwer
            title: postData.title,
            content: postData.content,
            hashtags: postData.hashtags,
            author: postData.author,
            userID: postData.userID,
            likeCount: 0, // Początkowa liczba polubień
            liked: false, // Początkowy stan polubienia
            comments: [],
            publishedAt: new Date().toISOString(),
            nickname: postData.author,
          };
  
          // Dodaj post bezpośrednio do stanu
          setPosts((prevPosts) => [...prevPosts, newPostObj]);
  
          // Resetuj formularz po dodaniu
          setNewPost({
            title: '',
            content: '',
            hashtags: ''
          });
        } else {
          console.error('Błąd podczas dodawania posta:', result.message);
        }
      } catch (error) {
        console.error("Błąd podczas wysyłania:", error);
      }
    } else {
      console.error("Brak wymaganych danych.");
    }
  };
  
  
  const handleLikeClick = (postId) => {
    setPosts(
      posts.map((post) => {
        if (post.id === postId) {
          const newLikeCount = post.liked ? post.likeCount - 1 : post.likeCount + 1;
          return { ...post, liked: !post.liked, likeCount: newLikeCount };
        }
        return post;
      })
    );
  };

  const handleShowComments = (post) => {
    setCurrentPost(post);
    setShowModal(true);
  };

  const closeModal = () => {
    setShowModal(false);
    setCurrentPost(null);
  };

  const handleEditPost = (postId) => {
    const postToEdit = posts.find((post) => post.id === postId);
    if (postToEdit) {
      setNewPost({
        title: postToEdit.title,
        content: postToEdit.content,
        hashtags: postToEdit.hashtags.join(' '), // Jeśli hashtagi są tablicą, łączymy je w stringa
      });
      setCurrentPost(postToEdit);
      setIsEditing(true); // Ustawiamy, że teraz edytujemy post
    }
  };
  const handleSaveChanges = async () => {
    if (newPost.title && newPost.content && newPost.hashtags) {
      try {
        const response = await fetch('edit.php', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            postId: currentPost.id, // ID posta, który edytujemy
            title: newPost.title,
            content: newPost.content,
            hashtags: newPost.hashtags,
          }),
        });

        const data = await response.json();

        if (data.status === 'success') {
          setPosts(posts.map((post) => 
            post.id === currentPost.id 
              ? { ...post, title: newPost.title, content: newPost.content, hashtags: newPost.hashtags.split(' ') }
              : post
          ));
          setIsEditing(false); // Zakończono edycję
          setCurrentPost(null); // Resetujemy aktualny post
          setNewPost({ title: '', content: '', hashtags: '' });
        } else {
          console.error('Błąd podczas edytowania posta: ', data.message);
        }
      } catch (error) {
        console.error('Błąd podczas wysyłania zapytania do backendu: ', error);
      }
    } else {
      console.error("Wszystkie pola muszą być wypełnione.");
    }
  };

  const handleDeletePost = async (postId) => {
    try {
      // Wyślij żądanie do backendu w celu usunięcia posta
      const response = await fetch('delete.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ postId }), // Przekazujesz id posta
      });
  
      // Logowanie odpowiedzi w celu sprawdzenia, co zwraca serwer
      const text = await response.text(); // Pobieramy odpowiedź jako tekst
      console.log(text);  // Logujemy odpowiedź, żeby zobaczyć, co zwraca serwer
      
      // Jeśli odpowiedź jest w formacie JSON, zamień ją na obiekt
      const data = JSON.parse(text); // Parsowanie odpowiedzi do JSON
  
      console.log(data);  // Sprawdzamy zawartość odpowiedzi
  
      if (data.status === 'success') {
        // Jeśli usunięcie powiodło się, zaktualizuj stan aplikacji
        setPosts(posts.filter((post) => post.id !== postId));
      } else {
        console.error('Błąd podczas usuwania posta: ', data.message);
      }
    } catch (error) {
      console.error('Błąd podczas wysyłania zapytania: ', error);
    }
  };
  

  const formatDate = (date) => {
    const validDate = new Date(date);
  
    // Check if the date is valid
    if (isNaN(validDate)) {
      return 'Niepoprawna data';
    }
  
    return new Intl.DateTimeFormat('pl-PL', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    }).format(validDate);
  };

  // Check if user is available before rendering
  if (!user) {
    return <div>Ładowanie użytkownika...</div>;
  }

  return (
    <div className="postfeed">
      {/* New post form */}
      <div className="post new-post">
        <div className="post-header">
          <ProfIMG userId={user.id}/>
          <div className="post-info">
            <input
              type="text"
              name="title"
              placeholder="Tytuł posta"
              value={newPost.title}
              onChange={handleChange}
              className="new-post-title"
            />
          </div>
        </div>

        <input
          name="content"
          placeholder="Podziel się informacjami z światem!"
          value={newPost.content}
          onChange={handleChange}
          className="new-post-content"
        />

        <input
          type="text"
          name="hashtags"
          placeholder="Dodaj hashtagi (oddzielone spacjami)"
          value={newPost.hashtags}
          onChange={handleChange}
          className="new-post-hashtags"
        />

      <button 
        onClick={currentPost ? handleSaveChanges : handlePublish} 
        className="publish-button"
      >
        {currentPost ? 'Zapisz zmiany' : 'Opublikuj'}
      </button>
      </div>

      {/* Modal for comments */}
      {showModal && currentPost && (
        <div className="modal-overlay">
          <div className="modal">
            <h1>Komentarze</h1>
            <div className="modal-comments">
              {Array.isArray(currentPost.comments) && currentPost.comments.length > 0 ? (
                currentPost.comments.map((comment, index) => (
                  <div className="comment" key={index}>
                    <p><strong>{comment.author}</strong> mówi:</p>
                    <p>{comment.content}</p>
                    <span className="likes-count"> ❤️10</span>
                    <p><small>{comment.publishedAt}</small></p>
                  </div>
                ))
              ) : (
                <p>Brak komentarzy.</p>
              )}
            </div>
            <button className="close-modal" onClick={closeModal}>
              Zamknij
            </button>
          </div>
        </div>
      )}

      {/* Render posts */}
      {posts && posts.length > 0 ? (
        posts.map((post) => (
          <div key={post.id} className="post">
            <div className="post-header">
          <ProfIMG userId = {post.userId}/>
              <div className="post-info">
                <div>
                <span onClick={() => handleAdditionalActions(post.nickname)} className="post-username">
                  {post.author}
                </span>
                <span className="post-nickname">
                  @{post.nickname}
                </span>
                </div>
                <span className="post-date">
                  {formatDate(post.publishedAt)}
                </span>
              </div>
            </div>
            <span className='post-title'>{post.title}</span>
            <div className="post-content">{post.content}</div>
            <div className="post-footer">
            <div className='post-hashtags'>
            {Array.isArray(post.hashtags) && post.hashtags.length > 0 ? (
  post.hashtags.map((hashtag, index) => (
    <span onClick={() => onHashtagClick(hashtag)} className="hashtag" key={index}>
      <strong>{hashtag}</strong>
    </span>
  ))
) : (
  <p>Brak hasztagów.</p>
)}
          </div>
          <div>
            <button className='like-button' onClick={() => handleLikeClick(post.id)}>
  {post.liked ? '❤️' : '🤍'} 
</button>
<span>
  {post.likeCount} 
</span>

<button className='comment-button' onClick={() => handleShowComments(post)}>
  <FontAwesomeIcon icon={faComment} /><span className='comment-count'>{post.comments.length}</span>
</button>
</div>
</div>
              {(post.nickname.trim() === user.nick.replace('_', '').trim()) && (
                <div>
                  <button className='edt-button' onClick={() => handleEditPost(post.id)}>Edytuj</button>
                  <button className='del-button' onClick={() => handleDeletePost(post.id)}>Usuń</button>
                </div>
              )}

          </div>
        ))
      ) : (
        <div>Brak postów do wyświetlenia</div>
      )}
    </div>
  );
};

export default PostFeed;
