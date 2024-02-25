import Fastify from 'fastify';
import './setupDB';
import type ShorteningServiceResponse from './ShorteningServiceResponse';
import { retrieveFullURL, shortenURL } from './ShorteningService';
import type ShorteningServiceRequest from './ShorteningServiceRequest';

export const host = '192.168.0.13';
export const port = 3000;

const fastify = Fastify({
  logger: false
});

fastify.post(
  '/',
  async (request, reply): Promise<ShorteningServiceResponse> => {
    const response = shortenURL(
      (request.body as ShorteningServiceRequest).fullURL
    );
    return response;
  }
);

interface IParams {
  hash: string;
}

fastify.get('/:hash', async (request, reply) => {
  const fullURL = retrieveFullURL((request.params as IParams).hash);

  await reply.redirect(fullURL);
});

try {
  await fastify.listen({ port, host });
} catch (err) {
  fastify.log.error(err);
  process.exit(1);
}
