import { z } from 'zod';
import { validateInput } from '../utils/validation.js';
import { ValidateTaskComplexityResult } from '../types/index.js';
import { EngramClient } from '../utils/engram-client.js';

const TECHNICAL_KEYWORDS = [
  'implement', 'benchmark', 'analysis', 'security', 'cryptography', 'protocol',
  'hkdf', 'aes', 'ecdsa', 'mitre', 'att&ck', 'nist', 'iso', 'owasp',
  'exploit', 'vulnerability', 'incident', 'response', 'forensics', 'malware',
  'rpa', 'hybrid warfare', 'psyops', 'zero-trust', 'post-quantum', 'epss',
  'adversarial ai', 'threat hunting', 'soc', 'disinformation', 'cyber-surveillance'
];

interface ScoringResult {
  score: number;
  flags: Array<{ flag_name: string; reason: string; suggestion?: string }>;
}

export const validateTaskComplexityTool = {
  name: 'validate_task_complexity',
  description: 'Validate task complexity and anti-AI rigor',
  schema: z.object({
    title: z.string().describe('Task title'),
    description: z.string().describe('Task description'),
    acceptance_criteria: z.array(z.string()).describe('Acceptance criteria list'),
  }),
  handler: async (args: any): Promise<ValidateTaskComplexityResult> => {
    validateInput(args);

    const { title, description, acceptance_criteria } = args;
    const combinedText = `${title} ${description}`.toLowerCase();
    
    const heuristics_used: string[] = ['Length Analysis', 'Keyword Density', 'Constraint Count'];
    
    // Calculate heuristics
    const h1 = analyzeLength(description);
    const h2 = analyzeKeywords(combinedText);
    const h3 = analyzeConstraints(acceptance_criteria);

    const totalScore = h1.score + h2.score + h3.score;
    const flags = [...h1.flags, ...h2.flags, ...h3.flags];
    const taskId = `val_${Date.now()}`;

    // Save to Engram
    await EngramClient.saveObservation({
      title: `Validated Task: ${title}`,
      type: 'discovery',
      content: `**What**: Validated complexity for task "${title}".\n**Complexity**: ${totalScore}/10\n**Rigorous**: ${totalScore >= 7}`,
      topic_key: `ucm/validation/${taskId}`
    });

    // Final metrics
    const ai_solvable_chance = Math.max(0, 100 - (totalScore * 10));
    const is_rigorous = totalScore >= 7;

    return {
      task_id: taskId,
      is_rigorous,
      complexity_score: totalScore,
      ai_solvable_chance,
      flags,
      recommendations: flags.map(f => f.suggestion || '').filter(Boolean),
      heuristics_used,
      validated_at: new Date().toISOString()
    };
  }
};

/**
 * Heuristic 1: Length Analysis (Max 4 pts)
 */
function analyzeLength(description: string): ScoringResult {
  const length = description.length;
  if (length > 500) return { score: 4, flags: [] };
  if (length > 200) return { score: 2, flags: [] };
  if (length > 100) return { score: 1, flags: [] };
  
  return {
    score: 0,
    flags: [{
      flag_name: 'Short Description',
      reason: 'Description is too brief for a master-level task.',
      suggestion: 'Expand the description to include specific technical requirements (>200 chars).'
    }]
  };
}

/**
 * Heuristic 2: Keyword Density (Max 3 pts)
 */
function analyzeKeywords(text: string): ScoringResult {
  const foundKeywords = TECHNICAL_KEYWORDS.filter(kw => text.includes(kw));
  
  if (foundKeywords.length > 5) return { score: 3, flags: [] };
  if (foundKeywords.length > 2) return { score: 2, flags: [] };
  if (foundKeywords.length > 0) return { score: 1, flags: [] };

  return {
    score: 0,
    flags: [{
      flag_name: 'Low Technical Depth',
      reason: 'Lacks specific cybersecurity terminology.',
      suggestion: 'Include references to industry frameworks (NIST, MITRE) or specific protocols.'
    }]
  };
}

/**
 * Heuristic 3: Constraint Count (Max 3 pts)
 */
function analyzeConstraints(criteria: string[]): ScoringResult {
  const count = criteria.length;
  if (count >= 5) return { score: 3, flags: [] };
  if (count >= 3) return { score: 2, flags: [] };
  if (count >= 1) return { score: 1, flags: [] };

  return {
    score: 0,
    flags: [{
      flag_name: 'Few Constraints',
      reason: 'Not enough acceptance criteria to guide the student.',
      suggestion: 'Define at least 3-5 measurable criteria to ensure rigor.'
    }]
  };
}
