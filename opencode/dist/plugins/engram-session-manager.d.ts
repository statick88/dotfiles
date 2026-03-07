/**
 * @file src/plugins/engram-session-manager.ts
 * @description Session management with hybrid cleanup: event-based + TTL
 *
 * Tracks sessions in Engram and ensures they exist before DB writes.
 * Cleanup: event-based (on session.deleted) + TTL-based (1h inactivity).
 */
import { EngramHttpClient } from './engram-http-client';
interface SessionMetadata {
    createdAt: number;
    lastUsedAt: number;
}
export declare class SessionManager {
    private httpClient;
    private knownSessions;
    private cleanupInterval;
    private projectName;
    private projectDirectory;
    private ttlMs;
    constructor(config: {
        httpClient: EngramHttpClient;
        projectName: string;
        projectDirectory: string;
        ttlMs?: number;
    });
    /**
     * Ensure session exists in Engram (idempotent — uses INSERT OR IGNORE)
     */
    ensureSession(sessionId: string): Promise<void>;
    /**
     * Mark session as deleted (event-based cleanup)
     * Called when session.deleted event arrives
     */
    deleteSession(sessionId: string): void;
    /**
     * Get all tracked sessions
     */
    getTrackedSessions(): string[];
    /**
     * Get session metadata
     */
    getSessionMetadata(sessionId: string): SessionMetadata | undefined;
    /**
     * Start background cleanup interval (TTL-based)
     * Removes sessions inactive for more than TTL
     */
    private startCleanupInterval;
    /**
     * Remove inactive sessions (TTL cleanup)
     */
    private cleanupInactiveSessions;
    /**
     * Destroy manager: stop cleanup interval and clear sessions
     */
    destroy(): void;
}
export {};
//# sourceMappingURL=engram-session-manager.d.ts.map