/**
 * @file src/plugins/engram-tool-registry.ts
 * @description Tool registry for Engram — identifies which tools to track
 *
 * ENGRAM_TOOLS are Engram's own MCP tools.
 * We skip counting these in session stats.
 */

// Engram's own tools — don't count these in session statistics
const ENGRAM_TOOLS = new Set([
  'mem_search',
  'mem_save',
  'mem_update',
  'mem_delete',
  'mem_suggest_topic_key',
  'mem_save_prompt',
  'mem_session_summary',
  'mem_context',
  'mem_stats',
  'mem_timeline',
  'mem_get_observation',
  'mem_session_start',
  'mem_session_end',
])

export class ToolRegistry {
  /**
   * Check if tool is an Engram-internal tool
   */
  static isEngramTool(toolName: string): boolean {
    return ENGRAM_TOOLS.has(toolName.toLowerCase())
  }

  /**
   * Get all Engram tools
   */
  static getEngramTools(): Set<string> {
    return ENGRAM_TOOLS
  }

  /**
   * Check if tool should be counted in session statistics
   * (i.e., is it NOT an Engram internal tool)
   */
  static shouldCountTool(toolName: string): boolean {
    const shouldCount = !this.isEngramTool(toolName)
    return shouldCount
  }

  /**
   * Filter tools: keep only those that should be counted
   */
  static filterCountableTool(tools: string[]): string[] {
    return tools.filter((tool) => this.shouldCountTool(tool))
  }
}
