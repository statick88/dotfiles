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
export function extractProjectName(directory) {
    if (!directory)
        return 'unknown';
    return directory.split('/').pop() ?? 'unknown';
}
/**
 * Truncate string to max length, append "..." if truncated
 * Example: truncate("hello world", 5) → "he..."
 */
export function truncate(str, max) {
    if (!str)
        return '';
    if (str.length > max) {
        return str.slice(0, max) + '...';
    }
    return str;
}
/**
 * Strip <private>...</private> tags before sending to Engram
 * Double safety: Go binary also strips, but we strip here too
 * so sensitive data never hits the wire.
 *
 * Example:
 *   "My secret: <private>API_KEY=123</private>" → "My secret: [REDACTED]"
 */
export function stripPrivateTags(str) {
    if (!str)
        return '';
    return str.replace(/<private>[\s\S]*?<\/private>/gi, '[REDACTED]').trim();
}
/**
 * Validate session ID (non-empty string)
 */
export function isValidSessionId(sessionId) {
    return typeof sessionId === 'string' && sessionId.length > 0;
}
/**
 * Validate content length (minimum threshold for capture)
 * Used to filter trivial messages
 */
export function isSignificantContent(content, minLength = 10) {
    return typeof content === 'string' && content.length >= minLength;
}
//# sourceMappingURL=engram-data-transform.js.map