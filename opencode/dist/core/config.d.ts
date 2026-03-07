/**
 * @file src/core/config.ts
 * @description Configuration loader and manager
 */
import { type OpenCodeConfig } from './types.js';
export interface ConfigOptions {
    configPath?: string;
    validateSchema?: boolean;
}
/**
 * Load and validate OpenCode configuration from file
 */
export declare function loadConfig(options?: ConfigOptions): OpenCodeConfig;
/**
 * Get default configuration
 */
export declare function getDefaultConfig(): OpenCodeConfig;
/**
 * Merge user config with defaults
 */
export declare function mergeWithDefaults(userConfig: Partial<OpenCodeConfig>): OpenCodeConfig;
/**
 * Get an agent configuration by name
 */
export declare function getAgentConfig(config: OpenCodeConfig, agentName: string): {
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
};
/**
 * Check if an MCP server is enabled
 */
export declare function isMCPServerEnabled(config: OpenCodeConfig, serverName: string): boolean;
//# sourceMappingURL=config.d.ts.map