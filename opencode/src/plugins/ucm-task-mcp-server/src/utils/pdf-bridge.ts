import { spawn } from 'child_process';
import fs from 'fs/promises';
import path from 'path';
import os from 'path';
import { tmpdir } from 'os';

export interface PDFGenerationResult {
  success: boolean;
  pdfPath?: string;
  error?: string;
}

export class PDFBridge {
  private static PYTHON_SCRIPT = '/Users/statick/apps/tareas-ucm/scripts/generate_pdf.py';
  private static CONFIG_PATH = '/Users/statick/apps/tareas-ucm/config/config.yaml';
  private static WORKING_DIR = '/Users/statick/apps/tareas-ucm';

  /**
   * Generate a PDF using the Python backend
   */
  static async generate(params: {
    student: string;
    module: string;
    title: string;
    contentHtml: string;
    email?: string;
  }): Promise<PDFGenerationResult> {
    const tempHtmlPath = path.join(tmpdir(), `ucm-task-${Date.now()}.html`);
    
    try {
      // 1. Save content to temp HTML file
      await fs.writeFile(tempHtmlPath, params.contentHtml, 'utf-8');

      // 2. Prepare arguments
      const args = [
        this.PYTHON_SCRIPT,
        '--student', params.student,
        '--module', params.module,
        '--title', params.title,
        '--input', tempHtmlPath,
        '--config', this.CONFIG_PATH,
        '--output', path.join(this.WORKING_DIR, 'output')
      ];

      if (params.email) {
        args.push('--email', params.email);
      }

      // 3. Execute python script
      return new Promise((resolve) => {
        const process = spawn('python3', args, {
          cwd: this.WORKING_DIR,
          env: { ...process.env, PYTHONPATH: this.WORKING_DIR }
        });

        let stdout = '';
        let stderr = '';

        process.stdout.on('data', (data) => { stdout += data.toString(); });
        process.stderr.on('data', (data) => { stderr += data.toString(); });

        process.on('close', (code) => {
          // Cleanup temp file
          fs.unlink(tempHtmlPath).catch(() => {});

          if (code === 0) {
            // Extract PDF path from stdout (script prints "✅ PDF generated successfully: path")
            const match = stdout.match(/PDF generated successfully: (.*)/);
            resolve({
              success: true,
              pdfPath: match ? match[1].trim() : undefined
            });
          } else {
            resolve({
              success: false,
              error: stderr || stdout || `Process exited with code ${code}`
            });
          }
        });
      });
    } catch (error) {
      return {
        success: false,
        error: error instanceof Error ? error.message : String(error)
      };
    }
  }
}
