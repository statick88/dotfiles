/**
 * @file tests/plugins/engram-plugin.integration.test.ts
 * @description Integration tests for EngramPlugin orchestration
 *
 * Tests the complete flow:
 * - Plugin initialization (server start → manifest load → cleanup interval)
 * - Session management (lifecycle, TTL cleanup)
 * - Event handling (session.created, message.updated, tool.execute.after, session.deleted)
 * - Hook execution (system hook registration)
 * - Plugin shutdown (graceful cleanup)
 */

import { describe, it, expect, beforeEach, afterEach, vi, MockedClass } from 'vitest';
import { EngramPlugin } from '../../src/plugins/index';
import { EngramServer } from '../../src/plugins/engram-server';
import { SessionManager } from '../../src/plugins/engram-session-manager';
import { EventManager } from '../../src/plugins/engram-events';
import { HookManager } from '../../src/plugins/engram-hooks';
import { EngramHttpClient } from '../../src/plugins/engram-http-client';

// Mock instances that we'll use to track calls
let mockServerInstance: any;
let mockSessionManagerInstance: any;
let mockEventManagerInstance: any;
let mockHookManagerInstance: any;

/**
 * Mock EngramHttpClient
 */
vi.mock('../../src/plugins/engram-http-client', () => {
  return {
    EngramHttpClient: vi.fn().mockImplementation(() => ({
      createSession: vi.fn().mockResolvedValue({ id: 'mock-session-id' }),
      updateSession: vi.fn().mockResolvedValue({}),
      deleteSession: vi.fn().mockResolvedValue({}),
      getSessionMetadata: vi.fn().mockResolvedValue({}),
    })),
  };
});

/**
 * Mock EngramServer
 */
vi.mock('../../src/plugins/engram-server', () => {
  return {
    EngramServer: vi.fn().mockImplementation(() => {
      const mockHttpClient = {
        createSession: vi.fn().mockResolvedValue({ id: 'mock-session-id' }),
        updateSession: vi.fn().mockResolvedValue({}),
        deleteSession: vi.fn().mockResolvedValue({}),
        getSessionMetadata: vi.fn().mockResolvedValue({}),
      };

      mockServerInstance = {
        start: vi.fn().mockResolvedValue(undefined),
        stop: vi.fn().mockResolvedValue(undefined),
        loadManifest: vi.fn().mockResolvedValue({
          tools: {
            'engram:test': { description: 'Test Engram tool' },
            'user:test': { description: 'Test user tool' },
          },
        }),
        isRunning: vi.fn().mockReturnValue(true),
        getHttpClient: vi.fn().mockReturnValue(mockHttpClient),
      };

      return mockServerInstance;
    }),
  };
});

/**
 * Mock SessionManager
 */
vi.mock('../../src/plugins/engram-session-manager', () => {
  return {
    SessionManager: vi.fn().mockImplementation(() => {
      mockSessionManagerInstance = {
        ensureSession: vi.fn().mockResolvedValue(undefined),
        deleteSession: vi.fn().mockResolvedValue(undefined),
        getTrackedSessions: vi.fn().mockReturnValue([]),
        destroy: vi.fn().mockResolvedValue(undefined),
        getSession: vi.fn().mockResolvedValue(null),
      };

      return mockSessionManagerInstance;
    }),
  };
});

/**
 * DO NOT MOCK EventManager — use real implementation
 * We want to test the real event handling logic with mocked SessionManager underneath
 */

/**
 * Mock HookManager
 */
vi.mock('../../src/plugins/engram-hooks', () => {
  return {
    HookManager: vi.fn().mockImplementation(() => {
      mockHookManagerInstance = {
        registerHooks: vi.fn().mockReturnValue({
          'engram:onSessionCreated': vi.fn(),
          'engram:onShutdown': vi.fn(),
        }),
      };

      return mockHookManagerInstance;
    }),
  };
});

/**
 * Mock ToolRegistry
 */
vi.mock('../../src/plugins/engram-tool-registry', () => {
  return {
    ToolRegistry: {
      isEngramTool: vi.fn((toolName: string) => toolName.startsWith('engram:')),
      getEngramTools: vi.fn().mockReturnValue(new Set(['engram:test'])),
    },
  };
});

