/**
 * @file src/plugins/engram-tool-registry.ts
 * @description Tool registry for Engram — identifies which tools to track
 *
 * ENGRAM_TOOLS are Engram's own MCP tools.
 * We skip counting these in session stats.
 */
export declare class ToolRegistry {
    /**
     * Check if tool is an Engram-internal tool
     */
    static isEngramTool(toolName: string): boolean;
    /**
     * Get all Engram tools
     */
    static getEngramTools(): Set<string>;
    /**
     * Check if tool should be counted in session statistics
     * (i.e., is it NOT an Engram internal tool)
     */
    static shouldCountTool(toolName: string): boolean;
    /**
     * Filter tools: keep only those that should be counted
     */
    static filterCountableTool(tools: string[]): string[];
}
//# sourceMappingURL=engram-tool-registry.d.ts.map