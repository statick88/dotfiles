/**
 * @file src/plugins/engram-http-client.ts
 * @description HTTP client for Engram API calls with retry logic
 */
export interface EngramHttpClientConfig {
    baseUrl: string;
    timeout?: number;
    logLevel?: 'debug' | 'info' | 'warn' | 'error';
}
export declare class EngramHttpClient {
    private baseUrl;
    private timeout;
    private logLevel;
    constructor(config: EngramHttpClientConfig);
    /**
     * Make HTTP request to Engram API
     * Returns null on error (silently fails if server not running)
     */
    fetch(path: string, opts?: {
        method?: string;
        body?: any;
    }): Promise<any>;
    /**
     * Check if Engram server is running (health check)
     */
    isRunning(): Promise<boolean>;
    /**
     * Make request with retry logic (for critical operations)
     */
    fetchWithRetry(path: string, opts?: {
        method?: string;
        body?: any;
    }): Promise<any>;
}
//# sourceMappingURL=engram-http-client.d.ts.map