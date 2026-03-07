/**
 * @file tests/core/types.test.ts
 * @description Tests for type definitions and Zod schemas
 */
import { describe, it, expect } from 'vitest';
import { OpenCodeConfigSchema, AgentConfigSchema, parseOpenCodeConfig, } from '@core/types';
describe('OpenCode Types and Schemas', () => {
    describe('AgentConfigSchema', () => {
        it('should validate a valid agent config', () => {
            const agentConfig = {
                name: 'test-agent',
                prompts: {
                    system: 'You are a helpful assistant',
                },
            };
            const result = AgentConfigSchema.safeParse(agentConfig);
            expect(result.success).toBe(true);
        });
        it('should reject agent config with missing name', () => {
            const agentConfig = {
                prompts: {
                    system: 'You are a helpful assistant',
                },
            };
            const result = AgentConfigSchema.safeParse(agentConfig);
            expect(result.success).toBe(false);
        });
        it('should reject agent config with empty system prompt', () => {
            const agentConfig = {
                name: 'test-agent',
                prompts: {
                    system: '',
                },
            };
            const result = AgentConfigSchema.safeParse(agentConfig);
            expect(result.success).toBe(false);
        });
    });
    describe('OpenCodeConfigSchema', () => {
        it('should validate a minimal valid config', () => {
            const config = {
                version: '1.0.0',
                agents: {},
                mcpServers: {},
                skills: [],
            };
            const result = OpenCodeConfigSchema.safeParse(config);
            expect(result.success).toBe(true);
        });
        it('should validate a complete config', () => {
            const config = {
                version: '1.0.0',
                metadata: {
                    name: 'Test Config',
                    description: 'A test configuration',
                    author: 'Test Author',
                },
                agents: {
                    test: {
                        name: 'test-agent',
                        prompts: {
                            system: 'You are helpful',
                        },
                    },
                },
                mcpServers: {
                    test: {
                        name: 'test-server',
                        type: 'stdio',
                        enabled: true,
                    },
                },
                skills: [
                    {
                        name: 'test-skill',
                        enabled: true,
                    },
                ],
                environment: {
                    TEST_VAR: 'test-value',
                },
                logging: {
                    level: 'debug',
                    format: 'text',
                    prettify: true,
                },
            };
            const result = OpenCodeConfigSchema.safeParse(config);
            expect(result.success).toBe(true);
        });
    });
    describe('parseOpenCodeConfig', () => {
        it('should parse a valid config', () => {
            const data = {
                version: '1.0.0',
                agents: {},
                mcpServers: {},
            };
            const result = parseOpenCodeConfig(data);
            expect(result.success).toBe(true);
            if (result.success) {
                expect(result.data.version).toBe('1.0.0');
            }
        });
        it('should return errors for invalid config', () => {
            const data = {
                agents: {
                    invalid: {
                        prompts: {
                            system: '',
                        },
                    },
                },
            };
            const result = parseOpenCodeConfig(data);
            expect(result.success).toBe(false);
            if (!result.success) {
                expect(result.errors.length).toBeGreaterThan(0);
            }
        });
    });
});
//# sourceMappingURL=types.test.js.map