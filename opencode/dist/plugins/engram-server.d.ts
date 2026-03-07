/**
 * @file src/plugins/engram-server.ts
 * @description Engram server management — spawn binary, load manifest
 */
import { EngramHttpClient } from './engram-http-client';
export interface EngramServerConfig {
    binaryPath?: string;
    port?: number;
    logLevel?: 'debug' | 'info' | 'warn' | 'error';
}
export declare class EngramServer {
    private subprocess;
    private config;
    private httpClient;
    private isReady;
    constructor(config?: EngramServerConfig);
    /**
     * Spawn the Engram server process
     */
    start(): Promise<void>;
    /**
     * Stop the Engram server process
     */
    stop(): Promise<void>;
    /**
     * Check if server is running and healthy
     */
    isRunning(): boolean;
    /**
     * Get the HTTP client instance
     */
    getHttpClient(): EngramHttpClient;
    /**
     * Load Engram manifest (tools, capabilities)
     */
    loadManifest(): Promise<Record<string, any>>;
    /**
     * Private: Pipe stream output to logger
     */
    private pipeStream;
    /**
     * Private: Wait for server to be ready (health check)
     */
    private waitForReady;
}
//# sourceMappingURL=engram-server.d.ts.map