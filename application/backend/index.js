const { Pool } = require('pg');
const express = require('express');
const cors = require('cors');
const app = express();
const port = 3001;

app.use(cors());

const pool = new Pool({
  host: 'postgres',
  user: process.env.POSTGRES_USER || 'clickuser',
  password: process.env.POSTGRES_PASSWORD || 'clickpass',
  database: process.env.POSTGRES_DB || 'clickdb',
  port: 5432
});

(async () => {
  await pool.query(`
    CREATE TABLE IF NOT EXISTS clicks (
      id SERIAL PRIMARY KEY,
      count INTEGER NOT NULL
    );
  `);
  const result = await pool.query(`SELECT count(*) FROM clicks`);
  if (result.rows.length === 0) {
    await pool.query(`INSERT INTO clicks (count) VALUES (0)`);
  }
})();

app.get('/api/count', async (req, res) => {
  const result = await pool.query(`SELECT count FROM clicks WHERE id = 1`);
  res.json({ count: result.rows[0].count });
});

app.post('/api/click', async (req, res) => {
  await pool.query(`UPDATE clicks SET count = count + 1 WHERE id = 1`);
  const result = await pool.query(`SELECT count FROM clicks WHERE id = 1`);
  res.json({ count: result.rows[0].count });
});

app.listen(port, () => {
  console.log(`Backend listening at http://localhost:${port}`);
});
