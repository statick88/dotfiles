const ENGRAM_PORT = process.env.ENGRAM_PORT || "7437";
const ENGRAM_URL = `http://127.0.0.1:${ENGRAM_PORT}`;

export interface EngramObservation {
  title: string;
  type: 'discovery' | 'decision' | 'architecture' | 'pattern' | 'config' | 'preference';
  content: string;
  topic_key?: string;
  project?: string;
}

export class EngramClient {
  /**
   * Save an observation to Engram
   */
  static async saveObservation(observation: EngramObservation): Promise<boolean> {
    try {
      const res = await fetch(`${ENGRAM_URL}/observations`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          ...observation,
          project: observation.project || 'opencode'
        }),
      });
      return res.ok;
    } catch (error) {
      // Silently fail if engram is not running
      return false;
    }
  }
}
