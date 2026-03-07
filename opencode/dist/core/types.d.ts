/**
 * @file src/core/types.ts
 * @description Type definitions and Zod schemas for OpenCode configuration and runtime types
 */
import { z } from 'zod';
declare const AgentPermissionSchema: z.ZodObject<{
    resource: z.ZodString;
    action: z.ZodEnum<["read", "write", "execute", "delete"]>;
}, "strip", z.ZodTypeAny, {
    resource: string;
    action: "read" | "write" | "execute" | "delete";
}, {
    resource: string;
    action: "read" | "write" | "execute" | "delete";
}>;
declare const AgentPromptSchema: z.ZodObject<{
    system: z.ZodString;
    instructions: z.ZodOptional<z.ZodString>;
}, "strip", z.ZodTypeAny, {
    system: string;
    instructions?: string | undefined;
}, {
    system: string;
    instructions?: string | undefined;
}>;
declare const AgentConfigSchema: z.ZodObject<{
    name: z.ZodString;
    role: z.ZodOptional<z.ZodString>;
    prompts: z.ZodObject<{
        system: z.ZodString;
        instructions: z.ZodOptional<z.ZodString>;
    }, "strip", z.ZodTypeAny, {
        system: string;
        instructions?: string | undefined;
    }, {
        system: string;
        instructions?: string | undefined;
    }>;
    capabilities: z.ZodDefault<z.ZodArray<z.ZodString, "many">>;
    permissions: z.ZodDefault<z.ZodArray<z.ZodObject<{
        resource: z.ZodString;
        action: z.ZodEnum<["read", "write", "execute", "delete"]>;
    }, "strip", z.ZodTypeAny, {
        resource: string;
        action: "read" | "write" | "execute" | "delete";
    }, {
        resource: string;
        action: "read" | "write" | "execute" | "delete";
    }>, "many">>;
    env: z.ZodOptional<z.ZodRecord<z.ZodString, z.ZodString>>;
}, "strip", z.ZodTypeAny, {
    name: string;
    prompts: {
        system: string;
        instructions?: string | undefined;
    };
    capabilities: string[];
    permissions: {
        resource: string;
        action: "read" | "write" | "execute" | "delete";
    }[];
    role?: string | undefined;
    env?: Record<string, string> | undefined;
}, {
    name: string;
    prompts: {
        system: string;
        instructions?: string | undefined;
    };
    role?: string | undefined;
    capabilities?: string[] | undefined;
    permissions?: {
        resource: string;
        action: "read" | "write" | "execute" | "delete";
    }[] | undefined;
    env?: Record<string, string> | undefined;
}>;
declare const MCPServerCommandSchema: z.ZodObject<{
    command: z.ZodString;
    args: z.ZodDefault<z.ZodArray<z.ZodString, "many">>;
    env: z.ZodOptional<z.ZodRecord<z.ZodString, z.ZodString>>;
}, "strip", z.ZodTypeAny, {
    command: string;
    args: string[];
    env?: Record<string, string> | undefined;
}, {
    command: string;
    env?: Record<string, string> | undefined;
    args?: string[] | undefined;
}>;
declare const MCPServerSchema: z.ZodObject<{
    name: z.ZodString;
    type: z.ZodDefault<z.ZodEnum<["stdio", "sse", "websocket"]>>;
    command: z.ZodOptional<z.ZodObject<{
        command: z.ZodString;
        args: z.ZodDefault<z.ZodArray<z.ZodString, "many">>;
        env: z.ZodOptional<z.ZodRecord<z.ZodString, z.ZodString>>;
    }, "strip", z.ZodTypeAny, {
        command: string;
        args: string[];
        env?: Record<string, string> | undefined;
    }, {
        command: string;
        env?: Record<string, string> | undefined;
        args?: string[] | undefined;
    }>>;
    url: z.ZodOptional<z.ZodString>;
    env: z.ZodDefault<z.ZodRecord<z.ZodString, z.ZodString>>;
    enabled: z.ZodDefault<z.ZodBoolean>;
}, "strip", z.ZodTypeAny, {
    type: "stdio" | "sse" | "websocket";
    name: string;
    env: Record<string, string>;
    enabled: boolean;
    url?: string | undefined;
    command?: {
        command: string;
        args: string[];
        env?: Record<string, string> | undefined;
    } | undefined;
}, {
    name: string;
    type?: "stdio" | "sse" | "websocket" | undefined;
    url?: string | undefined;
    env?: Record<string, string> | undefined;
    command?: {
        command: string;
        env?: Record<string, string> | undefined;
        args?: string[] | undefined;
    } | undefined;
    enabled?: boolean | undefined;
}>;
declare const SkillConfigSchema: z.ZodObject<{
    name: z.ZodString;
    description: z.ZodOptional<z.ZodString>;
    enabled: z.ZodDefault<z.ZodBoolean>;
    version: z.ZodOptional<z.ZodString>;
    tags: z.ZodDefault<z.ZodArray<z.ZodString, "many">>;
}, "strip", z.ZodTypeAny, {
    name: string;
    enabled: boolean;
    tags: string[];
    description?: string | undefined;
    version?: string | undefined;
}, {
    name: string;
    enabled?: boolean | undefined;
    description?: string | undefined;
    version?: string | undefined;
    tags?: string[] | undefined;
}>;
declare const OpenCodeConfigSchema: z.ZodObject<{
    version: z.ZodDefault<z.ZodString>;
    metadata: z.ZodOptional<z.ZodObject<{
        name: z.ZodOptional<z.ZodString>;
        description: z.ZodOptional<z.ZodString>;
        author: z.ZodOptional<z.ZodString>;
        created: z.ZodOptional<z.ZodString>;
        updated: z.ZodOptional<z.ZodString>;
    }, "strip", z.ZodTypeAny, {
        name?: string | undefined;
        description?: string | undefined;
        author?: string | undefined;
        created?: string | undefined;
        updated?: string | undefined;
    }, {
        name?: string | undefined;
        description?: string | undefined;
        author?: string | undefined;
        created?: string | undefined;
        updated?: string | undefined;
    }>>;
    agents: z.ZodDefault<z.ZodRecord<z.ZodString, z.ZodObject<{
        name: z.ZodString;
        role: z.ZodOptional<z.ZodString>;
        prompts: z.ZodObject<{
            system: z.ZodString;
            instructions: z.ZodOptional<z.ZodString>;
        }, "strip", z.ZodTypeAny, {
            system: string;
            instructions?: string | undefined;
        }, {
            system: string;
            instructions?: string | undefined;
        }>;
        capabilities: z.ZodDefault<z.ZodArray<z.ZodString, "many">>;
        permissions: z.ZodDefault<z.ZodArray<z.ZodObject<{
            resource: z.ZodString;
            action: z.ZodEnum<["read", "write", "execute", "delete"]>;
        }, "strip", z.ZodTypeAny, {
            resource: string;
            action: "read" | "write" | "execute" | "delete";
        }, {
            resource: string;
            action: "read" | "write" | "execute" | "delete";
        }>, "many">>;
        env: z.ZodOptional<z.ZodRecord<z.ZodString, z.ZodString>>;
    }, "strip", z.ZodTypeAny, {
        name: string;
        prompts: {
            system: string;
            instructions?: string | undefined;
        };
        capabilities: string[];
        permissions: {
            resource: string;
            action: "read" | "write" | "execute" | "delete";
        }[];
        role?: string | undefined;
        env?: Record<string, string> | undefined;
    }, {
        name: string;
        prompts: {
            system: string;
            instructions?: string | undefined;
        };
        role?: string | undefined;
        capabilities?: string[] | undefined;
        permissions?: {
            resource: string;
            action: "read" | "write" | "execute" | "delete";
        }[] | undefined;
        env?: Record<string, string> | undefined;
    }>>>;
    mcpServers: z.ZodDefault<z.ZodRecord<z.ZodString, z.ZodObject<{
        name: z.ZodString;
        type: z.ZodDefault<z.ZodEnum<["stdio", "sse", "websocket"]>>;
        command: z.ZodOptional<z.ZodObject<{
            command: z.ZodString;
            args: z.ZodDefault<z.ZodArray<z.ZodString, "many">>;
            env: z.ZodOptional<z.ZodRecord<z.ZodString, z.ZodString>>;
        }, "strip", z.ZodTypeAny, {
            command: string;
            args: string[];
            env?: Record<string, string> | undefined;
        }, {
            command: string;
            env?: Record<string, string> | undefined;
            args?: string[] | undefined;
        }>>;
        url: z.ZodOptional<z.ZodString>;
        env: z.ZodDefault<z.ZodRecord<z.ZodString, z.ZodString>>;
        enabled: z.ZodDefault<z.ZodBoolean>;
    }, "strip", z.ZodTypeAny, {
        type: "stdio" | "sse" | "websocket";
        name: string;
        env: Record<string, string>;
        enabled: boolean;
        url?: string | undefined;
        command?: {
            command: string;
            args: string[];
            env?: Record<string, string> | undefined;
        } | undefined;
    }, {
        name: string;
        type?: "stdio" | "sse" | "websocket" | undefined;
        url?: string | undefined;
        env?: Record<string, string> | undefined;
        command?: {
            command: string;
            env?: Record<string, string> | undefined;
            args?: string[] | undefined;
        } | undefined;
        enabled?: boolean | undefined;
    }>>>;
    skills: z.ZodDefault<z.ZodArray<z.ZodObject<{
        name: z.ZodString;
        description: z.ZodOptional<z.ZodString>;
        enabled: z.ZodDefault<z.ZodBoolean>;
        version: z.ZodOptional<z.ZodString>;
        tags: z.ZodDefault<z.ZodArray<z.ZodString, "many">>;
    }, "strip", z.ZodTypeAny, {
        name: string;
        enabled: boolean;
        tags: string[];
        description?: string | undefined;
        version?: string | undefined;
    }, {
        name: string;
        enabled?: boolean | undefined;
        description?: string | undefined;
        version?: string | undefined;
        tags?: string[] | undefined;
    }>, "many">>;
    environment: z.ZodDefault<z.ZodRecord<z.ZodString, z.ZodString>>;
    plugins: z.ZodDefault<z.ZodRecord<z.ZodString, z.ZodAny>>;
    logging: z.ZodOptional<z.ZodObject<{
        level: z.ZodDefault<z.ZodEnum<["debug", "info", "warn", "error"]>>;
        format: z.ZodDefault<z.ZodEnum<["json", "text"]>>;
        prettify: z.ZodDefault<z.ZodBoolean>;
    }, "strip", z.ZodTypeAny, {
        level: "debug" | "info" | "warn" | "error";
        format: "json" | "text";
        prettify: boolean;
    }, {
        level?: "debug" | "info" | "warn" | "error" | undefined;
        format?: "json" | "text" | undefined;
        prettify?: boolean | undefined;
    }>>;
    experimental: z.ZodDefault<z.ZodRecord<z.ZodString, z.ZodAny>>;
}, "strip", z.ZodTypeAny, {
    version: string;
    agents: Record<string, {
        name: string;
        prompts: {
            system: string;
            instructions?: string | undefined;
        };
        capabilities: string[];
        permissions: {
            resource: string;
            action: "read" | "write" | "execute" | "delete";
        }[];
        role?: string | undefined;
        env?: Record<string, string> | undefined;
    }>;
    mcpServers: Record<string, {
        type: "stdio" | "sse" | "websocket";
        name: string;
        env: Record<string, string>;
        enabled: boolean;
        url?: string | undefined;
        command?: {
            command: string;
            args: string[];
            env?: Record<string, string> | undefined;
        } | undefined;
    }>;
    skills: {
        name: string;
        enabled: boolean;
        tags: string[];
        description?: string | undefined;
        version?: string | undefined;
    }[];
    environment: Record<string, string>;
    plugins: Record<string, any>;
    experimental: Record<string, any>;
    metadata?: {
        name?: string | undefined;
        description?: string | undefined;
        author?: string | undefined;
        created?: string | undefined;
        updated?: string | undefined;
    } | undefined;
    logging?: {
        level: "debug" | "info" | "warn" | "error";
        format: "json" | "text";
        prettify: boolean;
    } | undefined;
}, {
    version?: string | undefined;
    metadata?: {
        name?: string | undefined;
        description?: string | undefined;
        author?: string | undefined;
        created?: string | undefined;
        updated?: string | undefined;
    } | undefined;
    agents?: Record<string, {
        name: string;
        prompts: {
            system: string;
            instructions?: string | undefined;
        };
        role?: string | undefined;
        capabilities?: string[] | undefined;
        permissions?: {
            resource: string;
            action: "read" | "write" | "execute" | "delete";
        }[] | undefined;
        env?: Record<string, string> | undefined;
    }> | undefined;
    mcpServers?: Record<string, {
        name: string;
        type?: "stdio" | "sse" | "websocket" | undefined;
        url?: string | undefined;
        env?: Record<string, string> | undefined;
        command?: {
            command: string;
            env?: Record<string, string> | undefined;
            args?: string[] | undefined;
        } | undefined;
        enabled?: boolean | undefined;
    }> | undefined;
    skills?: {
        name: string;
        enabled?: boolean | undefined;
        description?: string | undefined;
        version?: string | undefined;
        tags?: string[] | undefined;
    }[] | undefined;
    environment?: Record<string, string> | undefined;
    plugins?: Record<string, any> | undefined;
    logging?: {
        level?: "debug" | "info" | "warn" | "error" | undefined;
        format?: "json" | "text" | undefined;
        prettify?: boolean | undefined;
    } | undefined;
    experimental?: Record<string, any> | undefined;
}>;
export type AgentPermission = z.infer<typeof AgentPermissionSchema>;
export type AgentPrompt = z.infer<typeof AgentPromptSchema>;
export type AgentConfig = z.infer<typeof AgentConfigSchema>;
export type MCPServerCommand = z.infer<typeof MCPServerCommandSchema>;
export type MCPServer = z.infer<typeof MCPServerSchema>;
export type SkillConfig = z.infer<typeof SkillConfigSchema>;
export type OpenCodeConfig = z.infer<typeof OpenCodeConfigSchema>;
export { AgentPermissionSchema, AgentPromptSchema, AgentConfigSchema, MCPServerCommandSchema, MCPServerSchema, SkillConfigSchema, OpenCodeConfigSchema, };
export declare function parseOpenCodeConfig(data: unknown): {
    success: true;
    data: OpenCodeConfig;
} | {
    success: false;
    errors: string[];
};
//# sourceMappingURL=types.d.ts.map