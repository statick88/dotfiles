/**
 * @file src/plugins/engram-data-transform.ts
 * @description Data transformation utilities for Engram plugin
 *
 * - Project name extraction
 * - String truncation
 * - Security: strip private tags
 */
/**
 * Extract project name from directory path
 * Example: /home/user/my-project → my-project
 */
export declare function extractProjectName(directory: string): string;
/**
 * Truncate string to max length, append "..." if truncated
 * Example: truncate("hello world", 5) → "he..."
 */
export declare function truncate(str: string, max: number): string;
/**
 * Strip <private>...</private> tags before sending to Engram
 * Double safety: Go binary also strips, but we strip here too
 * so sensitive data never hits the wire.
 *
 * Example:
 *   "My secret: <private>API_KEY=123</private>" → "My secret: [REDACTED]"
 */
export declare function stripPrivateTags(str: string): string;
/**
 * Validate session ID (non-empty string)
 */
export declare function isValidSessionId(sessionId: unknown): sessionId is string;
/**
 * Validate content length (minimum threshold for capture)
 * Used to filter trivial messages
 */
export declare function isSignificantContent(content: string, minLength?: number): boolean;
//# sourceMappingURL=engram-data-transform.d.ts.map