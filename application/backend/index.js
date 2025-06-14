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

// Initialize DB: create table and insert row if missing
(async () => {
  await pool.query(`
    CREATE TABLE IF NOT EXISTS clicks (
      id INTEGER PRIMARY KEY,
      count INTEGER NOT NULL
    );
  `);

  const result = await pool.query(`SELECT * FROM clicks WHERE id = 1`);
  if (result.rows.length === 0) {
    await pool.query(`INSERT INTO clicks (id, count) VALUES (1, 0)`);
    console.log("Initialized click count at 0.");
  }
})();

app.get('/api/count', async (req, res) => {
  try {
    const result = await pool.query(`SELECT count FROM clicks WHERE id = 1`);
    res.json({ count: result.rows[0]?.count ?? 0 });
  } catch (error) {
    console.error("GET /api/count failed:", error);
    res.status(500).json({ error: "Failed to fetch count" });
  }
});

app.post('/api/click', async (req, res) => {
  try {
    await pool.query(`UPDATE clicks SET count = count + 1 WHERE id = 1`);
    const result = await pool.query(`SELECT count FROM clicks WHERE id = 1`);
    res.json({ count: result.rows[0]?.count ?? 0 });
  } catch (error) {
    console.error("POST /api/click failed:", error);
    res.status(500).json({ error: "Failed to increment count" });
  }
});

app.listen(port, () => {
  console.log(`Backend listening at http://localhost:${port}`);
});
