import React, { useState } from 'react';
import { useUser } from '../../context/UserContext'; 
import './posts.css';

const PostFeed = ({ handleAdditionalActions , onHashtagClick}) => {
  const { user } = useUser();
  const [newPost, setNewPost] = useState({
    title: '',
    content: '',
    hashtags: [],
  });

  const [posts, setPosts] = useState([
    {
      id: 1,
      username: 'Jan Kowalski',
      nickname: 'Kowal',
      content: 'Witajcie na moim profilu!',
      title: 'Pierwszy post!',
      hashtags: ['#hello', '#welcome', '#firstPost', '#new', '#socialMedia'],
      comments: ['Pierwszy komentarz!', 'Super post!', 'Witaj!'],
      likeCount: 10,
      liked: false,
    },
    {
      id: 2,
      username: 'Anna Nowak',
      nickname: 'Nowakowa',
      content: 'Co słychać, Twitterze?',
      title: 'Kolejny post!',
      hashtags: ['#whatIsUp', '#Twitter', '#community', '#chat', '#online'],
      comments: ['Hej Anna!', 'Dobrze, a u Ciebie?'],
      likeCount: 5,
      liked: false,
    },
  ]);

  const [showModal, setShowModal] = useState(false);
  const [currentPost, setCurrentPost] = useState(null);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setNewPost({
      ...newPost,
      [name]: value,
    });
  };

  const handlePublish = () => {
    if (newPost.title && newPost.content) {
      const newPostData = {
        id: posts.length + 1,
        username: user.username,
        nickname: 'admin1',
        title: newPost.title,
        content: newPost.content,
        hashtags: newPost.hashtags.split(' '),
        comments: [],
        likeCount: 0, 
        liked: false, 
      };
      setPosts([newPostData, ...posts]); 
      setNewPost({ title: '', content: '', hashtags: [] });
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

  return (
    <div className="postfeed">
      <div className="post new-post">
        <div className="post-header">
          <img
            src={`https://i.pravatar.cc/150?img=0`}
            alt="User"
            className="post-avatar"
          />
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

        <button onClick={handlePublish} className="publish-button">
          Opublikuj
        </button>
      </div>

      {posts.map((post) => (
        <div key={post.id} className="post">
          <div className="post-header">
            <img
              src={`https://i.pravatar.cc/150?img=${post.id}`}
              alt="User"
              className="post-avatar"
            />
            <div className="post-info">
              <span
                className="post-username"
                style={{ cursor: 'pointer', color: '#1d9bf0' }}
                onClick={() => handleAdditionalActions(post.username)}
              >
                {post.username}<span className="post-nickname">@{post.nickname}</span>
              </span>
              <h2 className="post-title">{post.title}</h2>
            </div>
          </div>

          <p className="post-content">{post.content}</p>

          <div className="post-actions">
            <button
              className="like-button"
              onClick={() => handleLikeClick(post.id)}
              aria-label="Like"
            >
              {post.liked ? (
                <span role="img" aria-label="filled-heart">❤️</span>
              ) : (
                <span role="img" aria-label="empty-heart">🤍</span>
              )}
              <span className="like-count"> {post.likeCount}</span>
            </button>
            <span
              className="comment-count"
              onClick={() => handleShowComments(post)}
            >
              💬{post.comments.length}
            </span>
          </div>

          <div className="post-hashtags">
  {post.hashtags.map((hashtag, index) => (
    <span
      key={index}
      onClick={() => onHashtagClick(hashtag)} 
      className="hashtag"
    >
      {hashtag}
    </span>
  ))}
</div>

        </div>
      ))}

      {showModal && currentPost && (
        <div className="modal-overlay">
          <div className="modal">
            <h1>Komentarze</h1>
            <div className="modal-comments">
              {currentPost.comments.length === 0 ? (
                <p>Brak komentarzy.</p>
              ) : (
                currentPost.comments.map((comment, index) => (
                  <p className="comment" key={index}>
                    {comment}
                    <span className="likes-count"> ❤️10</span>
                  </p>
                ))
              )}
            </div>
            <button className="close-modal" onClick={closeModal}>
              Zamknij
            </button>
          </div>
        </div>
      )}
    </div>
  );
};

export default PostFeed;
