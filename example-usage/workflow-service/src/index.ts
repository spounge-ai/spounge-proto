// index.ts

import { WorkflowServer } from './server';
import { Logger } from './utils/logger';

if (!process.env.KEY_PATH || !process.env.CERT_PATH) {
  Logger.error('Missing required environment variables: KEY_PATH and CERT_PATH');
  process.exit(1);
}

async function main() {
  try {
    const server = new WorkflowServer({
      port: parseInt(process.env.PORT || '8080'),
      host: process.env.HOST || 'localhost',
      corsOrigins: process.env.CORS_ORIGINS?.split(',') || ['*'],
      enableLogging: process.env.NODE_ENV !== 'production',

      keyPath: process.env.KEY_PATH || (() => { throw new Error('KEY_PATH is not defined'); })(),
      certPath: process.env.CERT_PATH || (() => { throw new Error('CERT_PATH is not defined'); })(),
    });

    await server.start();
  } catch (error) {
    Logger.error('Failed to start server', error);
    process.exit(1);
  }
}

process.on('SIGINT', () => {
  Logger.info('Received SIGINT, shutting down gracefully...');
  process.exit(0);
});

process.on('SIGTERM', () => {
  Logger.info('Received SIGTERM, shutting down gracefully...');
  process.exit(0);
});

if (require.main === module) {
  main();
}

export { WorkflowServer };
export * from './types/workflow.types';
export * from './services/workflow.service';