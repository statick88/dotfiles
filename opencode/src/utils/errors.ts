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
export class OpenCodeError extends Error {
  constructor(
    message: string,
    public code: string,
    public context?: ErrorContext,
    public originalError?: Error,
  ) {
    super(message);
    this.name = 'OpenCodeError';
    Object.setPrototypeOf(this, OpenCodeError.prototype);
    Error.captureStackTrace(this, this.constructor);
  }

  toJSON() {
    return {
      name: this.name,
      message: this.message,
      code: this.code,
      context: this.context,
      originalError: this.originalError ? { message: this.originalError.message, stack: this.originalError.stack } : undefined,
    };
  }
}

/**
 * Configuration validation error
 */
export class ConfigurationError extends OpenCodeError {
  constructor(message: string, context?: ErrorContext, originalError?: Error) {
    super(message, 'CONFIG_ERROR', context, originalError);
    this.name = 'ConfigurationError';
    Object.setPrototypeOf(this, ConfigurationError.prototype);
  }
}

/**
 * Plugin loading/execution error
 */
export class PluginError extends OpenCodeError {
  constructor(message: string, context?: ErrorContext, originalError?: Error) {
    super(message, 'PLUGIN_ERROR', context, originalError);
    this.name = 'PluginError';
    Object.setPrototypeOf(this, PluginError.prototype);
  }
}

/**
 * MCP server communication error
 */
export class MCPError extends OpenCodeError {
  constructor(message: string, context?: ErrorContext, originalError?: Error) {
    super(message, 'MCP_ERROR', context, originalError);
    this.name = 'MCPError';
    Object.setPrototypeOf(this, MCPError.prototype);
  }
}

/**
 * HTTP/Network error
 */
export class NetworkError extends OpenCodeError {
  constructor(
    message: string,
    public statusCode?: number,
    context?: ErrorContext,
    originalError?: Error,
  ) {
    super(message, 'NETWORK_ERROR', context, originalError);
    this.name = 'NetworkError';
    Object.setPrototypeOf(this, NetworkError.prototype);
  }
}

/**
 * Validation error
 */
export class ValidationError extends OpenCodeError {
  constructor(
    message: string,
    public validationErrors?: string[],
    context?: ErrorContext,
  ) {
    super(message, 'VALIDATION_ERROR', context);
    this.name = 'ValidationError';
    Object.setPrototypeOf(this, ValidationError.prototype);
  }
}

/**
 * Timeout error
 */
export class TimeoutError extends OpenCodeError {
  constructor(message: string, public timeoutMs?: number, context?: ErrorContext) {
    super(message, 'TIMEOUT_ERROR', context);
    this.name = 'TimeoutError';
    Object.setPrototypeOf(this, TimeoutError.prototype);
  }
}

/**
 * Helper function to safely execute a function with error handling
 */
export async function tryCatch<T>(
  fn: () => Promise<T>,
  errorHandler?: (error: Error) => Promise<T | undefined>,
): Promise<T | undefined> {
  try {
    return await fn();
  } catch (error) {
    if (errorHandler && error instanceof Error) {
      return await errorHandler(error);
    }
    throw error;
  }
}

/**
 * Helper function to safely execute a sync function with error handling
 */
export function tryCatchSync<T>(
  fn: () => T,
  errorHandler?: (error: Error) => T | undefined,
): T | undefined {
  try {
    return fn();
  } catch (error) {
    if (errorHandler && error instanceof Error) {
      return errorHandler(error);
    }
    throw error;
  }
}

/**
 * Determine if an error is a retriable error (transient)
 */
export function isRetriableError(error: unknown): boolean {
  if (error instanceof NetworkError) {
    // 429 (Too Many Requests), 503 (Service Unavailable), 504 (Gateway Timeout) are retriable
    return error.statusCode ? [429, 503, 504].includes(error.statusCode) : true;
  }

  if (error instanceof TimeoutError) {
    return true;
  }

  return false;
}

/**
 * Retry a function with exponential backoff
 */
export async function retryWithBackoff<T>(
  fn: () => Promise<T>,
  options: { maxAttempts?: number; initialDelayMs?: number; maxDelayMs?: number } = {},
): Promise<T> {
  const { maxAttempts = 3, initialDelayMs = 100, maxDelayMs = 10000 } = options;

  let lastError: Error | undefined;

  for (let attempt = 0; attempt < maxAttempts; attempt++) {
    try {
      return await fn();
    } catch (error) {
      lastError = error instanceof Error ? error : new Error(String(error));

      if (!isRetriableError(error) || attempt === maxAttempts - 1) {
        throw lastError;
      }

      // Exponential backoff with jitter
      const delayMs = Math.min(initialDelayMs * Math.pow(2, attempt) + Math.random() * 100, maxDelayMs);
      await new Promise((resolve) => setTimeout(resolve, delayMs));
    }
  }

  throw lastError || new Error('Unknown error during retry');
}
