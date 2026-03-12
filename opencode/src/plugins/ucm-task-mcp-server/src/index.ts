/**
 * @file src/plugins/ucm-task-mcp-server/src/index.ts
 * @description Main entry point for the UCM Task MCP Server Plugin
 */

import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
import { stdioTransport } from '@modelcontextprotocol/sdk/transports/stdio.js';
import { listTasksTool } from './tools/list-tasks.js';
import { generateTaskTool } from './tools/generate-task.js';
import { validateTaskComplexityTool } from './tools/validate-task.js';
import { z } from 'zod';

export class UCMTaskPlugin {
  private server: McpServer;

  constructor() {
    this.server = new McpServer({
      name: 'ucm-task-mcp-server',
      version: '1.0.0',
    });

    this.registerTools();
    this.registerResources();
  }

  /**
   * Register all MCP tools
   */
  private registerTools(): void {
    this.server.addTool(listTasksTool);
    this.server.addTool(generateTaskTool);
    this.server.addTool(validateTaskComplexityTool);
  }

  /**
   * Register MCP resources
   */
  private registerResources(): void {
    // Resource: UCM Modules (2026 Curriculum)
    this.server.resource(
      "modules",
      "ucm://modules",
      async (uri) => ({
        contents: [{
          uri: uri.href,
          text: JSON.stringify([
            'Elementos de Seguridad',
            'Criptografía Aplicada',
            'Red Team',
            'Blue Team',
            'Purple Team & Threat Hunting',
            'DFIR',
            'OSINT & Inteligencia',
            'GRC',
            'IA & RPA Ciberseguridad',
            'Arquitectura de Seguridad',
            'Guerra Híbrida & Psyops',
            'Cibervigilancia',
            'Forense Avanzado'
          ], null, 2)
        }]
      })
    );

    // Resource: TFM Research Lines (2026 focus)
    this.server.resource(
      "tfm-lines",
      "ucm://tfm-lines",
      async (uri) => ({
        contents: [{
          uri: uri.href,
          text: JSON.stringify([
            { id: 'tfm-ai-disinfo', name: 'Adversarial AI & Disinformation', focus: 'Defense against AI-generated psyops' },
            { id: 'tfm-rpa-zt', name: 'Zero-Trust Automation (RPA)', focus: 'Automating IAM and access control' },
            { id: 'tfm-pqc', name: 'Post-Quantum Cryptography Readiness', focus: 'Migration paths for critical infra' },
            { id: 'tfm-priv-intel', name: 'Privacy-Preserving Threat Intel', focus: 'Sharing CORPINT securely via RGPD' },
            { id: 'tfm-edge-sec', name: 'Autonomous Edge Device Security', focus: 'OT Security for industrial AI devices' }
          ], null, 2)
        }]
      })
    );

    // Resource: Academic Rubrics
    this.server.resource(
      "rubrics",
      "ucm://rubrics",
      async (uri) => ({
        contents: [{
          uri: uri.href,
          text: JSON.stringify({
            standard: {
              presentation: 2,
              technical_depth: 4,
              academic_rigor: 2,
              grammar: 2
            }
          }, null, 2)
        }]
      })
    );
  }

  /**
   * Start the MCP server using stdio transport
   */
  async start(): Promise<void> {
    const transport = new stdioTransport();
    await this.server.connect(transport);
    console.error('UCM Task MCP Server started via stdio');
  }
}

// Support direct execution
if (process.argv[1] === import.meta.url.replace('file://', '')) {
  const plugin = new UCMTaskPlugin();
  plugin.start().catch((error) => {
    console.error('Failed to start UCM Task MCP Server:', error);
    process.exit(1);
  });
}
