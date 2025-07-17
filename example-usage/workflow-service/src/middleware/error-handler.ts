// src/middleware/error-handler.ts
import { ConnectError, Code } from '@connectrpc/connect';
import { Logger } from '../utils/logger';

export class ErrorHandler {
  static handleError(error: any): ConnectError {
    Logger.error('Unhandled error', error);
    
    if (error instanceof ConnectError) {
      return error;
    }
    
    return new ConnectError(
      'Internal server error',
      Code.Internal,
      undefined,
      undefined,
      error
    );
  }
}