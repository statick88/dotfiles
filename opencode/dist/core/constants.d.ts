/**
 * @file src/core/constants.ts
 * @description Constants used throughout OpenCode
 */
export declare const ENGRAM_TOOLS: readonly ["notebooklm_ask_question", "notebooklm_add_notebook", "notebooklm_list_notebooks", "notebooklm_get_notebook", "notebooklm_select_notebook", "notebooklm_update_notebook", "notebooklm_remove_notebook", "notebooklm_search_notebooks", "notebooklm_get_library_stats", "notebooklm_list_sessions", "notebooklm_close_session", "notebooklm_reset_session", "notebooklm_get_health", "notebooklm_setup_auth", "re_auth", "notebooklm_cleanup_data"];
export type EngramTool = (typeof ENGRAM_TOOLS)[number];
export declare const DEFAULT_CONFIG: {
    readonly version: "1.0.0";
    readonly logging: {
        readonly level: "info";
        readonly format: "json";
        readonly prettify: false;
    };
    readonly mcpServers: {};
    readonly agents: {};
    readonly skills: readonly [];
    readonly environment: {};
    readonly plugins: {};
    readonly experimental: {};
};
export declare const RETRY_CONFIG: {
    readonly maxAttempts: 3;
    readonly initialDelayMs: 100;
    readonly maxDelayMs: 10000;
};
export declare const HTTP_CONFIG: {
    readonly port: 9090;
    readonly timeout: 30000;
    readonly retryAttempts: 3;
    readonly headers: {
        readonly 'Content-Type': "application/json";
        readonly 'User-Agent': "OpenCode/1.0.0";
    };
};
export declare const SESSION_CONFIG: {
    readonly maxCachedSessions: 100;
    readonly sessionTimeoutMs: number;
    readonly sessionTTLMs: number;
};
export declare const ENGRAM_API_BASE_URL = "https://api.engram.ai";
export declare const CONFIG_PATHS: {
    readonly main: "opencode.json";
    readonly backup: "opencode.json.backup";
    readonly schema: "opencode.schema.json";
};
export declare const ENGRAM_MEMORY_INSTRUCTIONS: "## Engram Persistent Memory \u2014 Protocol\n\nYou have access to Engram, a persistent memory system that survives across sessions and compactions.\n\n### WHEN TO SAVE (mandatory \u2014 not optional)\n\nCall `mem_save` IMMEDIATELY after any of these:\n- Bug fix completed\n- Architecture or design decision made\n- Non-obvious discovery about the codebase\n- Configuration change or environment setup\n- Pattern established (naming, structure, convention)\n- User preference or constraint learned\n\nFormat for `mem_save`:\n- **title**: Verb + what \u2014 short, searchable (e.g. \"Fixed N+1 query\", \"Chose Zustand over Redux\")\n- **type**: bugfix | decision | architecture | discovery | pattern | config | preference\n- **scope**: `project` (default) | `personal`\n- **topic_key** (optional): stable key like `architecture/auth-model` for evolving topics\n- **content**: **What** (1 sentence), **Why** (motivation), **Where** (files), **Learned** (gotchas)\n\n### WHEN TO SEARCH MEMORY\n\nWhen asked to recall something, first call `mem_context` (recent history), then `mem_search` for keywords.\n\n### SESSION CLOSE PROTOCOL (mandatory)\n\nBefore ending a session, call `mem_session_summary` with: Goal, Instructions, Discoveries, Accomplished, Next Steps, Relevant Files.\n\n### AFTER COMPACTION\n\nIf you see \"FIRST ACTION REQUIRED\", immediately call `mem_session_summary` with the compacted content. Do NOT skip this.\n";
//# sourceMappingURL=constants.d.ts.map