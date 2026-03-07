/**
 * @file src/plugins/engram-http-client.ts
 * @description HTTP client for Engram API calls with retry logic
 */
import { getLogger } from '@utils/logger';
import { retryWithBackoff } from '@utils/errors';
import { HTTP_CONFIG } from '@core/constants';
const logger = getLogger();
export class EngramHttpClient {
    baseUrl;
    timeout;
    logLevel;
    constructor(config) {
        this.baseUrl = config.baseUrl;
        this.timeout = config.timeout ?? HTTP_CONFIG.timeout;
        this.logLevel = config.logLevel ?? 'warn';
    }
    /**
     * Make HTTP request to Engram API
     * Returns null on error (silently fails if server not running)
     */
    async fetch(path, opts = {}) {
        const url = `${this.baseUrl}${path}`;
        const method = opts.method ?? 'GET';
        try {
            const controller = new AbortController();
            const timeoutId = setTimeout(() => controller.abort(), this.timeout);
            const response = await fetch(url, {
                method,
                headers: opts.body
                    ? { 'Content-Type': 'application/json' }
                    : undefined,
                body: opts.body ? JSON.stringify(opts.body) : undefined,
                signal: controller.signal,
            });
            clearTimeout(timeoutId);
            if (this.logLevel === 'debug') {
                logger.debug(`Engram ${method} ${path}`, {
                    status: response.status,
                    ok: response.ok,
                });
            }
            const data = await response.json();
            return data;
        }
        catch (error) {
            if (this.logLevel !== 'error')
                return null;
            logger.warn(`Engram request failed: ${method} ${path}`, {
                error: error instanceof Error
                    ? { message: error.message, name: error.name }
                    : error,
            });
            return null;
        }
    }
    /**
     * Check if Engram server is running (health check)
     */
    async isRunning() {
        try {
            const controller = new AbortController();
            const timeoutId = setTimeout(() => controller.abort(), 500);
            const response = await fetch(`${this.baseUrl}/health`, {
                signal: controller.signal,
            });
            clearTimeout(timeoutId);
            if (this.logLevel === 'debug') {
                logger.debug('Engram health check', { ok: response.ok });
            }
            return response.ok;
        }
        catch {
            return false;
        }
    }
    /**
     * Make request with retry logic (for critical operations)
     */
    async fetchWithRetry(path, opts = {}) {
        return retryWithBackoff(async () => this.fetch(path, opts), { maxAttempts: 3, initialDelayMs: 100, maxDelayMs: 10000 });
    }
}
//# sourceMappingURL=engram-http-client.js.map