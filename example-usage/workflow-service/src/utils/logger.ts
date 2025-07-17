const isJest = !!process.env.JEST_WORKER_ID;
const verboseLogs = process.env.VERBOSE_LOGS === '1';

export class Logger {
  static info(message: string, data?: any): void {
    if (isJest && !verboseLogs) return;  

    if (data === undefined || data === null || (typeof data === 'object' && Object.keys(data).length === 0)) {
      console.log(`[INFO] ${message}`);
    } else {
      console.log(`[INFO] ${message}`, data);
    }
  }

  static error(message: string, error?: any): void {
    if (isJest && !verboseLogs) return; 

    if (!error) {
      console.error(`[ERROR] ${message}`);
      return;
    }

    if (error instanceof Error) {
      const code = (error as any).code ? ` [code: ${(error as any).code}]` : '';
      console.error(`[ERROR] ${message}${code}: ${error.message}`);
    } else if (typeof error === 'object') {
      try {
        const summary = JSON.stringify(error, Object.keys(error).slice(0, 5));
        console.error(`[ERROR] ${message}: ${summary}`);
      } catch {
        console.error(`[ERROR] ${message}: [Unserializable error object]`);
      }
    } else {
      console.error(`[ERROR] ${message}:`, error);
    }
  }

  static debug(message: string, data?: any): void {
    if (process.env.NODE_ENV !== 'development') return;
    if (isJest && !verboseLogs) return;

    if (data === undefined || data === null || (typeof data === 'object' && Object.keys(data).length === 0)) {
      console.debug(`[DEBUG] ${message}`);
    } else {
      console.debug(`[DEBUG] ${message}`, data);
    }
  }
}
