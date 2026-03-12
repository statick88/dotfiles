/**
 * @file src/utils/logger.ts
 * @description Structured logging utility with levels and JSON/text formatting
 */

export type LogLevel = 'debug' | 'info' | 'warn' | 'error';

export interface LogEntry {
  timestamp: string;
  level: LogLevel;
  message: string;
  context?: Record<string, unknown>;
  error?: {
    name: string;
    message: string;
    stack?: string;
  };
}

export interface LoggerConfig {
  level: LogLevel;
  format: 'json' | 'text';
  prettify: boolean;
}

export class Logger {
  private config: LoggerConfig;
  private levelOrder: Record<LogLevel, number> = {
    debug: 0,
    info: 1,
    warn: 2,
    error: 3,
  };

  constructor(config: Partial<LoggerConfig> = {}) {
    this.config = {
      level: config.level ?? 'info',
      format: config.format ?? 'json',
      prettify: config.prettify ?? false,
    };
  }

  private shouldLog(level: LogLevel): boolean {
    return this.levelOrder[level] >= this.levelOrder[this.config.level];
  }

  private formatTimestamp(): string {
    return new Date().toISOString();
  }

  private createEntry(level: LogLevel, message: string, context?: Record<string, unknown>, error?: Error): LogEntry {
    const entry: LogEntry = {
      timestamp: this.formatTimestamp(),
      level,
      message,
    };

    if (context && Object.keys(context).length > 0) {
      entry.context = context;
    }

    if (error) {
      entry.error = {
        name: error.name,
        message: error.message,
        stack: error.stack,
      };
    }

    return entry;
  }

  private formatEntry(entry: LogEntry): string {
    if (this.config.format === 'json') {
      if (this.config.prettify) {
        return JSON.stringify(entry, null, 2);
      }
      return JSON.stringify(entry);
    }

    // Text format
    const timestamp = entry.timestamp;
    const level = entry.level.toUpperCase().padEnd(5);
    const message = entry.message;
    const contextStr = entry.context ? ` | ${JSON.stringify(entry.context)}` : '';
    const errorStr = entry.error ? ` | ERROR: ${entry.error.name}: ${entry.error.message}` : '';

    return `[${timestamp}] ${level} ${message}${contextStr}${errorStr}`;
  }

  private log(entry: LogEntry): void {
    const formatted = this.formatEntry(entry);

    // Use appropriate console method based on level
    switch (entry.level) {
      case 'debug':
        console.debug(formatted);
        break;
      case 'info':
        console.log(formatted);
        break;
      case 'warn':
        console.warn(formatted);
        break;
      case 'error':
        console.error(formatted);
        break;
    }
  }

  debug(message: string, context?: Record<string, unknown>): void {
    if (this.shouldLog('debug')) {
      this.log(this.createEntry('debug', message, context));
    }
  }

  info(message: string, context?: Record<string, unknown>): void {
    if (this.shouldLog('info')) {
      this.log(this.createEntry('info', message, context));
    }
  }

  warn(message: string, context?: Record<string, unknown>, error?: Error): void {
    if (this.shouldLog('warn')) {
      this.log(this.createEntry('warn', message, context, error));
    }
  }

  error(message: string, error: Error | null = null, context?: Record<string, unknown>): void {
    if (this.shouldLog('error')) {
      this.log(this.createEntry('error', message, context, error ?? undefined));
    }
  }

  setLevel(level: LogLevel): void {
    this.config.level = level;
  }

  getConfig(): LoggerConfig {
    return { ...this.config };
  }
}

// Singleton instance
let loggerInstance: Logger | null = null;

export function getLogger(config?: Partial<LoggerConfig>): Logger {
  if (!loggerInstance) {
    loggerInstance = new Logger(config);
  }
  return loggerInstance;
}

export function createLogger(config?: Partial<LoggerConfig>): Logger {
  return new Logger(config);
}

export function resetLogger(): void {
  loggerInstance = null;
}
