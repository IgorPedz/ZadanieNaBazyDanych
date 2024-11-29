import React, { useState, useEffect } from 'react';
import { useUser } from '../../context/UserContext'; 
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faComment } from '@fortawesome/free-solid-svg-icons';
import ProfIMG from '../../Components/FileDownload/FileDownload'
import './posts.css';
import Like from '../LikeButton/LikeButton'
import LikeComment from '../LikeComment/LikeComm'
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
  const [newComment, setNewComment] = useState('');
  const [commentsVisibility, setCommentsVisibility] = useState({});
  const [editingComment, setEditingComment] = useState(null); // ID komentowanego komentarza
  const [editedCommentContent, setEditedCommentContent] = useState(''); // Zawartość edytowanego komentarza

  const [filteredPosts, setFilteredPosts] = useState([]); // Filtered posts based on search
  const [searchQuery, setSearchQuery] = useState(''); // Search query for hashtags
  // Function to handle the input change for a new comment
  const handleCommentChange = (event) => {
    setNewComment(event.target.value);
  };

  // Function to handle submitting the comment
  const handleAddComment = async (postId) => {
    if (newComment.trim() === '') return; // Don't add empty comments
    const currentDate = new Date();

    // Ustawiamy czas w polskiej strefie czasowej (Europe/Warsaw)
    const options = {
      timeZone: 'Europe/Warsaw',
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit',
      hour12: false,  // 24-godzinny format
    };
  
    // Formatujemy datę do formatu "DD.MM.YYYY, HH:MM:SS"
    const formattedDate = new Intl.DateTimeFormat('pl-PL', options).format(currentDate);

    // Rozdzielamy datę i godzinę
    const [date, time] = formattedDate.split(', ');
    const [day, month, year] = date.split('.');
  
    // Tworzymy format w stylu "YYYY-MM-DDTHH:mm:ss"
    const formattedDateTime = `${year}-${month}-${day}T${time}`;
    console.log(formattedDateTime)
    const comment = {
      author: user.id,
      auth:user.username + user.nameuser ,
      content: newComment,
      likeCount: 0,
      publishedAt: formattedDateTime,
      comm_nick: user.nick,
    };
  
    // Find the post by its ID and add the new comment
    const updatedPosts = posts.map((post) => {
      if (post.id === postId) {
        return {
          ...post,
          comments: [...post.comments, comment],
        };
      }
      return post;
    });
  
    // Update the posts state with the new comment
    setPosts(updatedPosts);
  
    // Reset the comment input
    setNewComment('');
  
    // Send the comment to the server via fetch
    try {
      const data = {
        postId: postId,  // Send the ID of the post the comment is for
        comment: comment,
      };
  
      // Send the comment to the PHP backend
      const response = await fetch('http://localhost/add_comment.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(data), // Send the data as JSON
      });
  
      if (!response.ok) {
        throw new Error('Failed to add comment');
      }
  
      // Handle the server response
      const result = await response.json();
      if (result.success) {
        console.log('Comment added successfully');
      } else {
        console.error('Failed to add comment:', result.message);
        alert('Failed to add comment: ' + result.message);  // Show an error message
      }
    } catch (error) {
      console.error('Error adding comment:', error);
      alert('An error occurred while adding the comment.');
    }
  };
  

  // Toggle visibility for comments of a specific post
  const handleToggleComments = (postId) => {
    setCommentsVisibility(prevState => ({
      ...prevState,
      [postId]: !prevState[postId]
    }));
  };
  const handleSearchChange = (event) => {
    const query = event.target.value;
    setSearchQuery(query);

    // Filter posts by hashtags
    if (query.trim()) {
      const filtered = posts.filter((post) =>
        post.hashtags.some((hashtag) =>
          hashtag.toLowerCase().includes(query.toLowerCase())
        )
      );
      setFilteredPosts(filtered);
    } else {
      setFilteredPosts(posts); // Show all posts if search is cleared
    }
  };
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
          setFilteredPosts(data); // Initialize filteredPosts with all posts
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
    const intervalId = setInterval(fetchPosts, 5000);

    // Clear the interval when the component is unmounted to avoid memory leaks
    return () => clearInterval(intervalId);
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

  const handleEditComment = (postId, commentId, content) => {
    setEditingComment({ postId, commentId });
    setEditedCommentContent(content); // Ustawienie zawartości komentarza do edycji
  };
  const handleSaveCommentChanges = async () => {
    if (!editedCommentContent.trim()) return; // Upewnij się, że treść nie jest pusta
  
    try {
      const response = await fetch('edit_comment.php', { // Zakładając, że masz endpoint do edycji komentarzy
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          postId: editingComment.postId,
          commentId: editingComment.commentId,
          content: editedCommentContent,
        }),
      });
  
      const result = await response.json();
      if (result.status === 'success') {
        // Aktualizujemy posty i komentarze w stanie
        setPosts((prevPosts) =>
          prevPosts.map((post) =>
            post.id === editingComment.postId
              ? {
                  ...post,
                  comments: post.comments.map((comment) =>
                    comment.id === editingComment.commentId
                      ? { ...comment, content: editedCommentContent }
                      : comment
                  ),
                }
              : post
          )
        );
        setEditingComment(null); // Resetujemy stan edytowania
        setEditedCommentContent(''); // Resetujemy zawartość komentarza
      } else {
        alert('Błąd podczas zapisywania komentarza');
      }
    } catch (error) {
      console.error('Błąd podczas edytowania komentarza:', error);
      alert('Wystąpił błąd podczas zapisywania komentarza');
    }
  };
  
  const handleDeleteComment = async (postId, commentId) => {
    try {
      // Send request to delete the comment from the server
      const response = await fetch('del_comment.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          postId: postId,
          commentId: commentId,
        }),
      });
  
      if (!response.ok) {
        throw new Error('Failed to delete comment');
      }
  
      const data = await response.json();
  
      if (data.status === 'success') {
        // If comment deletion is successful, update the state to remove the comment from the post
        setPosts((prevPosts) => 
          prevPosts.map((post) => 
            post.id === postId 
              ? { 
                  ...post, 
                  comments: post.comments.filter((comment) => comment.id !== commentId) 
                }
              : post
          )
        );
      } else {
        console.error('Error while deleting comment: ', data.message);
      }
    } catch (error) {
      console.error('Error during comment deletion: ', error);
    }
  };
  
  // Check if user is available before rendering
  if (!user) {
    return <div>Ładowanie użytkownika...</div>;
  }

  return (
    <div className="postfeed">
      {/* New post form */}
      <div className="search-bar">
        <input
          type="text"
          value={searchQuery}
          onChange={handleSearchChange}
          placeholder="Szukaj postów po hashtagach"
          className="search-input"
        />
      </div>
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

   {/* Render posts */}
   {filteredPosts && filteredPosts.length > 0 ? (
        filteredPosts.map((post) => (
          <div key={post.id} className="post">
            <div className="post-header">
              <ProfIMG userId={post.userId} />
              <div className="post-info">
                <div>
                  <span
                    onClick={() => handleAdditionalActions(post.nickname)}
                    className="post-username"
                  >
                    {post.author}
                  </span>
                  <span className="post-nickname">@{post.nickname}</span>
                </div>
                <span className="post-date">{formatDate(post.publishedAt)}</span>
              </div>
            </div>
            <span className="post-title">{post.title}</span>
            <div className="post-content">{post.content}</div>
            <div className="post-footer">
              <div className="post-hashtags">
                {Array.isArray(post.hashtags) && post.hashtags.length > 0 ? (
                  post.hashtags.map((hashtag, index) => (
                    <span
                      onClick={() => onHashtagClick(hashtag)}
                      className="hashtag"
                      key={index}
                    >
                      <strong>{hashtag}</strong>
                    </span>
                  ))
                ) : (
                  <p>Brak hasztagów.</p>
                )}
              </div>
              <div>
                <Like like = {post.likeCount} postId = {post.id} userId = {user.id}/>
                <button
                  className="comment-button"
                  onClick={() => handleToggleComments(post.id)}
                >
                  <FontAwesomeIcon icon={faComment} />
                  <span className="comment-count">{post.comments.length}</span>
                </button>
              </div>
            </div>
            {(post.nickname.replace('_', '').trim() === user.nick.replace('_', '').trim()) && (
              <div>
                <button className="edt-button" onClick={() => handleEditPost(post.id)}>
                  Edytuj
                </button>
                <button className="del-button" onClick={() => handleDeletePost(post.id)}>
                  Usuń
                </button>
              </div>
            )}                
            {/* Render comments only if visible */}
            {commentsVisibility[post.id] && (
  <div className="comments-section">
    {Array.isArray(post.comments) && post.comments.length > 0 ? (
      post.comments.map((comment, index) => (
        <div className="comment" key={index}>
          <div className="post-header">
            {console.log(comment.prof)}
            <img className="post-avatar" src={`http://localhost/${comment.prof || 'uploads/basic.jfif'}`} alt="User profile" />
            <div className="post-info">
              <div>
                <span onClick={() => handleAdditionalActions(comment.comm_nick)} className="post-username">{comment.auth}</span>
                <span className="post-nickname">@{comment.comm_nick}</span>
              </div>
              <span className="post-date">{formatDate(comment.publishedAt)}</span>
            </div>
          </div>
          <div className="post-content">
            <p>{comment.content}</p>
            {console.log(comment.like + comment.id)}
            <LikeComment like = {comment.like} commentId = {comment.id} userId = {user.id}/>
          </div>
         {/* Edytowanie komentarza */}
         {editingComment && editingComment.commentId === comment.id ? (
            <div className="comment-edit">
              <textarea
                value={editedCommentContent}
                onChange={(e) => setEditedCommentContent(e.target.value)}
                className="comment-edit-input"
              />
              <button
                onClick={handleSaveCommentChanges}
                className="save-comment-button"
              >
                Zapisz
              </button>
              <button
                onClick={() => {
                  setEditingComment(null);
                  setEditedCommentContent('');
                }}
                className="cancel-comment-button"
              >
                Anuluj
              </button>
            </div>
          ) : (
            <div className="post-content">
            </div>
          )}
          {/* Show edit and delete options if the comment author matches the logged-in user */}
          {comment.comm_nick === user.nick && (
            <div className="comment-actions">
              <button
                className="edt-button"
                onClick={() => handleEditComment(post.id, comment.id)}
              >
                Edytuj
              </button>
              <button
                className="del-button"
                onClick={() => handleDeleteComment(post.id, comment.id)}
              >
                Usuń
              </button>
            </div>
          )}
        </div>
      ))
    ) : (
      <p>Zostaw jako pierwszy ślad pod tym postem!</p>
    )}

    {/* Comment input and submit button */}
    <div className="comment-input">
      <input
        value={newComment}
        className="comment-write"
        onChange={handleCommentChange}
        placeholder="Napisz komentarz..."
      />
      <button
        className="submit-comment-button"
        onClick={() => handleAddComment(post.id)}
      >
        Dodaj komentarz
      </button>
    </div>
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
