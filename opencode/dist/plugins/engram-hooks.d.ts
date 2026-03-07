/**
 * @file src/plugins/engram-hooks.ts
 * @description System hooks for Engram integration
 *
 * Hooks:
 * - system.transform — inject ENGRAM_MEMORY_INSTRUCTIONS into prompts
 * - session.compacting — finalize session stats before archival
 */
import { EventManager } from './engram-events';
export interface SystemContext {
    prompt: string;
    context?: Record<string, any>;
}
export interface CompactingContext {
    sessionId: string;
    stats?: Record<string, any>;
}
export declare class HookManager {
    private eventManager;
    constructor(eventManager: EventManager);
    /**
     * system.transform hook
     * Inject ENGRAM_MEMORY_INSTRUCTIONS into the system prompt
     */
    transformSystemPrompt(context: SystemContext): SystemContext;
    /**
     * session.compacting hook
     * Finalize session stats before archival
     * This is called when Engram is about to compact/archive a session
     */
    onSessionCompacting(context: CompactingContext): Promise<void>;
    /**
     * Register all hooks with Engram system
     * This would be called during plugin initialization
     */
    registerHooks(): Record<string, Function>;
}
//# sourceMappingURL=engram-hooks.d.ts.map