/**
 * @file src/core/types.ts
 * @description Type definitions and Zod schemas for OpenCode configuration and runtime types
 */
import { z } from 'zod';
// ============================================================================
// Agent Schemas
// ============================================================================
const AgentPermissionSchema = z.object({
    resource: z.string(),
    action: z.enum(['read', 'write', 'execute', 'delete']),
});
const AgentPromptSchema = z.object({
    system: z.string().min(1, 'System prompt cannot be empty'),
    instructions: z.string().optional(),
});
const AgentConfigSchema = z.object({
    name: z.string().min(1, 'Agent name is required'),
    role: z.string().optional(),
    prompts: AgentPromptSchema,
    capabilities: z.array(z.string()).default([]),
    permissions: z.array(AgentPermissionSchema).default([]),
    env: z.record(z.string(), z.string()).optional(),
});
// ============================================================================
// MCP Server Schemas
// ============================================================================
const MCPServerCommandSchema = z.object({
    command: z.string().min(1, 'Command is required'),
    args: z.array(z.string()).default([]),
    env: z.record(z.string(), z.string()).optional(),
});
const MCPServerSchema = z.object({
    name: z.string().min(1, 'MCP server name is required'),
    type: z.enum(['stdio', 'sse', 'websocket']).default('stdio'),
    command: MCPServerCommandSchema.optional(),
    url: z.string().url('Invalid URL for MCP server').optional(),
    env: z.record(z.string(), z.string()).default({}),
    enabled: z.boolean().default(true),
});
// ============================================================================
// Skill Schemas
// ============================================================================
const SkillConfigSchema = z.object({
    name: z.string().min(1, 'Skill name is required'),
    description: z.string().optional(),
    enabled: z.boolean().default(true),
    version: z.string().optional(),
    tags: z.array(z.string()).default([]),
});
// ============================================================================
// Main OpenCode Configuration Schema
// ============================================================================
const OpenCodeConfigSchema = z.object({
    version: z.string().default('1.0.0'),
    metadata: z
        .object({
        name: z.string().optional(),
        description: z.string().optional(),
        author: z.string().optional(),
        created: z.string().datetime().optional(),
        updated: z.string().datetime().optional(),
    })
        .optional(),
    agents: z.record(z.string(), AgentConfigSchema).default({}),
    mcpServers: z.record(z.string(), MCPServerSchema).default({}),
    skills: z.array(SkillConfigSchema).default([]),
    environment: z.record(z.string(), z.string()).default({}),
    plugins: z.record(z.string(), z.any()).default({}),
    logging: z
        .object({
        level: z.enum(['debug', 'info', 'warn', 'error']).default('info'),
        format: z.enum(['json', 'text']).default('json'),
        prettify: z.boolean().default(false),
    })
        .optional(),
    experimental: z.record(z.string(), z.any()).default({}),
});
// ============================================================================
// Schema Exports (for validation and runtime checks)
// ============================================================================
export { AgentPermissionSchema, AgentPromptSchema, AgentConfigSchema, MCPServerCommandSchema, MCPServerSchema, SkillConfigSchema, OpenCodeConfigSchema, };
// ============================================================================
// Helper function for safe config parsing
// ============================================================================
export function parseOpenCodeConfig(data) {
    const result = OpenCodeConfigSchema.safeParse(data);
    if (result.success) {
        return { success: true, data: result.data };
    }
    const errors = result.error.errors.map((err) => {
        const path = err.path.join('.');
        return `${path || 'root'}: ${err.message}`;
    });
    return { success: false, errors };
}
//# sourceMappingURL=types.js.map