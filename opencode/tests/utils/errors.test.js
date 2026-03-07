/**
 * @file tests/utils/errors.test.ts
 * @description Tests for error handling utilities
 */
import { describe, it, expect } from 'vitest';
import { OpenCodeError, ConfigurationError, PluginError, NetworkError, ValidationError, TimeoutError, isRetriableError, retryWithBackoff, tryCatch, tryCatchSync, } from '@utils/errors';
describe('Error Classes', () => {
    describe('OpenCodeError', () => {
        it('should create error with message and code', () => {
            const error = new OpenCodeError('test message', 'TEST_CODE');
            expect(error.message).toBe('test message');
            expect(error.code).toBe('TEST_CODE');
            expect(error.name).toBe('OpenCodeError');
        });
        it('should include context and original error', () => {
            const originalError = new Error('original');
            const context = { details: 'test' };
            const error = new OpenCodeError('wrapper', 'WRAP_CODE', context, originalError);
            expect(error.context).toEqual(context);
            expect(error.originalError).toBe(originalError);
        });
        it('should convert to JSON', () => {
            const error = new OpenCodeError('test', 'CODE', { key: 'value' });
            const json = error.toJSON();
            expect(json.message).toBe('test');
            expect(json.code).toBe('CODE');
            expect(json.context).toEqual({ key: 'value' });
        });
    });
    describe('Specific error types', () => {
        it('should create ConfigurationError', () => {
            const error = new ConfigurationError('bad config');
            expect(error.name).toBe('ConfigurationError');
            expect(error.code).toBe('CONFIG_ERROR');
        });
        it('should create PluginError', () => {
            const error = new PluginError('plugin failed');
            expect(error.name).toBe('PluginError');
            expect(error.code).toBe('PLUGIN_ERROR');
        });
        it('should create NetworkError with status code', () => {
            const error = new NetworkError('request failed', 503);
            expect(error.name).toBe('NetworkError');
            expect(error.statusCode).toBe(503);
        });
        it('should create ValidationError with validation errors', () => {
            const validationErrors = ['field1 is required', 'field2 must be a number'];
            const error = new ValidationError('validation failed', validationErrors);
            expect(error.name).toBe('ValidationError');
            expect(error.validationErrors).toEqual(validationErrors);
        });
        it('should create TimeoutError with timeout duration', () => {
            const error = new TimeoutError('timed out', 5000);
            expect(error.name).toBe('TimeoutError');
            expect(error.timeoutMs).toBe(5000);
        });
    });
});
describe('Error handling utilities', () => {
    describe('isRetriableError', () => {
        it('should identify retriable network errors', () => {
            expect(isRetriableError(new NetworkError('too many requests', 429))).toBe(true);
            expect(isRetriableError(new NetworkError('service unavailable', 503))).toBe(true);
            expect(isRetriableError(new NetworkError('gateway timeout', 504))).toBe(true);
        });
        it('should not identify non-retriable network errors', () => {
            expect(isRetriableError(new NetworkError('not found', 404))).toBe(false);
            expect(isRetriableError(new NetworkError('forbidden', 403))).toBe(false);
        });
        it('should identify TimeoutError as retriable', () => {
            expect(isRetriableError(new TimeoutError('timed out'))).toBe(true);
        });
        it('should not identify other errors as retriable', () => {
            expect(isRetriableError(new ConfigurationError('bad config'))).toBe(false);
            expect(isRetriableError(new Error('generic error'))).toBe(false);
        });
    });
    describe('retryWithBackoff', () => {
        it('should succeed on first attempt', async () => {
            let attempts = 0;
            const fn = async () => {
                attempts++;
                return 'success';
            };
            const result = await retryWithBackoff(fn);
            expect(result).toBe('success');
            expect(attempts).toBe(1);
        });
        it('should retry on retriable errors', async () => {
            let attempts = 0;
            const fn = async () => {
                attempts++;
                if (attempts < 3) {
                    throw new NetworkError('service unavailable', 503);
                }
                return 'success';
            };
            const result = await retryWithBackoff(fn, { maxAttempts: 5 });
            expect(result).toBe('success');
            expect(attempts).toBe(3);
        });
        it('should not retry on non-retriable errors', async () => {
            let attempts = 0;
            const fn = async () => {
                attempts++;
                throw new ConfigurationError('bad config');
            };
            await expect(retryWithBackoff(fn)).rejects.toThrow(ConfigurationError);
            expect(attempts).toBe(1);
        });
        it('should throw after max attempts', async () => {
            let attempts = 0;
            const fn = async () => {
                attempts++;
                throw new NetworkError('service unavailable', 503);
            };
            await expect(retryWithBackoff(fn, { maxAttempts: 3 })).rejects.toThrow(NetworkError);
            expect(attempts).toBe(3);
        });
    });
    describe('tryCatch', () => {
        it('should execute successful async function', async () => {
            const fn = async () => 'success';
            const result = await tryCatch(fn);
            expect(result).toBe('success');
        });
        it('should handle error with error handler', async () => {
            const fn = async () => {
                throw new Error('test error');
            };
            const errorHandler = async () => 'fallback';
            const result = await tryCatch(fn, errorHandler);
            expect(result).toBe('fallback');
        });
        it('should throw if no error handler', async () => {
            const fn = async () => {
                throw new Error('test error');
            };
            await expect(tryCatch(fn)).rejects.toThrow();
        });
    });
    describe('tryCatchSync', () => {
        it('should execute successful sync function', () => {
            const fn = () => 'success';
            const result = tryCatchSync(fn);
            expect(result).toBe('success');
        });
        it('should handle error with error handler', () => {
            const fn = () => {
                throw new Error('test error');
            };
            const errorHandler = () => 'fallback';
            const result = tryCatchSync(fn, errorHandler);
            expect(result).toBe('fallback');
        });
    });
});
//# sourceMappingURL=errors.test.js.map