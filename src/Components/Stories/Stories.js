import React, { useState, useRef } from "react";
import Slider from "react-slick";
import { useUser } from '../../context/UserContext'; 
import "./Stories.css"; 
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";

const initialStoriesData = [
  {
    id: 1,
    videoUrl: "https://www.youtube.com/embed/dQw4w9WgXcQ", 
    user: "user1",
    type: "youtube",
  },
  {
    id: 2,
    videoUrl: "https://www.youtube.com/embed/dQw4w9WgXcQ", 
    user: "user2",
    type: "youtube",
  },
  {
    id: 3,
    videoUrl: "https://www.youtube.com/embed/dQw4w9WgXcQ", 
    user: "user3",
    type: "youtube",
  },
  {
    id: 4,
    videoUrl: "https://www.youtube.com/embed/dQw4w9WgXcQ",
    user: "user4",
    type: "youtube",
  },
  {
    id: 5,
    videoUrl: "https://www.youtube.com/embed/dQw4w9WgXcQ",
    user: "user5",
    type: "youtube",
  },
];

const Stories = () => {
  const { user } = useUser();
  const [activeSlide, setActiveSlide] = useState(0); 
  const [storiesData, setStoriesData] = useState(initialStoriesData);
  const [showModal, setShowModal] = useState(false); 
  const [newStory, setNewStory] = useState({
    videoUrl: "",
    user: "",
    type: "youtube", 
  });

  const sliderRef = useRef(null);

  const settings = {
    infinite: true,
    speed: 500,
    slidesToShow: 3,
    slidesToScroll: 1,
    centerMode: true,
    focusOnSelect: true, 
    arrows: false,
    dots: false,
    beforeChange: (current, next) => {
      stopVideo(current);
    },
    afterChange: (current) => {
      setActiveSlide(current);
    },
  };

  const stopVideo = (index) => {

    const videoElement = document.getElementById(`video-${index}`);
    if (videoElement) {
      videoElement.pause();
      videoElement.currentTime = 0; 
    }

    const iframeElement = document.getElementById(`youtube-${index}`);
    if (iframeElement) {
      const src = iframeElement.src;
      iframeElement.src = ""; 
      iframeElement.src = src; 
    }
  };

  const goToPrev = () => {
    sliderRef.current.slickPrev();
  };

  const goToNext = () => {
    sliderRef.current.slickNext();
  };

  const handlePublish = () => {
    const newId = storiesData.length + 1;
    const newStoryData = { ...newStory, id: newId,user:user.username };
    setStoriesData((prevStories) => [...prevStories, newStoryData]);
    setShowModal(false); 
    setNewStory({ videoUrl: ""}); 
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setNewStory({
      ...newStory,
      [name]: value,
    });
  };

  return (
    <div className="stories-container">
      <Slider ref={sliderRef} {...settings}>
        {storiesData.map((story, index) => (
          <div
            key={story.id}
            className={`story ${index === activeSlide ? "active" : "inactive"}`}
          >
            {story.type === "youtube" ? (
              <iframe
                id={`youtube-${index}`} 
                width="100%"
                height="200"
                src={
                  index === activeSlide
                    ? `${story.videoUrl}?autoplay=1&mute=0` 
                    : `${story.videoUrl}?mute=1` 
                }
                title={`Story by ${story.user}`}
                frameBorder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowFullScreen
              />
            ) : (
              <div>
                {index === activeSlide ? (
                  <video
                    id={`video-${index}`} 
                    width="100%"
                    height="200"
                    controls
                    autoPlay
                    muted={false} 
                    loop
                  >
                    <source src={story.videoUrl} type="video/mp4" />
                    Your browser does not support the video tag.
                  </video>
                ) : (
                  <video
                    id={`video-${index}`} 
                    width="100%"
                    height="200"
                    controls
                    muted={true} 
                  >
                    <source src={story.videoUrl} type="video/mp4" />
                    Your browser does not support the video tag.
                  </video>
                )}
              </div>
            )}
            <div className="story-info">
              <span>{story.user}</span>
            </div>
          </div>
        ))}
      </Slider>

      <button className="prev-button" onClick={goToPrev}>
        &larr;
      </button>

      <button className="next-button" onClick={goToNext}>
        &rarr;
      </button>

      <button className="publish-button" onClick={() => setShowModal(true)}>
        Publikuj story
      </button>

      {showModal && (
        <div className="modal-overlay">
          <div className="modal">
            <h2>Dodaj nowe story</h2>
            <form>
              <label>
                URL wideo:
                <input
                  type="text"
                  name="videoUrl"
                  value={newStory.videoUrl}
                  onChange={handleChange}
                  placeholder="Wprowadź URL wideo"
                />
              </label>
              <button type="button" onClick={handlePublish}>
                Publikuj
              </button>
              <button type="button" onClick={() => setShowModal(false)}>
                Anuluj
              </button>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};

export default Stories;
