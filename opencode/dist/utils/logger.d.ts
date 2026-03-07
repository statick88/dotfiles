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
export declare class Logger {
    private config;
    private levelOrder;
    constructor(config?: Partial<LoggerConfig>);
    private shouldLog;
    private formatTimestamp;
    private createEntry;
    private formatEntry;
    private log;
    debug(message: string, context?: Record<string, unknown>): void;
    info(message: string, context?: Record<string, unknown>): void;
    warn(message: string, context?: Record<string, unknown>, error?: Error): void;
    error(message: string, error?: Error | null, context?: Record<string, unknown>): void;
    setLevel(level: LogLevel): void;
    getConfig(): LoggerConfig;
}
export declare function getLogger(config?: Partial<LoggerConfig>): Logger;
export declare function createLogger(config?: Partial<LoggerConfig>): Logger;
export declare function resetLogger(): void;
//# sourceMappingURL=logger.d.ts.map