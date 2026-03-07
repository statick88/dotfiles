/**
 * @file src/utils/errors.ts
 * @description Custom error types and error handling utilities
 */
export interface ErrorContext {
    [key: string]: unknown;
}
/**
 * Base error class for all OpenCode errors
 */
export declare class OpenCodeError extends Error {
    code: string;
    context?: ErrorContext | undefined;
    originalError?: Error | undefined;
    constructor(message: string, code: string, context?: ErrorContext | undefined, originalError?: Error | undefined);
    toJSON(): {
        name: string;
        message: string;
        code: string;
        context: ErrorContext | undefined;
        originalError: {
            message: string;
            stack: string | undefined;
        } | undefined;
    };
}
/**
 * Configuration validation error
 */
export declare class ConfigurationError extends OpenCodeError {
    constructor(message: string, context?: ErrorContext, originalError?: Error);
}
/**
 * Plugin loading/execution error
 */
export declare class PluginError extends OpenCodeError {
    constructor(message: string, context?: ErrorContext, originalError?: Error);
}
/**
 * MCP server communication error
 */
export declare class MCPError extends OpenCodeError {
    constructor(message: string, context?: ErrorContext, originalError?: Error);
}
/**
 * HTTP/Network error
 */
export declare class NetworkError extends OpenCodeError {
    statusCode?: number | undefined;
    constructor(message: string, statusCode?: number | undefined, context?: ErrorContext, originalError?: Error);
}
/**
 * Validation error
 */
export declare class ValidationError extends OpenCodeError {
    validationErrors?: string[] | undefined;
    constructor(message: string, validationErrors?: string[] | undefined, context?: ErrorContext);
}
/**
 * Timeout error
 */
export declare class TimeoutError extends OpenCodeError {
    timeoutMs?: number | undefined;
    constructor(message: string, timeoutMs?: number | undefined, context?: ErrorContext);
}
/**
 * Helper function to safely execute a function with error handling
 */
export declare function tryCatch<T>(fn: () => Promise<T>, errorHandler?: (error: Error) => Promise<T | undefined>): Promise<T | undefined>;
/**
 * Helper function to safely execute a sync function with error handling
 */
export declare function tryCatchSync<T>(fn: () => T, errorHandler?: (error: Error) => T | undefined): T | undefined;
/**
 * Determine if an error is a retriable error (transient)
 */
export declare function isRetriableError(error: unknown): boolean;
/**
 * Retry a function with exponential backoff
 */
export declare function retryWithBackoff<T>(fn: () => Promise<T>, options?: {
    maxAttempts?: number;
    initialDelayMs?: number;
    maxDelayMs?: number;
}): Promise<T>;
//# sourceMappingURL=errors.d.ts.map