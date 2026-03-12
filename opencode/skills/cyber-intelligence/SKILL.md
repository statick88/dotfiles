---
name: cyber-intelligence
description: >
  Advanced patterns for threat intelligence gathering using CVE databases, MITRE ATT&CK framework, and social OSINT.
  Trigger: When asked about vulnerabilities (CVE), threat actors, attack techniques (MITRE), or trending exploits.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## When to Use

- Analyzing specific vulnerabilities (CVE-YYYY-NNNNN).
- Mapping adversary behavior to the MITRE ATT&CK framework.
- Checking for exploit availability (Exploit-DB, Metasploit integration).
- OSINT research on trending threats via social media (X/Twitter, Mastodon).
- Correlating vulnerabilities with EPSS risk scores.

## Critical Patterns

### 1. Vulnerability Analysis (CVE)
- Use `cve-intelligence` MCP to retrieve:
  - **CVSS Score**: Severity assessment.
  - **EPSS Score**: Probability of exploitation in the wild (higher is more critical).
  - **Exploit Status**: Check if public exploits exist.
- **Priority**: Focus on "Vulnerabilities in the wild" (high EPSS + public exploit).

### 2. Adversary Mapping (MITRE ATT&CK)
- Use `mitre` MCP to:
  - Identify **Tactics** (TAxxxx) and **Techniques** (Txxxx).
  - List **Software** and **Groups** using specific techniques.
  - Find **Mitigations** and **Detections** for identified threats.

### 3. Social OSINT (X/Twitter)
- Since direct API access may be restricted, use search tools to find:
  - "CVE-YYYY-NNNNN poc" or "CVE-YYYY-NNNNN exploit" on X.
  - Security researcher threads explaining technical details.
  - Hashtags: #infosec, #cybersecurity, #zero-day, #CVE.

### 4. Correlation Workflow
1.  **Identify**: Start with a CVE or a broad technique.
2.  **Enrich**: Get CVE details (EPSS, exploits) and MITRE mapping.
3.  **Contextualize**: Look for real-world discussions/PoCs on social platforms.
4.  **Harden**: Apply mitigations found in MITRE ATT&CK.

## Code Examples

### MCP Integration Examples
```python
# Search for trending CVEs with high risk
cve-intelligence.search_cves(query="trending", min_epss=0.1)

# Get MITRE techniques for a group (e.g., APT29)
mitre.get_group_techniques(group_name="APT29")
```

## Commands

```bash
# Check status of intelligence servers
opencode mcp status cve-intelligence mitre
```

## Resources

- **NVD**: [National Vulnerability Database](https://nvd.nist.gov/)
- **MITRE ATT&CK**: [Official Matrix](https://attack.mitre.org/)
- **First.org (EPSS)**: [Exploit Prediction Scoring System](https://www.first.org/epss/)
- **Exploit-DB**: [Vulnerability & Exploit Database](https://www.exploit-db.com/)
