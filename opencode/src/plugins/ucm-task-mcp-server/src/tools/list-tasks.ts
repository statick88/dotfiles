import { z } from 'zod';
import { validateInput } from '../utils/validation.js';
import { ConfigLoader } from '../utils/config-loader.js';

export const listTasksTool = {
  name: 'list_tasks',
  description: 'List available UCM tasks by module and difficulty',
  schema: {
    module: z.string().describe('UCM Module name'),
    difficulty: z.number().min(1).max(5).optional().describe('Difficulty level (1-5)'),
  },
  handler: async (args: any) => {
    // 1. Validate inputs (strict limits)
    validateInput(args);

    // 2. Discover tasks from config.yaml/tasks.json
    const { module, difficulty } = args;
    const tasks = await ConfigLoader.listTasks(module, difficulty);

    // 3. Return results
    return {
      tasks
    };
  }
};
