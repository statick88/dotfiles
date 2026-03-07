/**
 * @file src/plugins/engram-hooks.ts
 * @description System hooks for Engram integration
 *
 * Hooks:
 * - system.transform — inject ENGRAM_MEMORY_INSTRUCTIONS into prompts
 * - session.compacting — finalize session stats before archival
 */
import { getLogger } from '@utils/logger';
import { ENGRAM_MEMORY_INSTRUCTIONS } from '@core/constants';
const logger = getLogger();
export class HookManager {
    eventManager;
    constructor(eventManager) {
        this.eventManager = eventManager;
    }
    /**
     * system.transform hook
     * Inject ENGRAM_MEMORY_INSTRUCTIONS into the system prompt
     */
    transformSystemPrompt(context) {
        try {
            logger.debug('Hook: system.transform', { promptLength: context.prompt.length });
            // Append ENGRAM instructions to prompt
            const enhancedPrompt = `${context.prompt}\n\n${ENGRAM_MEMORY_INSTRUCTIONS}`;
            logger.debug('System prompt enhanced', {
                originalLength: context.prompt.length,
                enhancedLength: enhancedPrompt.length,
            });
            return {
                ...context,
                prompt: enhancedPrompt,
            };
        }
        catch (error) {
            logger.error('Failed to transform system prompt', error instanceof Error ? error : new Error(String(error)));
            return context;
        }
    }
    /**
     * session.compacting hook
     * Finalize session stats before archival
     * This is called when Engram is about to compact/archive a session
     */
    async onSessionCompacting(context) {
        try {
            logger.info('Hook: session.compacting', { sessionId: context.sessionId });
            // Capture final tool stats
            const toolStats = this.eventManager.getToolStats(context.sessionId);
            logger.debug('Final tool stats captured', { sessionId: context.sessionId, tools: Object.keys(toolStats) });
            // Calculate summary metrics
            const totalToolCalls = Object.values(toolStats).reduce((sum, count) => sum + count, 0);
            logger.info('Session compacting summary', {
                sessionId: context.sessionId,
                totalToolCalls,
                uniqueTools: Object.keys(toolStats).length,
            });
            // Add metrics to context for Engram to save
            if (!context.stats) {
                context.stats = {};
            }
            context.stats.toolStats = toolStats;
            context.stats.totalToolCalls = totalToolCalls;
            context.stats.compactedAt = new Date().toISOString();
        }
        catch (error) {
            logger.error('Failed to handle session compacting', error instanceof Error ? error : new Error(String(error)), {
                sessionId: context.sessionId,
            });
        }
    }
    /**
     * Register all hooks with Engram system
     * This would be called during plugin initialization
     */
    registerHooks() {
        return {
            'system.transform': (ctx) => this.transformSystemPrompt(ctx),
            'session.compacting': (ctx) => this.onSessionCompacting(ctx),
        };
    }
}
//# sourceMappingURL=engram-hooks.js.map