---
name: scientific-research
description: >
  Patterns for finding and analyzing high-quality scientific papers (Q1/Q2, CORE A/A*) and research events.
  Trigger: When asked to find papers, search in databases, or check journal/conference rankings.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## When to Use

- Searching for state-of-the-art research in specific fields.
- Identifying high-impact journals (Q1/Q2 via SJR) or top conferences (CORE A/A*).
- Using MCP tools (like Sci-Hub) to locate and acquire academic literature.
- Analyzing proceedings from specific research events (e.g., REDCapCon/RedCon, IEEE, ACM).

## Critical Patterns

### 1. Ranking Verification
- **Journals**: Prioritize **Q1 (Top 25%)** and **Q2 (25-50%)** according to the **SCImago Journal Rank (SJR)**.
- **Conferences**: In Computer Science/Engineering, prioritize **CORE A*** and **CORE A** rankings.
- **Verification**: Always cross-reference the journal/conference name with official ranking databases before claiming impact.

### 2. Search Strategy
- **Keywords**: Use Boolean operators (`AND`, `OR`, `NOT`) and specific technical terminology.
- **Filters**: Limit results to the last 3-5 years for "state-of-the-art" unless searching for foundational papers.
- **Tools**: Use `search_scihub_by_keyword` or `search_scihub_by_doi` via MCP.

### 3. Event Handling (e.g., RedCon/REDCapCon)
- For specific events like **RedCon** (REDCap Conference), focus on:
  - Technical posters and presentations.
  - Consortium updates and security/compliance standards (HIPAA/GDPR).
  - Integration patterns for clinical research.

### 4. Paper Acquisition
- Use **DOI (Digital Object Identifier)** as the primary unique identifier.
- If a paper is behind a paywall, utilize the `scihub` MCP server to attempt a PDF download.

## Code Examples

### MCP Search Example
```bash
# Example of finding Q1 papers about AI in healthcare via MCP
scihub.search_scihub_by_keyword(keyword="Artificial Intelligence Healthcare Q1")
```

### Analyzing Rankings (Pseudocode)
```python
def is_high_impact(publication_info):
    if publication_info.type == "journal":
        return publication_info.quartile in ["Q1", "Q2"]
    if publication_info.type == "conference":
        return publication_info.rank in ["A*", "A"]
    return False
```

## Commands

```bash
# Check if scihub MCP is available
opencode mcp status scihub
```

## Resources

- **SJR Rankings**: [SCImago Journal & Country Rank](https://www.scimagojr.com/)
- **CORE Rankings**: [CORE Conference Portal](http://portal.core.edu.au/conf-ranks/)
- **Sci-Hub MCP**: See `mcp-servers/sci-hub-mcp-server/README.md`
