import React, { useEffect, useRef } from 'react';
import './Snowfall.css';

const Snowfall = () => {
  const snowfallRef = useRef(null);

  useEffect(() => {
    const container = snowfallRef.current;

    // Funkcja generująca płatki śniegu
    const createSnowflakes = (count) => {
      for (let i = 0; i < count; i++) {
        const snowflake = document.createElement('div');
        snowflake.classList.add('snowflake');
        container.appendChild(snowflake);

        // Losowa wielkość płatków
        const width = Math.random() * 10 + 25; // Płatki od 25px do 35px
        const height = width - 20;
        snowflake.style.width = `${width}px`;  // Poprawione interpolowanie zmiennych
        snowflake.style.height = `${height}px`; // Poprawione interpolowanie zmiennych

        // Losowa prędkość opadania
        const duration = Math.random() * 5 + 4; // Czas opadania od 4s do 9s
        snowflake.style.animationDuration = `${duration}s`; // Poprawione interpolowanie zmiennych

        // Losowe przesunięcie na osi X (używamy vw, aby było to niezależne od szerokości okna)
        const randomX = Math.random() * 100; // Przesunięcie na całej szerokości okna (od 0vw do 100vw)
        snowflake.style.setProperty('--random-x', `${randomX}vw`); // Poprawione interpolowanie zmiennych

        // Losowe opóźnienie animacji, aby płatki zaczynały opadać w różnym czasie
        const delay = Math.random() * 3; // Opóźnienie od 0 do 3 sekund
        snowflake.style.animationDelay = `${delay}s`; // Poprawione interpolowanie zmiennych

        // Animacja spadania płatków
        snowflake.style.animationName = 'fall';
      }
    };

    // Generujemy 50 płatków śniegu
    createSnowflakes(30);

    // Czyszczenie płatków po unmount komponentu
    return () => {
      container.innerHTML = '';
    };
  }, []);

  return <div ref={snowfallRef} className="snowfall"></div>;
};

export default Snowfall;
