/**
 * @file src/plugins/index.ts
 * @description Main Engram plugin export
 *
 * Orchestrates:
 * - EngramServer — spawn binary, manage lifecycle
 * - SessionManager — track sessions, hybrid cleanup
 * - EventManager — handle MCP events
 * - HookManager — register system hooks
 */
import { getLogger } from '@utils/logger';
import { EngramServer } from './engram-server';
import { SessionManager } from './engram-session-manager';
import { EventManager } from './engram-events';
import { HookManager } from './engram-hooks';
import { ToolRegistry } from './engram-tool-registry';
const logger = getLogger();
/**
 * Main Engram Plugin Class
 * Coordinates all sub-modules and provides unified interface
 */
export class EngramPlugin {
    server;
    sessionManager;
    eventManager;
    hookManager;
    config;
    isInitialized = false;
    cleanupInterval = null;
    constructor(config = {}) {
        this.config = {
            server: config.server || {},
            enabled: config.enabled ?? true,
        };
        this.server = new EngramServer(this.config.server);
        this.sessionManager = new SessionManager({
            httpClient: this.server.getHttpClient(),
            projectName: process.env.ENGRAM_PROJECT || 'default',
            projectDirectory: process.env.ENGRAM_PROJECT_DIR || process.cwd(),
            ttlMs: process.env.ENGRAM_SESSION_TTL_MS ? parseInt(process.env.ENGRAM_SESSION_TTL_MS) : undefined,
        });
        this.eventManager = new EventManager(this.sessionManager);
        this.hookManager = new HookManager(this.eventManager);
    }
    /**
     * Initialize the plugin
     * - Start Engram server
     * - Load manifest
     * - Start cleanup interval
     */
    async init() {
        if (this.isInitialized) {
            logger.warn('Engram plugin already initialized');
            return;
        }
        if (!this.config.enabled) {
            logger.info('Engram plugin disabled, skipping initialization');
            return;
        }
        try {
            logger.info('Initializing Engram plugin');
            // Start server
            await this.server.start();
            // Load manifest
            const manifest = await this.server.loadManifest();
            logger.debug('Engram manifest loaded', { tools: Object.keys(manifest?.tools || {}).length });
            // Start cleanup interval (5 minutes)
            this.cleanupInterval = setInterval(() => {
                // cleanupInactiveSessions is private, so we use the public getTrackedSessions
                // to monitor active sessions (TTL cleanup happens internally)
                const tracked = this.sessionManager.getTrackedSessions();
                logger.debug('Session monitor check', { activeSessions: tracked.length });
            }, 5 * 60 * 1000);
            this.isInitialized = true;
            logger.info('Engram plugin initialized successfully');
        }
        catch (error) {
            logger.error('Failed to initialize Engram plugin', error instanceof Error ? error : new Error(String(error)), {
                errorMessage: error instanceof Error ? error.message : String(error),
            });
            throw error;
        }
    }
    /**
     * Shutdown the plugin
     * - Stop cleanup interval
     * - Destroy session manager
     * - Stop server
     */
    async shutdown() {
        if (!this.isInitialized) {
            return;
        }
        try {
            logger.info('Shutting down Engram plugin');
            // Stop cleanup interval
            if (this.cleanupInterval) {
                clearInterval(this.cleanupInterval);
                this.cleanupInterval = null;
            }
            // Destroy session manager
            await this.sessionManager.destroy();
            // Stop server
            await this.server.stop();
            this.isInitialized = false;
            logger.info('Engram plugin shutdown complete');
        }
        catch (error) {
            logger.error('Error during shutdown', error instanceof Error ? error : new Error(String(error)), {
                errorMessage: error instanceof Error ? error.message : String(error),
            });
        }
    }
    /**
     * Get event handlers for MCP integration
     */
    getEventHandlers() {
        return {
            onSessionCreated: (sessionId) => this.eventManager.handleSessionCreated(sessionId),
            onMessageUpdated: (sessionId) => this.eventManager.handleMessageUpdated(sessionId),
            onToolExecuteAfter: (sessionId, toolName, success) => this.eventManager.handleToolExecuteAfter(sessionId, toolName, success),
            onSessionDeleted: (sessionId) => this.eventManager.handleSessionDeleted(sessionId),
        };
    }
    /**
     * Get system hooks for MCP integration
     */
    getHooks() {
        return this.hookManager.registerHooks();
    }
    /**
     * Check if plugin is ready
     */
    isReady() {
        return this.isInitialized && this.server.isRunning();
    }
    /**
     * Get plugin status information
     */
    getStatus() {
        return {
            enabled: this.config.enabled,
            initialized: this.isInitialized,
            serverRunning: this.server.isRunning(),
            activeSessions: this.eventManager.getActiveSessions().length,
        };
    }
    /**
     * Utility: Check if a tool is an Engram tool
     */
    static isEngramTool(toolName) {
        return ToolRegistry.isEngramTool(toolName);
    }
    /**
     * Utility: Get all Engram tools
     */
    static getEngramTools() {
        return ToolRegistry.getEngramTools();
    }
}
// Export main plugin class
export default EngramPlugin;
// Export sub-modules for direct use if needed
export { EngramServer } from './engram-server';
export { SessionManager } from './engram-session-manager';
export { EventManager } from './engram-events';
export { HookManager } from './engram-hooks';
export { ToolRegistry } from './engram-tool-registry';
export { EngramHttpClient } from './engram-http-client';
//# sourceMappingURL=index.js.map