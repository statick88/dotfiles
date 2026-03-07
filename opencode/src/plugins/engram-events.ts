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
import { SessionManager } from './engram-session-manager';
import { ToolRegistry } from './engram-tool-registry';

const logger = getLogger();

export interface EngramEventHandlers {
  onSessionCreated?: (sessionId: string) => Promise<void>;
  onMessageUpdated?: (sessionId: string) => Promise<void>;
  onToolExecuteAfter?: (sessionId: string, toolName: string, success: boolean) => Promise<void>;
  onSessionDeleted?: (sessionId: string) => Promise<void>;
}

export class EventManager {
  private sessionManager: SessionManager;
  private toolCounts: Map<string, Map<string, number>>; // sessionId -> (toolName -> count)

  constructor(sessionManager: SessionManager) {
    this.sessionManager = sessionManager;
    this.toolCounts = new Map();
  }

  /**
   * Handle session.created event
   * Ensure session exists in Engram before DB writes
   */
  async handleSessionCreated(sessionId: string, _metadata?: Record<string, any>): Promise<void> {
    try {
      logger.debug('Event: session.created', { sessionId });
      await this.sessionManager.ensureSession(sessionId);
      logger.info('Session created/ensured', { sessionId });
    } catch (error) {
      logger.error('Failed to ensure session', error instanceof Error ? error : new Error(String(error)), { sessionId });
    }
  }

  /**
   * Handle message.updated event
   * Update session lastUsedAt timestamp
   */
  async handleMessageUpdated(sessionId: string): Promise<void> {
    try {
      logger.debug('Event: message.updated', { sessionId });
      // Update lastUsedAt by calling ensureSession (idempotent)
      await this.sessionManager.ensureSession(sessionId);
    } catch (error) {
       logger.warn('Failed to touch session', { sessionId, errorMessage: error instanceof Error ? error.message : String(error) }, error instanceof Error ? error : undefined);
    }
  }

  /**
   * Handle tool.execute.after event
   * Count tool usage (skip Engram tools)
   */
  async handleToolExecuteAfter(
    sessionId: string,
    toolName: string,
    success: boolean,
    duration?: number
  ): Promise<void> {
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

      const sessionTools = this.toolCounts.get(sessionId)!;
      sessionTools.set(toolName, (sessionTools.get(toolName) || 0) + 1);

      const count = sessionTools.get(toolName) || 0;
      logger.debug('Tool counted', { sessionId, toolName, count });
    } catch (error) {
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
  async handleSessionDeleted(sessionId: string): Promise<void> {
    try {
      logger.debug('Event: session.deleted', { sessionId });
      await this.sessionManager.deleteSession(sessionId);
      this.toolCounts.delete(sessionId);
      logger.info('Session deleted', { sessionId });
    } catch (error) {
       logger.warn('Failed to delete session', { sessionId, errorMessage: error instanceof Error ? error.message : String(error) }, error instanceof Error ? error : undefined);
    }
  }

  /**
   * Get tool usage statistics for a session
   */
  getToolStats(sessionId: string): Record<string, number> {
    const stats: Record<string, number> = {};
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
  resetToolStats(sessionId: string): void {
    this.toolCounts.delete(sessionId);
    logger.debug('Tool stats reset', { sessionId });
  }

  /**
   * Get all active sessions being tracked
   */
  getActiveSessions(): string[] {
    return Array.from(this.toolCounts.keys());
  }
}
