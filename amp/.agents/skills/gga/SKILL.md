---
name: gga
description: >
  Gentleman Guardian Angel (gga) for AI code review.
  Trigger: When reviewing code, running checks, or validating standards.
license: MIT
metadata:
  author: gentleman-programming
  version: "1.0"
---

## When to Use

Use this skill when:
- Running code reviews on staged files
- Validating code against project standards
- Setting up or configuring Gentleman Guardian Angel
- Checking if code complies with AGENTS.md rules

## Available Commands

### Quick Review (Most Common)

```bash
# Review staged files (automatic in git hooks)
gga run

# Review with verbose output
gga run -v

# Force review ignoring cache
gga run --no-cache
```

### CI/CD Mode

```bash
# Review last commit (for CI/CD pipelines)
gga run --ci

# Combined with cache bypass
gga run --ci --no-cache
```

### Configuration

```bash
# Show current configuration
gga config

# Initialize gga in a new project
gga init

# Install git pre-commit hook
gga install

# Install commit-msg hook (validates commit messages too)
gga install --commit-msg

# Remove git hooks
gga uninstall
```

### Caching

```bash
# Check cache status
gga cache status

# Clear project cache
gga cache clear

# Clear all cache (all projects)
gga cache clear-all
```

### Provider Management

```bash
# Run with specific provider
GGA_PROVIDER=claude gga run

# Common providers:
# - claude (Anthropic)
# - gemini (Google)
# - opencode (OpenCode)
# - ollama:llama3.2 (Local Ollama)
# - ollama:codellama (CodeLlama)
```

## Review Workflow

```
1. Stage files:        git add src/file.ts
2. Run review:         gga run
3. If FAILED:          Fix violations shown
4. Re-stage:           git add src/file.ts
5. Retry review:       gga run --no-cache
6. If PASSED:          Commit normally
```

## Response Format

GGA expects AI responses in this format:

```
STATUS: PASSED
or
STATUS: FAILED
file:line - rule violated - issue
```

## Bypass Review (Emergency)

```bash
# Skip pre-commit hook entirely
git commit --no-verify -m "emergency fix"

# Short form
git commit -n -m "hotfix: critical bug"
```

## Best Practices

1. **Always run `gga run` before committing** - catches issues early
2. **Use `--no-cache` after fixing violations** - ensures re-review
3. **Run `gga run --ci` in CI/CD** - validates merged code
4. **Keep AGENTS.md focused** - 100-200 lines for better results
5. **Use `GGA_PROVIDER` to switch providers** - test different AIs

## Integration with OpenCode

When using OpenCode with gga:

1. OpenCode writes code following skills
2. User stages: `git add .`
3. Run review: `gga run`
4. OpenCode (as provider) evaluates against AGENTS.md
5. Fix any issues found
6. Commit when STATUS: PASSED

## Example Output

```
$ gga run

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Gentleman Guardian Angel v2.6.1
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Provider: opencode
Rules file: AGENTS.md
Files to review:
  - src/components/Button.tsx

STATUS: PASSED

✅ CODE REVIEW PASSED
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "Provider not found" | Install provider CLI or set `PROVIDER` in .gga |
| "Rules file not found" | Create AGENTS.md in project root |
| Slow reviews | Add large files to `EXCLUDE_PATTERNS` |
| Cache issues | `gga run --no-cache` or `gga cache clear` |

## Keywords
gga, gentleman guardian angel, code review, ai review, pre-commit, agi review
