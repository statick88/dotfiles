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
import { EngramServerConfig } from './engram-server';
import { EngramEventHandlers } from './engram-events';
export interface EngramPluginConfig {
    server?: EngramServerConfig;
    enabled?: boolean;
}
/**
 * Main Engram Plugin Class
 * Coordinates all sub-modules and provides unified interface
 */
export declare class EngramPlugin {
    private server;
    private sessionManager;
    private eventManager;
    private hookManager;
    private config;
    private isInitialized;
    private cleanupInterval;
    constructor(config?: EngramPluginConfig);
    /**
     * Initialize the plugin
     * - Start Engram server
     * - Load manifest
     * - Start cleanup interval
     */
    init(): Promise<void>;
    /**
     * Shutdown the plugin
     * - Stop cleanup interval
     * - Destroy session manager
     * - Stop server
     */
    shutdown(): Promise<void>;
    /**
     * Get event handlers for MCP integration
     */
    getEventHandlers(): EngramEventHandlers;
    /**
     * Get system hooks for MCP integration
     */
    getHooks(): Record<string, Function>;
    /**
     * Check if plugin is ready
     */
    isReady(): boolean;
    /**
     * Get plugin status information
     */
    getStatus(): {
        enabled: boolean;
        initialized: boolean;
        serverRunning: boolean;
        activeSessions: number;
    };
    /**
     * Utility: Check if a tool is an Engram tool
     */
    static isEngramTool(toolName: string): boolean;
    /**
     * Utility: Get all Engram tools
     */
    static getEngramTools(): Set<string>;
}
export default EngramPlugin;
export { EngramServer } from './engram-server';
export { SessionManager } from './engram-session-manager';
export { EventManager } from './engram-events';
export { HookManager } from './engram-hooks';
export { ToolRegistry } from './engram-tool-registry';
export { EngramHttpClient } from './engram-http-client';
//# sourceMappingURL=index.d.ts.map