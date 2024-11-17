import React, { useEffect, useState } from 'react';
import './motto.css';  
import duze_logo from '../../assets/Pictures/logo-duze.png'
const Motto = () => {
  const quotes = [
    "Dołącz do nas!",
    "Każde słowo łączy!",
    "Podziel się światem z innymi!",
    "Bez łączności nie ma postępu!",
    "Silna komunikacja to podstawa!"
  ];

  const [text, setText] = useState('');
  const [currentQuoteIndex, setCurrentQuoteIndex] = useState(0); // Index obecnego cytatu
  
  useEffect(() => {
    const fullQuote = quotes[currentQuoteIndex];
    let index = 0;

    // Funkcja animująca pisanie i cofanie tekstu
    const typingInterval = setInterval(() => {
      
      setText(prevText => prevText + fullQuote[index]);
      index++;
      
      // Po zakończeniu pisania pełnego cytatu, uruchamiamy efekt cofania
      if (index === fullQuote.length) {
        clearInterval(typingInterval);
        
        setTimeout(() => {
          let removeIndex = fullQuote.length - 1;
          const erasingInterval = setInterval(() => {
            setText(prevText => prevText.slice(0, removeIndex));
            removeIndex--;

            if (removeIndex < 0) {
              clearInterval(erasingInterval);
              setCurrentQuoteIndex(prevIndex => (prevIndex + 1) % quotes.length); // Przechodzimy do kolejnego cytatu
            }
          }, 100);  // Co 100 ms usuwamy jedną literę
        }, 2000);  // Czekamy 2 sekundy przed rozpoczęciem cofania
      }
    }, 100);  // Co 100 ms dodajemy jedną literę

    return () => clearInterval(typingInterval);  // Czyszczenie interwału przy odmontowaniu komponentu
  }, [currentQuoteIndex]); // Zmieniamy cytat tylko, gdy `currentQuoteIndex` się zmienia

  return (
    <div className="quote-container">
      {/* Dodajemy obrazek nad cytatem */}
      <div className="image-container">
        <img src={duze_logo} alt="Motywacyjny obrazek" className="quote-image" />
      </div>
      
      <div className="quote-wrapper">
        <span className="quote">{text}</span>
        <span className="cursor">|</span> {/* Dodajemy migający kursor */}
      </div>
    </div>
  );
};

export default Motto;
