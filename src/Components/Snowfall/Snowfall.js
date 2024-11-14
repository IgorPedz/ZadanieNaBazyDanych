import React, { useEffect, useRef } from 'react';
import './Snowfall.css';

const Snowfall = () => {
  const snowfallRef = useRef(null);

  useEffect(() => {
    const container = snowfallRef.current;

    const createSnowflakes = (count) => {
      for (let i = 0; i < count; i++) {
        const snowflake = document.createElement('div');
        snowflake.classList.add('snowflake');
        container.appendChild(snowflake);

        const width = Math.random() * 10 + 25; 
        const height = width - 20;
        snowflake.style.width = `${width}px`;  
        snowflake.style.height = `${height}px`; 

        const duration = Math.random() * 5 + 4; 
        snowflake.style.animationDuration = `${duration}s`; 

        const randomX = Math.random() * 100;
        snowflake.style.setProperty('--random-x', `${randomX}vw`); 

        const delay = Math.random() * 3; 
        snowflake.style.animationDelay = `${delay}s`; 

        snowflake.style.animationName = 'fall';
      }
    };

    createSnowflakes(30);

    return () => {
      container.innerHTML = '';
    };
  }, []);

  return <div ref={snowfallRef} className="snowfall"></div>;
};

export default Snowfall;
