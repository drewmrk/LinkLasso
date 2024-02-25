import { Database } from 'bun:sqlite';

const db = new Database('shortenedURLs.db');
db.query(
  `
CREATE TABLE IF NOT EXISTS ShortenedURLs (
  Hash         TEXT NOT NULL,
  ShortenedURL TEXT NOT NULL,
  FullURL      TEXT NOT NULL
)
`
).run();
db.close();