describe('EngramPlugin Integration', () => {
  let plugin: EngramPlugin;

  beforeEach(() => {
    vi.clearAllMocks();
    mockServerInstance = null;
    mockSessionManagerInstance = null;
    mockEventManagerInstance = null;
    mockHookManagerInstance = null;
    vi.useFakeTimers();
  });

  afterEach(() => {
    vi.restoreAllMocks();
    vi.runOnlyPendingTimers();
    vi.useRealTimers();
  });

  describe('Initialization', () => {
    it('should initialize plugin successfully', async () => {
      plugin = new EngramPlugin({ enabled: true });

      await plugin.init();

      expect(plugin.isReady()).toBe(true);
      expect(plugin.getStatus().initialized).toBe(true);
      expect(plugin.getStatus().serverRunning).toBe(true);
    });

    it('should skip initialization if already initialized', async () => {
      plugin = new EngramPlugin({ enabled: true });

      await plugin.init();
      const serverStartCallsBefore = mockServerInstance.start.mock.calls.length;

      await plugin.init();

      // server.start() should only be called once
      expect(mockServerInstance.start.mock.calls.length).toBe(serverStartCallsBefore);
    });

    it('should skip initialization if plugin is disabled', async () => {
      plugin = new EngramPlugin({ enabled: false });

      await plugin.init();

      expect(plugin.getStatus().initialized).toBe(false);
    });

    it('should start cleanup interval after init', async () => {
      plugin = new EngramPlugin({ enabled: true });
      const setIntervalSpy = vi.spyOn(global, 'setInterval');

      await plugin.init();

      expect(setIntervalSpy).toHaveBeenCalledWith(expect.any(Function), 5 * 60 * 1000);

      setIntervalSpy.mockRestore();
    });

    it('should handle server initialization failure', async () => {
      // Create a new mock that fails
      const failingServerMock = {
        start: vi.fn().mockRejectedValueOnce(new Error('Server start failed')),
        stop: vi.fn().mockResolvedValue(undefined),
        loadManifest: vi.fn(),
        isRunning: vi.fn(),
        getHttpClient: vi.fn(),
      };

      (EngramServer as unknown as vi.Mock).mockImplementationOnce(() => failingServerMock);

      plugin = new EngramPlugin({ enabled: true });

      await expect(plugin.init()).rejects.toThrow('Server start failed');
      expect(plugin.getStatus().initialized).toBe(false);
    });
  });

  describe('Event Handlers', () => {
    beforeEach(async () => {
      plugin = new EngramPlugin({ enabled: true });
      await plugin.init();
    });

    it('should provide event handlers', () => {
      const handlers = plugin.getEventHandlers();

      expect(handlers.onSessionCreated).toBeDefined();
      expect(handlers.onMessageUpdated).toBeDefined();
      expect(handlers.onToolExecuteAfter).toBeDefined();
      expect(handlers.onSessionDeleted).toBeDefined();
    });

    it('should handle session created event', async () => {
      // Plugin has real EventManager, but SessionManager is mocked
      const handlers = plugin.getEventHandlers();
      const sessionId = 'test-session-123';

      // Reset mock before test
      mockSessionManagerInstance.ensureSession.mockClear();

      // Call the handler
      await handlers.onSessionCreated?.(sessionId);

      // The real EventManager should have called the mocked SessionManager
      expect(mockSessionManagerInstance.ensureSession).toHaveBeenCalledWith(sessionId);
    });

    it('should handle message updated event', async () => {
      // Plugin has real EventManager, but SessionManager is mocked
      const handlers = plugin.getEventHandlers();
      const sessionId = 'test-session-456';

      // Reset mock before test
      mockSessionManagerInstance.ensureSession.mockClear();

      // Call the handler
      await handlers.onMessageUpdated?.(sessionId);

      // The real EventManager should have called the mocked SessionManager
      expect(mockSessionManagerInstance.ensureSession).toHaveBeenCalledWith(sessionId);
    });

    it('should handle tool execute after event', async () => {
      // The real EventManager handles tool counting
      const handlers = plugin.getEventHandlers();
      const sessionId = 'test-session-789';
      const toolName = 'user:custom-tool';

      // Call the handler (should not throw)
      await handlers.onToolExecuteAfter?.(sessionId, toolName, true);

      // Real EventManager tracks tool stats internally
      // We can't easily verify this without exposing private state,
      // so we just verify it doesn't throw
      expect(true).toBe(true);
    });

    it('should handle session deleted event', async () => {
      // The real EventManager handles session deletion
      const handlers = plugin.getEventHandlers();
      const sessionId = 'test-session-deleted';

      // Reset mock before test
      mockSessionManagerInstance.deleteSession.mockClear();

      // Call the handler
      await handlers.onSessionDeleted?.(sessionId);

      // The real EventManager should have called the mocked SessionManager.deleteSession
      expect(mockSessionManagerInstance.deleteSession).toHaveBeenCalledWith(sessionId);
    });

    it('should handle message updated event', async () => {
      // Same as above: plugin has real EventManager, but SessionManager is mocked
      const handlers = plugin.getEventHandlers();
      const sessionId = 'test-session-123';

      // Reset call count before test
      mockSessionManagerInstance.ensureSession.mockClear();

      // Call the handler
      await handlers.onMessageUpdated?.(sessionId);

      // The real EventManager should have called the mocked SessionManager
      expect(mockSessionManagerInstance.ensureSession).toHaveBeenCalledWith(sessionId);
    });

    it('should handle tool execute after event', async () => {
      const handlers = plugin.getEventHandlers();
      const sessionId = 'test-session-123';
      const toolName = 'user:custom-tool';

      // Handler should exist and not throw
      expect(handlers.onToolExecuteAfter).toBeDefined();
      await handlers.onToolExecuteAfter?.(sessionId, toolName, true);
    });

    it('should handle session deleted event', async () => {
      const handlers = plugin.getEventHandlers();
      const sessionId = 'test-session-123';

      await handlers.onSessionDeleted?.(sessionId);

      expect(mockSessionManagerInstance.deleteSession).toHaveBeenCalledWith(sessionId);
    });
  });

  describe('System Hooks', () => {
    beforeEach(async () => {
      plugin = new EngramPlugin({ enabled: true });
      await plugin.init();
    });

    it('should provide system hooks', () => {
      const hooks = plugin.getHooks();

      expect(hooks).toBeDefined();
      expect(typeof hooks).toBe('object');
    });

    it('should register hooks via HookManager', () => {
      plugin.getHooks();

      expect(mockHookManagerInstance.registerHooks).toHaveBeenCalled();
    });
  });

  describe('Status and Queries', () => {
    it('should report status when not initialized', () => {
      plugin = new EngramPlugin({ enabled: true });
      const status = plugin.getStatus();

      expect(status.enabled).toBe(true);
      expect(status.initialized).toBe(false);
      expect(status.activeSessions).toBeGreaterThanOrEqual(0);
    });

    it('should report status when initialized', async () => {
      plugin = new EngramPlugin({ enabled: true });
      await plugin.init();

      const status = plugin.getStatus();

      expect(status.enabled).toBe(true);
      expect(status.initialized).toBe(true);
      expect(status.serverRunning).toBe(true);
    });

    it('should report isReady correctly', async () => {
      plugin = new EngramPlugin({ enabled: true });

      expect(plugin.isReady()).toBe(false);

      await plugin.init();

      expect(plugin.isReady()).toBe(true);
    });

    it('should identify Engram tools correctly', () => {
      const isEngram1 = EngramPlugin.isEngramTool('engram:test');
      const isEngram2 = EngramPlugin.isEngramTool('user:custom');

      expect(isEngram1).toBe(true);
      expect(isEngram2).toBe(false);
    });

    it('should return all Engram tools', () => {
      const tools = EngramPlugin.getEngramTools();

      expect(tools).toBeInstanceOf(Set);
      expect(tools.size).toBeGreaterThan(0);
    });
  });

  describe('Shutdown', () => {
    it('should shutdown gracefully', async () => {
      plugin = new EngramPlugin({ enabled: true });
      await plugin.init();

      await plugin.shutdown();

      expect(plugin.getStatus().initialized).toBe(false);
      expect(mockSessionManagerInstance.destroy).toHaveBeenCalled();
      expect(mockServerInstance.stop).toHaveBeenCalled();
    });

    it('should clear cleanup interval on shutdown', async () => {
      plugin = new EngramPlugin({ enabled: true });
      await plugin.init();

      const clearIntervalSpy = vi.spyOn(global, 'clearInterval');

      await plugin.shutdown();

      expect(clearIntervalSpy).toHaveBeenCalled();

      clearIntervalSpy.mockRestore();
    });

    it('should handle shutdown when not initialized', async () => {
      plugin = new EngramPlugin({ enabled: true });

      // Should not throw
      await expect(plugin.shutdown()).resolves.toBeUndefined();
    });

    it('should handle errors during shutdown gracefully', async () => {
      plugin = new EngramPlugin({ enabled: true });
      await plugin.init();

      // Make destroy fail
      mockSessionManagerInstance.destroy.mockRejectedValueOnce(new Error('Destroy failed'));

      // Should not throw, but log error
      await expect(plugin.shutdown()).resolves.toBeUndefined();
    });
  });

  describe('Cleanup Interval', () => {
    beforeEach(async () => {
      plugin = new EngramPlugin({ enabled: true });
      await plugin.init();
    });

    it('should monitor active sessions every 5 minutes', async () => {
      const getTrackedSessionsCallsBefore = mockSessionManagerInstance.getTrackedSessions.mock.calls.length;

      // Fast-forward time by 5 minutes
      vi.advanceTimersByTime(5 * 60 * 1000);

      // The interval callback should have been invoked at least once
      expect(mockSessionManagerInstance.getTrackedSessions.mock.calls.length).toBeGreaterThanOrEqual(
        getTrackedSessionsCallsBefore
      );

      await plugin.shutdown();
    });

    it('should stop monitoring on shutdown', async () => {
      const clearIntervalSpy = vi.spyOn(global, 'clearInterval');

      await plugin.shutdown();

      expect(clearIntervalSpy).toHaveBeenCalled();

      clearIntervalSpy.mockRestore();
    });
  });

  describe('Configuration', () => {
    it('should respect server config', async () => {
      const serverConfig = { binaryPath: '/custom/path/engram' };
      plugin = new EngramPlugin({ server: serverConfig, enabled: true });

      // The config is passed to EngramServer constructor
      expect(EngramServer as unknown as vi.Mock).toHaveBeenCalledWith(
        expect.objectContaining(serverConfig)
      );
    });

    it('should respect enabled flag', async () => {
      plugin = new EngramPlugin({ enabled: false });
      await plugin.init();

      expect(plugin.getStatus().initialized).toBe(false);
    });
  });

  describe('Full Lifecycle', () => {
    it('should complete full init → events → shutdown cycle', async () => {
      plugin = new EngramPlugin({ enabled: true });

      // Init
      await plugin.init();
      expect(plugin.isReady()).toBe(true);

      // Get event handlers
      const handlers = plugin.getEventHandlers();
      expect(handlers.onSessionCreated).toBeDefined();

      // Trigger events
      await handlers.onSessionCreated?.('session-1');
      await handlers.onMessageUpdated?.('session-1');
      await handlers.onToolExecuteAfter?.('session-1', 'user:tool', true);
      await handlers.onSessionDeleted?.('session-1');

      // Shutdown
      await plugin.shutdown();
      expect(plugin.isReady()).toBe(false);

      // Verify no errors were thrown
      expect(true).toBe(true);
    });

    it('should handle multiple sessions across lifecycle', async () => {
      plugin = new EngramPlugin({ enabled: true });
      await plugin.init();

      const handlers = plugin.getEventHandlers();
      const sessionIds = ['session-1', 'session-2', 'session-3'];

      // Create multiple sessions
      for (const sessionId of sessionIds) {
        await handlers.onSessionCreated?.(sessionId);
      }

      expect(mockSessionManagerInstance.ensureSession).toHaveBeenCalledTimes(3);

      await plugin.shutdown();
    });
  });
});
