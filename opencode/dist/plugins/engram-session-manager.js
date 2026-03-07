/**
 * @file src/plugins/engram-session-manager.ts
 * @description Session management with hybrid cleanup: event-based + TTL
 *
 * Tracks sessions in Engram and ensures they exist before DB writes.
 * Cleanup: event-based (on session.deleted) + TTL-based (1h inactivity).
 */
import { getLogger } from '@utils/logger';
import { SESSION_CONFIG } from '@core/constants';
const logger = getLogger();
export class SessionManager {
    httpClient;
    knownSessions = new Map();
    cleanupInterval = null;
    projectName;
    projectDirectory;
    ttlMs;
    constructor(config) {
        this.httpClient = config.httpClient;
        this.projectName = config.projectName;
        this.projectDirectory = config.projectDirectory;
        this.ttlMs = config.ttlMs ?? SESSION_CONFIG.sessionTTLMs;
        // Start TTL cleanup interval (every 5 minutes)
        this.startCleanupInterval();
    }
    /**
     * Ensure session exists in Engram (idempotent — uses INSERT OR IGNORE)
     */
    async ensureSession(sessionId) {
        if (!sessionId)
            return;
        const now = Date.now();
        const existing = this.knownSessions.get(sessionId);
        // Already tracked — just update lastUsedAt
        if (existing) {
            existing.lastUsedAt = now;
            return;
        }
        // Track new session locally
        this.knownSessions.set(sessionId, {
            createdAt: now,
            lastUsedAt: now,
        });
        // Create in Engram (POST /sessions with INSERT OR IGNORE)
        await this.httpClient.fetch('/sessions', {
            method: 'POST',
            body: {
                id: sessionId,
                project: this.projectName,
                directory: this.projectDirectory,
            },
        });
        logger.debug('Session ensured', {
            sessionId,
            project: this.projectName,
        });
    }
    /**
     * Mark session as deleted (event-based cleanup)
     * Called when session.deleted event arrives
     */
    deleteSession(sessionId) {
        if (this.knownSessions.has(sessionId)) {
            this.knownSessions.delete(sessionId);
            logger.debug('Session deleted', { sessionId });
        }
    }
    /**
     * Get all tracked sessions
     */
    getTrackedSessions() {
        return Array.from(this.knownSessions.keys());
    }
    /**
     * Get session metadata
     */
    getSessionMetadata(sessionId) {
        return this.knownSessions.get(sessionId);
    }
    /**
     * Start background cleanup interval (TTL-based)
     * Removes sessions inactive for more than TTL
     */
    startCleanupInterval() {
        this.cleanupInterval = setInterval(() => {
            this.cleanupInactiveSessions();
        }, 5 * 60 * 1000); // Every 5 minutes
        // Don't keep process alive for cleanup timer
        if (this.cleanupInterval.unref) {
            this.cleanupInterval.unref();
        }
    }
    /**
     * Remove inactive sessions (TTL cleanup)
     */
    cleanupInactiveSessions() {
        const now = Date.now();
        let removed = 0;
        for (const [sessionId, metadata] of this.knownSessions.entries()) {
            const inactiveMs = now - metadata.lastUsedAt;
            if (inactiveMs > this.ttlMs) {
                this.knownSessions.delete(sessionId);
                removed++;
            }
        }
        if (removed > 0) {
            logger.debug('Sessions cleaned up (TTL)', {
                removed,
                remaining: this.knownSessions.size,
            });
        }
    }
    /**
     * Destroy manager: stop cleanup interval and clear sessions
     */
    destroy() {
        if (this.cleanupInterval) {
            clearInterval(this.cleanupInterval);
            this.cleanupInterval = null;
        }
        this.knownSessions.clear();
        logger.debug('SessionManager destroyed');
    }
}
//# sourceMappingURL=engram-session-manager.js.map