const express = require('express');
const cors = require('cors');
const app = express();
const port = 300;

app.use(cors());

let clickCount = 0;

app.get('/api/count', (req, res) => {
  res.json({ count: clickCount });
});

app.post('/api/click', (req, res) => {
  clickCount++;
  res.json({ count: clickCount });
});

app.listen(port, () => {
  console.log(`Backend listening at http://localhost:${port}`);
});