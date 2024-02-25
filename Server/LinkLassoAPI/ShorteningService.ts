import { host, port } from '.';
import type ShorteningServiceResponse from './ShorteningServiceResponse';
import { Database } from 'bun:sqlite';

const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
const insertIntoDBSQL = `
  INSERT INTO ShortenedURLs
  VALUES ($hash, $shortenedURL, $fullURL)
`;
const retrieveFullURLSQL = `
  SELECT FullURL AS FullURL
  FROM ShortenedURLs
  WHERE Hash = $hash
`;

export const shortenURL = (fullURL: string): ShorteningServiceResponse => {
  const randomHash = generateRandomHash();

  const shortenedURL = `http://${host}:${port}/${randomHash}`;

  insertEntryIntoDB(randomHash, shortenedURL, fullURL);

  return { successful: true, shortenedURL };
};

const generateRandomHash = (): string => {
  let result = '';

  for (let i = 0; i < 8; i++) {
    result += letters.charAt(Math.floor(Math.random() * letters.length));
  }

  return result;
};

const insertEntryIntoDB = (
  randomHash: string,
  shortenedURL: string,
  fullURL: string
): void => {
  const db = new Database('shortenedURLs.db');
  const insertQuery = db.query(insertIntoDBSQL);

  insertQuery.all({
    $hash: randomHash,
    $shortenedURL: shortenedURL,
    $fullURL: fullURL
  });
  insertQuery.run();

  db.close();
};

interface IFullURL {
  FullURL: string;
}

export const retrieveFullURL = (hash: string): string => {
  const db = new Database('shortenedURLs.db');
  const retrieveQuery = db.query(retrieveFullURLSQL);

  retrieveQuery.all({ $hash: hash });

  const result = (retrieveQuery.get() as IFullURL).FullURL;

  db.close();

  return result;
};
