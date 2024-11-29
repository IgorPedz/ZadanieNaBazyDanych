import React, { useState, useEffect, useRef } from "react";
import "./Stories.css";
import Modal from '../Modals/Modal';
import { useUser } from '../../context/UserContext';

const Story = () => {
  const [videos, setVideos] = useState([]);
  const [currentVideoIndex, setCurrentVideoIndex] = useState(0);
  const [newVideo, setNewVideo] = useState(null); // State for the new video file

  const [showModal, setShowModal] = useState(false);
  const [error, setError] = useState('');
  const videoRef = useRef(null);
  const videoContainerRef = useRef(null);

  const { user } = useUser();

  const closeModal = () => {
    setShowModal(false);
  };

  // Fetch videos from the server
  const fetchVideos = async () => {
    try {
      const response = await fetch("http://localhost/getVideos.php");
      const data = await response.json();
      setVideos(data);
    } catch (error) {
      console.error("Error fetching videos", error);
    }
  };

  // Handle the transition between videos (play the next one)
  const goToNextVideo = () => {
    const nextIndex = (currentVideoIndex + 1) % videos.length;
    setCurrentVideoIndex(nextIndex);
  };

  const goToPreviousVideo = () => {
    const prevIndex = (currentVideoIndex - 1 + videos.length) % videos.length;
    setCurrentVideoIndex(prevIndex);
  };

  const handleVideoPlay = (index) => {
    setCurrentVideoIndex(index); // Update the current video index
    const videoElements = videoContainerRef.current.querySelectorAll("video");
    videoElements.forEach((video, idx) => {
      if (idx === index) {
        video.play().catch((error) => {
          console.error("Error playing video:", error);
        });
      } else {
        video.pause(); // Pause other videos
      }
    });
  };

  const handleFileChange = (e) => {
    setNewVideo(e.target.files[0]);
  };

  const handleVideoUpload = async () => {
    if (!newVideo) {
      setError('Musisz wybrać filmik by móc go opublikować');
      setShowModal(true);
      return;
    }
  
    const formData = new FormData();
    formData.append("video", newVideo);
    formData.append("userId", user.id);  // Dodanie userId do FormData
  
    try {
      const response = await fetch("http://localhost/uploadVideos.php", {
        method: "POST",
        body: formData, // Tutaj wysyłamy formData, który zawiera video oraz userId
      });
      
      const data = await response.json();
      console.log(data);
  
      if (data.success) {
        setError('Filmik opublikowany');
        setShowModal(true);
        fetchVideos(); // Re-fetch videos after upload
      } else {
        alert("Video upload failed.");
      }
    } catch (error) {
      console.error("Error uploading video:", error);
    }
  };
  

  useEffect(() => {
    fetchVideos();
    const intervalId = setInterval(fetchVideos, 5000);

    // Clear the interval when the component is unmounted to avoid memory leaks
    return () => clearInterval(intervalId);
  }, []);

  useEffect(() => {
    if (videos.length > 0) {
      const video = videoRef.current;
      video.addEventListener("ended", goToNextVideo);
      return () => {
        video.removeEventListener("ended", goToNextVideo);
      };
    }
  }, [videos, currentVideoIndex]);

  return (
    <div className="story">
      <h1>Stories</h1>

      {/* Full-screen video */}
      <div className="video-container">
        {videos.length > 0 && (
          <video
            ref={videoRef}
            key={videos[currentVideoIndex].Link_filmu}
            autoPlay
            style={{
              width: "100%",
              height: "100%",
              objectFit: "cover",
              transition: "opacity 1s ease-in-out",
            }}
          >
            <source
              src={`http://localhost/${videos[currentVideoIndex].Link_filmu}`}
              type="video/mp4"
            />
            Your browser does not support the video element.
          </video>
        )}
      </div>

      {/* Navigation arrows */}
      {videos.length > 1 && (
        <div className="arrow-buttons">
          <button className="arrow-left" onClick={goToPreviousVideo}>
            ←
          </button>
          <button className="arrow-right" onClick={goToNextVideo}>
            →
          </button>
        </div>
      )}

      {/* Thumbnail gallery */}
      <div className="video-gallery" ref={videoContainerRef}>
        {videos.map((video, index) => (
          <div
            key={index}
            className={`video-item ${index === currentVideoIndex ? "active" : ""}`}
            onClick={() => handleVideoPlay(index)} // Play video when clicked
          >
            <span>Autor: {video.Imie} {video.Nazwisko}</span>
            <video>
              <source
                src={`http://localhost/${video.Link_filmu}`}
                type="video/mp4"
              />
              Your browser does not support the video element.
            </video>
          </div>
        ))}
      </div>
      <div className="upload-video-container">
        <h1>Opublikuj nową storkę</h1>
        <input
          type="file"
          accept="video/mp4"
          className="video-input"
          onChange={handleFileChange}
        />
        <button onClick={handleVideoUpload}>Opublikuj</button>
      </div>
      
      {showModal && <Modal message={error} closeModal={closeModal} />}
      {/* Video upload form */}
    </div>
    
  );
};

export default Story;
