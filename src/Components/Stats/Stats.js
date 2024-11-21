// Stats.js
import React, { useEffect, useState } from 'react';
import Cookies from 'js-cookie'; // Importujemy bibliotekę do pracy z ciasteczkami

const Stats = () => {
  const [visitCount, setVisitCount] = useState(0);

  useEffect(() => {
    // Sprawdzamy, czy jest ciasteczko 'visitCount'
    let currentVisitCount = Cookies.get('visitCount');

    setVisitCount(currentVisitCount); // Ustawiamy stan licznika wizyt
  }, []);

  return (
    <div className="stats">
      <h2>Twoje statystyki:</h2>
      <p>Liczba wizyt: <strong>{visitCount}</strong></p>
    </div>
  );
};

export default Stats;
