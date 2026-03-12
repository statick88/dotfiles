import { z } from 'zod';
import fs from 'fs/promises';
import path from 'path';
import { fileURLToPath } from 'url';
import { compileTemplate } from '../utils/template-engine.js';
import { validateInput } from '../utils/validation.js';
import { PDFBridge } from '../utils/pdf-bridge.js';
import { EngramClient } from '../utils/engram-client.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export const generateTaskTool = {
  name: 'generate_task',
  description: 'Generate a new UCM task or TFM proposal in Markdown or PDF',
  schema: z.object({
    type: z.enum(['question', 'lab', 'coding', 'examination', 'tfm_proposal']).describe('Type of task'),
    topic: z.string().describe('Topic of the task or research line'),
    format: z.enum(['markdown', 'pdf']).default('markdown').describe('Output format'),
    module: z.enum([
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
    ]).optional().default('Criptografía Aplicada').describe('Module name'),
  }),
  handler: async (args: any) => {
    // 1. Validate Input & Apply Defaults
    const parsed = generateTaskTool.schema.parse(args);
    validateInput(parsed);

    const { type, topic, format, module } = parsed;
    const studentName = "Diego Medardo Saavedra García"; // From config.yaml variables
    const studentEmail = "dsaavedra88@gmail.com";

    // 2. Select Template
    let templateName = 'ensayo.hbs';
    if (type === 'lab' || type === 'coding') templateName = 'practica.hbs';
    if (type === 'examination') templateName = 'examen.hbs';
    if (type === 'question') templateName = 'ensayo.hbs';
    if (type === 'tfm_proposal') templateName = 'tfm_proposal.hbs';

    const templatePath = path.resolve(__dirname, '../../templates', templateName);
    const templateExists = await fs.access(templatePath).then(() => true).catch(() => false);
    
    // Fallback to ensayo if template doesn't exist yet
    const finalTemplatePath = templateExists ? templatePath : path.resolve(__dirname, '../../templates', 'ensayo.hbs');
    const templateContent = await fs.readFile(finalTemplatePath, 'utf-8');
    const template = compileTemplate(templateContent);

    // 3. Prepare Data
    const taskId = `task_${Date.now()}`;
    const context = {
      student_name: studentName,
      student_email: studentEmail,
      module_name: module,
      module: module, // For template support of both names
      type: type,
      topic: topic,
      task_title: topic,
      date: new Date().toLocaleDateString('es-ES'),
      submission_date: new Date().toLocaleDateString('es-ES'),
      content: `Desarrollo de la tarea sobre: ${topic}.`,
      academic_period: "2026-2027",
      taskId: taskId,
      difficulty: "3"
    };

    const renderedMarkdown = template(context);

    // 4. Handle Format
    if (format === 'markdown') {
      // Save to Engram
      await EngramClient.saveObservation({
        title: `Generated Task: ${topic}`,
        type: 'discovery',
        content: `**What**: Generated a ${type} task about ${topic} in Markdown format.\n**Where**: UCM Task Plugin\n**Learned**: Module: ${module}`,
        topic_key: `ucm/task/${taskId}`
      });

      return {
        taskId,
        format: 'markdown',
        content: renderedMarkdown
      };
    } else {
      // PDF Generation
      const simpleHtml = `<html><body><pre>${renderedMarkdown}</pre></body></html>`;
      
      const pdfResult = await PDFBridge.generate({
        student: studentName,
        module: module,
        title: topic,
        contentHtml: simpleHtml,
        email: studentEmail
      });

      if (pdfResult.success) {
        // Save to Engram
        await EngramClient.saveObservation({
          title: `Generated Task: ${topic} (PDF)`,
          type: 'discovery',
          content: `**What**: Generated a ${type} task about ${topic} in PDF format.\n**Where**: ${pdfResult.pdfPath}\n**Learned**: Module: ${module}`,
          topic_key: `ucm/task/${taskId}`
        });

        return {
          taskId,
          format: 'pdf',
          pdfPath: pdfResult.pdfPath,
          message: 'PDF generated successfully'
        };
      } else {
        return {
          error: {
            code: 'PDF_GENERATION_FAILED',
            message: pdfResult.error || 'Failed to generate PDF'
          }
        };
      }
    }
  }
};
