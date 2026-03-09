/**
 * Local implementation of escapeHtml to avoid dependency issues.
 */
function escapeHtml(unsafe: string): string {
  return unsafe
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;');
}

import { ValidationError, LIMITS } from '../types/index.js';

/**
 * Sanitize user input by stripping HTML tags and escaping special characters.
 */
export function sanitizeInput(input: string): string {
  if (!input) return '';
  
  // Strip HTML tags using regex
  const stripped = input.replace(/<[^>]*>?/gm, '');
  
  // Escape HTML characters
  const escaped = escapeHtml(stripped);
  
  // Trim whitespace
  return escaped.trim();
}

/**
 * Validate input parameters against predefined limits.
 * Throws ValidationError if any limit is exceeded.
 */
export function validateInput(params: Record<string, any>): void {
  if (params.module && params.module.length > LIMITS.module) {
    throw new ValidationError(`Module name exceeds limit of ${LIMITS.module} characters`, {
      field: 'module',
      reason: 'length_exceeded'
    });
  }

  if (params.topic && params.topic.length > LIMITS.topic) {
    throw new ValidationError(`Topic exceeds limit of ${LIMITS.topic} characters`, {
      field: 'topic',
      reason: 'length_exceeded'
    });
  }

  if (params.title && params.title.length > LIMITS.title) {
    throw new ValidationError(`Title exceeds limit of ${LIMITS.title} characters`, {
      field: 'title',
      reason: 'length_exceeded'
    });
  }

  if (params.description && params.description.length > LIMITS.description) {
    throw new ValidationError(`Description exceeds limit of ${LIMITS.description} characters`, {
      field: 'description',
      reason: 'length_exceeded'
    });
  }

  if (params.criterion && params.criterion.length > LIMITS.criterion) {
    throw new ValidationError(`Criterion exceeds limit of ${LIMITS.criterion} characters`, {
      field: 'criterion',
      reason: 'length_exceeded'
    });
  }

  if (params.seed !== undefined && params.seed > LIMITS.seed) {
    throw new ValidationError(`Seed exceeds limit of ${LIMITS.seed}`, {
      field: 'seed',
      reason: 'value_out_of_range'
    });
  }

  if (params.difficulty !== undefined && (params.difficulty < 1 || params.difficulty > 5)) {
    throw new ValidationError('Difficulty must be between 1 and 5', {
      field: 'difficulty',
      reason: 'value_out_of_range'
    });
  }
}
