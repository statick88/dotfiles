/**
 * @file src/core/constants.ts
 * @description Constants used throughout OpenCode
 */
// Engram-related constants
export const ENGRAM_TOOLS = [
    'notebooklm_ask_question',
    'notebooklm_add_notebook',
    'notebooklm_list_notebooks',
    'notebooklm_get_notebook',
    'notebooklm_select_notebook',
    'notebooklm_update_notebook',
    'notebooklm_remove_notebook',
    'notebooklm_search_notebooks',
    'notebooklm_get_library_stats',
    'notebooklm_list_sessions',
    'notebooklm_close_session',
    'notebooklm_reset_session',
    'notebooklm_get_health',
    'notebooklm_setup_auth',
    're_auth',
    'notebooklm_cleanup_data',
];
// Default configuration values
export const DEFAULT_CONFIG = {
    version: '1.0.0',
    logging: {
        level: 'info',
        format: 'json',
        prettify: false,
    },
    mcpServers: {},
    agents: {},
    skills: [],
    environment: {},
    plugins: {},
    experimental: {},
};
// Retry configuration
export const RETRY_CONFIG = {
    maxAttempts: 3,
    initialDelayMs: 100,
    maxDelayMs: 10000,
};
// HTTP request configuration
export const HTTP_CONFIG = {
    port: 9090,
    timeout: 30000, // 30 seconds
    retryAttempts: 3,
    headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'OpenCode/1.0.0',
    },
};
// Session management
export const SESSION_CONFIG = {
    maxCachedSessions: 100,
    sessionTimeoutMs: 24 * 60 * 60 * 1000, // 24 hours
    sessionTTLMs: 60 * 60 * 1000, // 1 hour inactivity before cleanup
};
// Engram API base URL
export const ENGRAM_API_BASE_URL = 'https://api.engram.ai';
// File paths (relative to config directory)
export const CONFIG_PATHS = {
    main: 'opencode.json',
    backup: 'opencode.json.backup',
    schema: 'opencode.schema.json',
};
// Engram memory instructions (slim version — critical info only)
// Injected into agent system prompt to ensure persistent memory usage
export const ENGRAM_MEMORY_INSTRUCTIONS = `## Engram Persistent Memory — Protocol

You have access to Engram, a persistent memory system that survives across sessions and compactions.

### WHEN TO SAVE (mandatory — not optional)

Call \`mem_save\` IMMEDIATELY after any of these:
- Bug fix completed
- Architecture or design decision made
- Non-obvious discovery about the codebase
- Configuration change or environment setup
- Pattern established (naming, structure, convention)
- User preference or constraint learned

Format for \`mem_save\`:
- **title**: Verb + what — short, searchable (e.g. "Fixed N+1 query", "Chose Zustand over Redux")
- **type**: bugfix | decision | architecture | discovery | pattern | config | preference
- **scope**: \`project\` (default) | \`personal\`
- **topic_key** (optional): stable key like \`architecture/auth-model\` for evolving topics
- **content**: **What** (1 sentence), **Why** (motivation), **Where** (files), **Learned** (gotchas)

### WHEN TO SEARCH MEMORY

When asked to recall something, first call \`mem_context\` (recent history), then \`mem_search\` for keywords.

### SESSION CLOSE PROTOCOL (mandatory)

Before ending a session, call \`mem_session_summary\` with: Goal, Instructions, Discoveries, Accomplished, Next Steps, Relevant Files.

### AFTER COMPACTION

If you see "FIRST ACTION REQUIRED", immediately call \`mem_session_summary\` with the compacted content. Do NOT skip this.
`;
//# sourceMappingURL=constants.js.map