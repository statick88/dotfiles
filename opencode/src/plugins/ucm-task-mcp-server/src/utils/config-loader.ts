import fs from 'fs/promises';
import path from 'path';
import { fileURLToPath } from 'url';
import { Task } from '../types/index.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export class ConfigLoader {
  private static tasks: Task[] | null = null;

  /**
   * Load tasks from tasks.json
   */
  static async getTasks(): Promise<Task[]> {
    if (this.tasks) return this.tasks;

    try {
      // Correct path based on implementation location
      const tasksPath = path.resolve(__dirname, '../data/tasks.json');
      const content = await fs.readFile(tasksPath, 'utf-8');
      this.tasks = JSON.parse(content);
      return this.tasks || [];
    } catch (error) {
      console.error('Failed to load tasks:', error);
      return [];
    }
  }

  /**
   * Filter tasks by module and difficulty
   */
  static async listTasks(module: string, difficulty?: number): Promise<Task[]> {
    const tasks = await this.getTasks();
    return tasks.filter(t => {
      const matchModule = t.module.toLowerCase() === module.toLowerCase();
      const matchDifficulty = difficulty ? t.difficulty === difficulty : true;
      return matchModule && matchDifficulty;
    });
  }
}
