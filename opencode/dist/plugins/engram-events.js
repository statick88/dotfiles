/**
 * @file src/plugins/engram-events.ts
 * @description Event handlers for Engram session tracking
 *
 * Tracks:
 * - session.created — Register new sessions
 * - message.updated — Update lastUsedAt timestamp
 * - tool.execute.after — Count tool usage (exclude Engram tools)
 */
import { getLogger } from '@utils/logger';
import { ToolRegistry } from './engram-tool-registry';
const logger = getLogger();
export class EventManager {
    sessionManager;
    toolCounts; // sessionId -> (toolName -> count)
    constructor(sessionManager) {
        this.sessionManager = sessionManager;
        this.toolCounts = new Map();
    }
    /**
     * Handle session.created event
     * Ensure session exists in Engram before DB writes
     */
    async handleSessionCreated(sessionId, _metadata) {
        try {
            logger.debug('Event: session.created', { sessionId });
            await this.sessionManager.ensureSession(sessionId);
            logger.info('Session created/ensured', { sessionId });
        }
        catch (error) {
            logger.error('Failed to ensure session', error instanceof Error ? error : new Error(String(error)), { sessionId });
        }
    }
    /**
     * Handle message.updated event
     * Update session lastUsedAt timestamp
     */
    async handleMessageUpdated(sessionId) {
        try {
            logger.debug('Event: message.updated', { sessionId });
            // Update lastUsedAt by calling ensureSession (idempotent)
            await this.sessionManager.ensureSession(sessionId);
        }
        catch (error) {
            logger.warn('Failed to touch session', { sessionId, errorMessage: error instanceof Error ? error.message : String(error) }, error instanceof Error ? error : undefined);
        }
    }
    /**
     * Handle tool.execute.after event
     * Count tool usage (skip Engram tools)
     */
    async handleToolExecuteAfter(sessionId, toolName, success, duration) {
        try {
            logger.debug('Event: tool.execute.after', { sessionId, toolName, success, duration });
            // Skip counting Engram tools
            if (ToolRegistry.isEngramTool(toolName)) {
                logger.debug('Skipping Engram tool count', { toolName });
                return;
            }
            // Increment tool count
            if (!this.toolCounts.has(sessionId)) {
                this.toolCounts.set(sessionId, new Map());
            }
            const sessionTools = this.toolCounts.get(sessionId);
            sessionTools.set(toolName, (sessionTools.get(toolName) || 0) + 1);
            const count = sessionTools.get(toolName) || 0;
            logger.debug('Tool counted', { sessionId, toolName, count });
        }
        catch (error) {
            logger.warn('Failed to count tool', {
                sessionId,
                toolName,
                errorMessage: error instanceof Error ? error.message : String(error),
            }, error instanceof Error ? error : undefined);
        }
    }
    /**
     * Handle session.deleted event
     * Clean up tracking data for deleted session
     */
    async handleSessionDeleted(sessionId) {
        try {
            logger.debug('Event: session.deleted', { sessionId });
            await this.sessionManager.deleteSession(sessionId);
            this.toolCounts.delete(sessionId);
            logger.info('Session deleted', { sessionId });
        }
        catch (error) {
            logger.warn('Failed to delete session', { sessionId, errorMessage: error instanceof Error ? error.message : String(error) }, error instanceof Error ? error : undefined);
        }
    }
    /**
     * Get tool usage statistics for a session
     */
    getToolStats(sessionId) {
        const stats = {};
        const sessionTools = this.toolCounts.get(sessionId);
        if (sessionTools) {
            for (const [tool, count] of sessionTools) {
                stats[tool] = count;
            }
        }
        return stats;
    }
    /**
     * Reset tool counts (e.g., on session cleanup)
     */
    resetToolStats(sessionId) {
        this.toolCounts.delete(sessionId);
        logger.debug('Tool stats reset', { sessionId });
    }
    /**
     * Get all active sessions being tracked
     */
    getActiveSessions() {
        return Array.from(this.toolCounts.keys());
    }
}
//# sourceMappingURL=engram-events.js.map