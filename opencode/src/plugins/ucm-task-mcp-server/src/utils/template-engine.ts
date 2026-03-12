/**
 * Minimal template engine to replace Handlebars when not available.
 * Supports {{variable}} and simple {{#if var}}...{{else}}...{{/if}}
 */
export function compileTemplate(template: string): (context: any) => string {
  return (context: any) => {
    let result = template;

    // 1. Handle simple variables
    for (const key in context) {
      const regex = new RegExp(`{{${key}}}`, 'g');
      result = result.replace(regex, context[key] || '');
    }

    // 2. Handle simple #if content
    // Regex matches {{#if content}}...{{else}}...{{/if}} or {{#if content}}...{{/if}}
    const ifRegex = /{{#if\s+(\w+)}}([\s\S]*?)(?:{{else}}([\s\S]*?))?{{\/if}}/g;
    
    result = result.replace(ifRegex, (_, varName, ifBlock, elseBlock) => {
      const condition = !!context[varName];
      if (condition) {
        return ifBlock.trim();
      } else {
        return (elseBlock || '').trim();
      }
    });

    return result;
  };
}
