/**
 * UCM Task MCP Server - Type Definitions
 */

// Module enum (UCM Master Ciberseguridad 2026)
export type UCMModule =
  | 'Elementos de Seguridad'
  | 'Criptografía Aplicada'
  | 'Red Team'
  | 'Blue Team'
  | 'Purple Team & Threat Hunting'
  | 'DFIR'
  | 'OSINT & Inteligencia'
  | 'GRC'
  | 'IA & RPA Ciberseguridad'
  | 'Arquitectura de Seguridad'
  | 'Guerra Híbrida & Psyops'
  | 'Cibervigilancia'
  | 'Forense Avanzado';

// TFM Research Lines (2026 focus)
export type ResearchLine =
  | 'Adversarial AI & Disinformation'
  | 'Zero-Trust Automation (RPA)'
  | 'Post-Quantum Cryptography Readiness'
  | 'Privacy-Preserving Threat Intel'
  | 'Autonomous Edge Device Security';

// Task type enum
export type TaskType = 'question' | 'lab' | 'coding' | 'examination' | 'tfm_proposal';

// Difficulty level (1-5)
export type Difficulty = 1 | 2 | 3 | 4 | 5;

// Anti-AI level (1-5)
export type AntiAILevel = 1 | 2 | 3 | 4 | 5;

// Task structure
export interface Task {
  id: string;
  title: string;
  module: UCMModule;
  difficulty: Difficulty;
  type: TaskType;
  description: string;
  anti_ai_level: AntiAILevel;
  research_line?: ResearchLine; // Optional for TFMs
}

// Task generation parameters
export interface GenerateTaskParams {
  type: TaskType;
  topic: string;
  anti_ai_level: AntiAILevel;
  language?: 'es';
  seed?: number;
}

// Task complexity validation parameters
export interface ValidateTaskComplexityParams {
  title: string;
  description: string;
  acceptance_criteria: string[];
  rubric?: {
    points_total: number;
    criteria: Array<{
      name: string;
      description: string;
      points: number;
    }>;
  };
}

// Task validation result
export interface ValidateTaskComplexityResult {
  task_id: string;
  is_rigorous: boolean;
  ai_solvable_chance: number; // 0-100
  complexity_score: number; // 1-10
  flags: Array<{
    flag_name: string;
    reason: string;
    suggestion?: string;
  }>;
  recommendations: string[];
  heuristics_used: string[];
  validated_at: string;
}

// Resources type (config, modules, rubrics, anti_patterns)
export type ResourceType = 'config' | 'modules' | 'rubrics' | 'anti_patterns';

// Resources response
export interface ResourcesResult {
  _version: string;
  [key: string]: any; // Allow dynamic properties based on resource_type
}

// MCP custom error codes (extend -32099 to -32000 range)
export enum ErrorCode {
  VALIDATION_ERROR = -32099,
  TEMPLATE_NOT_FOUND_ERROR = -32098,
  TEMPLATE_RENDER_ERROR = -32097,
  FILE_IO_ERROR = -32096,
}

// Custom error class
export class MCPError extends Error {
  public code: number;
  public data?: {
    reason: string;
    suggestion?: string;
    field?: string;
  };

  constructor(message: string, code: number, data?: { reason: string; suggestion?: string; field?: string }) {
    super(message);
    this.code = code;
    this.data = data;
    this.name = 'MCPError';
  }
}

// Validation error
export class ValidationError extends MCPError {
  constructor(message: string, data?: { reason: string; suggestion?: string; field?: string }) {
    super(message, ErrorCode.VALIDATION_ERROR, data);
    this.name = 'ValidationError';
  }
}

// File IO error
export class FileIOError extends MCPError {
  constructor(message: string, data?: { reason: string; suggestion?: string; field?: string }) {
    super(message, ErrorCode.FILE_IO_ERROR, data);
    this.name = 'FileIOError';
  }
}

// Template not found error
export class TemplateNotFoundError extends MCPError {
  constructor(message: string, data?: { reason: string; suggestion?: string; field?: string }) {
    super(message, ErrorCode.TEMPLATE_NOT_FOUND_ERROR, data);
    this.name = 'TemplateNotFoundError';
  }
}

// Template render error
export class TemplateRenderError extends MCPError {
  constructor(message: string, data?: { reason: string; suggestion?: string; field?: string }) {
    super(message, ErrorCode.TEMPLATE_RENDER_ERROR, data);
    this.name = 'TemplateRenderError';
  }
}

// Limits for validation
export const LIMITS = {
  module: 50,
  topic: 50,
  title: 200,
  description: 5000,
  criterion: 1000,
  seed: 2147483647, // 2^31 - 1
};
