/**
 * @file tests/utils/logger.test.ts
 * @description Tests for Logger utility
 */

import { describe, it, expect, beforeEach, vi } from 'vitest';
import { createLogger, resetLogger, getLogger, type LogLevel } from '@utils/logger';

describe('Logger', () => {
  beforeEach(() => {
    resetLogger();
    vi.clearAllMocks();
  });

  describe('createLogger', () => {
    it('should create a new logger instance', () => {
      const logger = createLogger();
      expect(logger).toBeDefined();
      expect(typeof logger.debug).toBe('function');
    });

    it('should respect config options', () => {
      const logger = createLogger({ level: 'error', format: 'text' });
      const config = logger.getConfig();

      expect(config.level).toBe('error');
      expect(config.format).toBe('text');
    });
  });

  describe('getLogger (singleton)', () => {
    it('should return same instance on multiple calls', () => {
      const logger1 = getLogger();
      const logger2 = getLogger();

      expect(logger1).toBe(logger2);
    });

    it('should initialize with default config if not created yet', () => {
      resetLogger();
      const logger = getLogger();
      const config = logger.getConfig();

      expect(config.level).toBe('info');
      expect(config.format).toBe('json');
    });
  });

  describe('Logging levels', () => {
    it('should log at debug level', () => {
      const logger = createLogger({ level: 'debug', format: 'text' });
      const consoleSpy = vi.spyOn(console, 'debug');

      logger.debug('test message');

      expect(consoleSpy).toHaveBeenCalled();
      consoleSpy.mockRestore();
    });

    it('should respect minimum log level', () => {
      const logger = createLogger({ level: 'warn', format: 'text' });
      const infoSpy = vi.spyOn(console, 'log');
      const warnSpy = vi.spyOn(console, 'warn');

      logger.info('info message');
      logger.warn('warn message');

      expect(infoSpy).not.toHaveBeenCalled();
      expect(warnSpy).toHaveBeenCalled();

      infoSpy.mockRestore();
      warnSpy.mockRestore();
    });
  });

  describe('Formatting', () => {
    it('should format as JSON', () => {
      const logger = createLogger({ format: 'json' });
      const consoleSpy = vi.spyOn(console, 'log');

      logger.info('test message', { key: 'value' });

      expect(consoleSpy).toHaveBeenCalledWith(expect.stringContaining('"message":"test message"'));

      consoleSpy.mockRestore();
    });

    it('should format as text', () => {
      const logger = createLogger({ format: 'text' });
      const consoleSpy = vi.spyOn(console, 'log');

      logger.info('test message');

      expect(consoleSpy).toHaveBeenCalledWith(expect.stringContaining('INFO'));
      expect(consoleSpy).toHaveBeenCalledWith(expect.stringContaining('test message'));

      consoleSpy.mockRestore();
    });
  });

  describe('Context and errors', () => {
    it('should include context in log entry', () => {
      const logger = createLogger({ format: 'json' });
      const consoleSpy = vi.spyOn(console, 'log');

      logger.info('test', { userId: 123, action: 'login' });

      expect(consoleSpy).toHaveBeenCalledWith(expect.stringContaining('userId'));
      expect(consoleSpy).toHaveBeenCalledWith(expect.stringContaining('123'));

      consoleSpy.mockRestore();
    });

    it('should include error details', () => {
      const logger = createLogger({ format: 'json' });
      const consoleSpy = vi.spyOn(console, 'error');

      const testError = new Error('test error');
      logger.error('Something failed', testError);

      expect(consoleSpy).toHaveBeenCalledWith(expect.stringContaining('test error'));

      consoleSpy.mockRestore();
    });
  });

  describe('setLevel', () => {
    it('should change log level dynamically', () => {
      const logger = createLogger({ level: 'error' });
      const debugSpy = vi.spyOn(console, 'debug');

      logger.debug('should not log');
      expect(debugSpy).not.toHaveBeenCalled();

      logger.setLevel('debug');
      logger.debug('should log now');
      expect(debugSpy).toHaveBeenCalled();

      debugSpy.mockRestore();
    });
  });
});
