/**
 * @file src/utils/logger.ts
 * @description Structured logging utility with levels and JSON/text formatting
 */
export class Logger {
    config;
    levelOrder = {
        debug: 0,
        info: 1,
        warn: 2,
        error: 3,
    };
    constructor(config = {}) {
        this.config = {
            level: config.level ?? 'info',
            format: config.format ?? 'json',
            prettify: config.prettify ?? false,
        };
    }
    shouldLog(level) {
        return this.levelOrder[level] >= this.levelOrder[this.config.level];
    }
    formatTimestamp() {
        return new Date().toISOString();
    }
    createEntry(level, message, context, error) {
        const entry = {
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
    formatEntry(entry) {
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
    log(entry) {
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
    debug(message, context) {
        if (this.shouldLog('debug')) {
            this.log(this.createEntry('debug', message, context));
        }
    }
    info(message, context) {
        if (this.shouldLog('info')) {
            this.log(this.createEntry('info', message, context));
        }
    }
    warn(message, context, error) {
        if (this.shouldLog('warn')) {
            this.log(this.createEntry('warn', message, context, error));
        }
    }
    error(message, error = null, context) {
        if (this.shouldLog('error')) {
            this.log(this.createEntry('error', message, context, error ?? undefined));
        }
    }
    setLevel(level) {
        this.config.level = level;
    }
    getConfig() {
        return { ...this.config };
    }
}
// Singleton instance
let loggerInstance = null;
export function getLogger(config) {
    if (!loggerInstance) {
        loggerInstance = new Logger(config);
    }
    return loggerInstance;
}
export function createLogger(config) {
    return new Logger(config);
}
export function resetLogger() {
    loggerInstance = null;
}
//# sourceMappingURL=logger.js.map