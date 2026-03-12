/**
 * @file src/core/config.ts
 * @description Configuration loader and manager
 */

import { readFileSync } from 'fs';
import { resolve } from 'path';
import { parseOpenCodeConfig, type OpenCodeConfig } from './types.js';
import { ConfigurationError, ValidationError } from '@utils/errors.js';
import { getLogger } from '@utils/logger.js';
import { DEFAULT_CONFIG } from './constants.js';

const logger = getLogger();

export interface ConfigOptions {
  configPath?: string;
  validateSchema?: boolean;
}

/**
 * Load and validate OpenCode configuration from file
 */
export function loadConfig(options: ConfigOptions = {}): OpenCodeConfig {
  const configPath = options.configPath || resolve(process.cwd(), 'opencode.json');

  logger.info('Loading configuration', { configPath });

  try {
    const rawConfig = readFileSync(configPath, 'utf-8');
    const parsedJson = JSON.parse(rawConfig);

    const result = parseOpenCodeConfig(parsedJson);

    if (!result.success) {
      const errorMessage = `Configuration validation failed: ${result.errors.join('; ')}`;
      throw new ValidationError(errorMessage, result.errors, {
        configPath,
        errors: result.errors,
      });
    }

    logger.info('Configuration loaded successfully', {
      configPath,
      agents: Object.keys(result.data.agents).length,
      mcpServers: Object.keys(result.data.mcpServers).length,
    });

    return result.data;
  } catch (error) {
    if (error instanceof ValidationError) {
      throw error;
    }

    if (error instanceof SyntaxError) {
      throw new ConfigurationError('Invalid JSON in configuration file', { configPath, originalError: error.message }, error);
    }

    throw new ConfigurationError('Failed to load configuration file', { configPath, originalError: String(error) });
  }
}

/**
 * Get default configuration
 */
export function getDefaultConfig(): OpenCodeConfig {
  return { ...DEFAULT_CONFIG } as unknown as OpenCodeConfig;
}

/**
 * Merge user config with defaults
 */
export function mergeWithDefaults(userConfig: Partial<OpenCodeConfig>): OpenCodeConfig {
  const defaults = getDefaultConfig();

  return {
    ...defaults,
    ...userConfig,
    agents: {
      ...defaults.agents,
      ...(userConfig.agents || {}),
    },
    mcpServers: {
      ...defaults.mcpServers,
      ...(userConfig.mcpServers || {}),
    },
    environment: {
      ...defaults.environment,
      ...(userConfig.environment || {}),
    },
    plugins: {
      ...defaults.plugins,
      ...(userConfig.plugins || {}),
    },
  };
}

/**
 * Get an agent configuration by name
 */
export function getAgentConfig(config: OpenCodeConfig, agentName: string) {
  const agent = config.agents[agentName];

  if (!agent) {
    throw new Error(`Agent '${agentName}' not found in configuration`);
  }

  return agent;
}

/**
 * Check if an MCP server is enabled
 */
export function isMCPServerEnabled(config: OpenCodeConfig, serverName: string): boolean {
  const server = config.mcpServers[serverName];
  return server?.enabled ?? true;
}
