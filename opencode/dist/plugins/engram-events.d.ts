/**
 * @file src/plugins/engram-events.ts
 * @description Event handlers for Engram session tracking
 *
 * Tracks:
 * - session.created — Register new sessions
 * - message.updated — Update lastUsedAt timestamp
 * - tool.execute.after — Count tool usage (exclude Engram tools)
 */
import { SessionManager } from './engram-session-manager';
export interface EngramEventHandlers {
    onSessionCreated?: (sessionId: string) => Promise<void>;
    onMessageUpdated?: (sessionId: string) => Promise<void>;
    onToolExecuteAfter?: (sessionId: string, toolName: string, success: boolean) => Promise<void>;
    onSessionDeleted?: (sessionId: string) => Promise<void>;
}
export declare class EventManager {
    private sessionManager;
    private toolCounts;
    constructor(sessionManager: SessionManager);
    /**
     * Handle session.created event
     * Ensure session exists in Engram before DB writes
     */
    handleSessionCreated(sessionId: string, _metadata?: Record<string, any>): Promise<void>;
    /**
     * Handle message.updated event
     * Update session lastUsedAt timestamp
     */
    handleMessageUpdated(sessionId: string): Promise<void>;
    /**
     * Handle tool.execute.after event
     * Count tool usage (skip Engram tools)
     */
    handleToolExecuteAfter(sessionId: string, toolName: string, success: boolean, duration?: number): Promise<void>;
    /**
     * Handle session.deleted event
     * Clean up tracking data for deleted session
     */
    handleSessionDeleted(sessionId: string): Promise<void>;
    /**
     * Get tool usage statistics for a session
     */
    getToolStats(sessionId: string): Record<string, number>;
    /**
     * Reset tool counts (e.g., on session cleanup)
     */
    resetToolStats(sessionId: string): void;
    /**
     * Get all active sessions being tracked
     */
    getActiveSessions(): string[];
}
//# sourceMappingURL=engram-events.d.ts.map