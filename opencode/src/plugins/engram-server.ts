/**
 * @file src/plugins/engram-server.ts
 * @description Engram server management — spawn binary, load manifest
 */

import { getLogger } from '@utils/logger';
import { HTTP_CONFIG } from '@core/constants';
import { EngramHttpClient } from './engram-http-client';

// Bun subprocess type — dynamically imported
type Subprocess = any; // eslint-disable-line @typescript-eslint/no-explicit-any

const logger = getLogger();

export interface EngramServerConfig {
  binaryPath?: string;
  port?: number;
  logLevel?: 'debug' | 'info' | 'warn' | 'error';
}

export class EngramServer {
  private subprocess: Subprocess | null = null;
  private config: Required<EngramServerConfig>;
  private httpClient: EngramHttpClient;
  private isReady: boolean = false;

  constructor(config: EngramServerConfig = {}) {
    this.config = {
      binaryPath: config.binaryPath || 'engram',
      port: config.port || HTTP_CONFIG.port,
      logLevel: config.logLevel || 'info',
    };

    this.httpClient = new EngramHttpClient({
      baseUrl: `http://localhost:${this.config.port}`,
      timeout: HTTP_CONFIG.timeout,
      logLevel: this.config.logLevel,
    });
  }

  /**
   * Spawn the Engram server process
   */
  async start(): Promise<void> {
    if (this.subprocess) {
      logger.info('Engram server already running');
      return;
    }

    try {
      logger.info('Starting Engram server', { binaryPath: this.config.binaryPath, port: this.config.port });

      // Dynamically import spawn from Bun
      // @ts-ignore - Bun is runtime-only, types not available in all environments
      const { spawn } = await import('bun');

      this.subprocess = spawn([this.config.binaryPath, 'server'], {
        cwd: process.cwd(),
        stdio: ['inherit', 'pipe', 'pipe'],
        env: {
          ...process.env,
          ENGRAM_PORT: String(this.config.port),
          ENGRAM_LOG_LEVEL: this.config.logLevel,
        },
      });

      // Pipe stdout/stderr to logger (non-blocking)
      if (this.subprocess.stdout) {
        this.pipeStream(this.subprocess.stdout, 'info');
      }
      if (this.subprocess.stderr) {
        this.pipeStream(this.subprocess.stderr, 'warn');
      }

      // Wait for server to be ready (health check)
      await this.waitForReady(30000); // 30 second timeout
      this.isReady = true;
      logger.info('Engram server ready');
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : String(error);
      logger.error('Failed to start Engram server', error instanceof Error ? error : new Error(errorMessage), {
        binaryPath: this.config.binaryPath,
      });
      this.isReady = false;
      this.subprocess = null;
      throw error;
    }
  }

  /**
   * Stop the Engram server process
   */
  async stop(): Promise<void> {
    if (!this.subprocess) {
      return;
    }

    try {
      logger.info('Stopping Engram server');
      this.subprocess.kill();
      await this.subprocess.exited;
      this.subprocess = null;
      this.isReady = false;
      logger.info('Engram server stopped');
    } catch (error) {
      logger.warn('Error stopping Engram server', { error: error instanceof Error ? error.message : String(error) });
    }
  }

  /**
   * Check if server is running and healthy
   */
  isRunning(): boolean {
    return this.isReady && (this.subprocess?.pid ?? null) !== null;
  }

  /**
   * Get the HTTP client instance
   */
  getHttpClient(): EngramHttpClient {
    return this.httpClient;
  }

  /**
   * Load Engram manifest (tools, capabilities)
   */
  async loadManifest(): Promise<Record<string, any>> {
    if (!this.isRunning()) {
      logger.warn('Engram server not running, cannot load manifest');
      return {};
    }

    try {
      const manifest = await this.httpClient.fetchWithRetry('/manifest');
      logger.debug('Engram manifest loaded', { tools: Object.keys(manifest?.tools || {}).length });
      return manifest;
    } catch (error) {
      logger.error('Failed to load Engram manifest', error instanceof Error ? error : new Error(String(error)));
      return {};
    }
  }

  /**
   * Private: Pipe stream output to logger
   */
  private pipeStream(stream: NodeJS.ReadableStream, level: 'info' | 'warn'): void {
    const rl = require('readline').createInterface({
      input: stream,
      crlfDelay: Infinity,
    });

    rl.on('line', (line: string) => {
      logger[level](`[Engram Server] ${line}`);
    });

    rl.on('close', () => {
      // Stream closed
    });
  }

  /**
   * Private: Wait for server to be ready (health check)
   */
  private async waitForReady(timeoutMs: number): Promise<void> {
    const startTime = Date.now();
    const pollIntervalMs = 500;

    while (Date.now() - startTime < timeoutMs) {
      try {
        const response = await this.httpClient.fetch('/health');
        if (response?.status === 'ok') {
          return;
        }
      } catch (error) {
        // Server not ready yet, retry
      }

      await new Promise((resolve) => setTimeout(resolve, pollIntervalMs));
    }

    throw new Error(`Engram server did not become ready within ${timeoutMs}ms`);
  }
}
