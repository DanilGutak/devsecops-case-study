import React, { useState, useEffect } from 'react';

function App() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    fetch('/api/count')
      .then(res => res.json())
      .then(data => setCount(data.count));
  }, []);

  const handleClick = () => {
    fetch('/api/click', { method: 'POST' })
      .then(res => res.json())
      .then(data => setCount(data.count));
  };

  return (
    <div style={{ textAlign: 'center', marginTop: '5rem' }}>
      <h1>Click Counter</h1>
      <p>Clicks: {count}</p>
      <button onClick={handleClick}>Click Me</button>
    </div>
  );
}

export default App;