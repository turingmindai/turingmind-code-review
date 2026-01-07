---
allowed-tools: Bash(git diff:*), Bash(git status:*), Bash(git log:*), Bash(git blame:*), Bash(git show:*), Read, Grep, Glob, LS
description: Deep comprehensive code review with full context analysis
---

Comprehensive code review with full context analysis. Includes architecture review, test coverage, and impact analysis.

## Phase 1: Gather Context (3 Parallel Haiku Agents)

**Agent 1A - Change Summary:**
- Run `git status`, `git diff`, `git diff --staged`
- If no changes, inform user and stop
- Identify languages from file extensions
- Return: files changed, languages detected, line counts

**Agent 1B - Project Context:**
- Find and read CLAUDE.md files (root + directories containing modified files)
- Read dependency files (package.json, requirements.txt, go.mod, Cargo.toml)
- Identify project type and framework

**Agent 1C - Related Files:**
- For each modified file, find:
  - Files that import/require the modified file
  - Files that the modified file imports
  - Corresponding test files (e.g., `foo.ts` → `foo.test.ts`, `foo_test.go`)
- Use grep/glob to find these relationships

## Phase 2: Deep Analysis (6 Parallel Sonnet Agents)

Each agent reads full file context and related files when needed. Return structured issues:

**Agent 2A - Compliance:**
Use instructions from `@agents/compliance.md`

**Agent 2B - Bugs & Logic:**
Use instructions from `@agents/bugs.md`

**Agent 2C - Security:**
Use instructions from `@agents/security.md`

**Agent 2D - Language-Specific:**
Based on languages detected in Phase 1:
- TypeScript/JavaScript: Use `@agents/language-typescript.md`
- Python: Use `@agents/language-python.md`
- Other languages: Apply general best practices

**Agent 2E - Architecture:**
Use instructions from `@agents/architecture.md`
Use related file context from Phase 1C

**Agent 2F - Tests & Documentation:**
- Do corresponding test files exist for modified code?
- If tests exist, do they need updating for this change?
- Are new public APIs/functions missing tests?
- Are there inline comments explaining non-obvious logic?
- If README or docs exist, do they need updates?

## Phase 3: Impact Analysis (Sonnet Agent)

Using Phase 1C results, analyze:
- What other parts of the codebase could be affected?
- Are there breaking changes to public APIs?
- Could this change affect performance at scale?
- Are there database/schema implications?
- What's the blast radius if this change has a bug?

## Phase 4: Confidence Scoring (Parallel Haiku Agents)

For each issue from Phase 2 and 3, score confidence 0-100 using criteria from `@templates/false-positive-rules.md`

## Phase 5: Filter & Present

- Filter issues with score < 70
- Apply false positive rules from `@templates/false-positive-rules.md`
- Format output using `@templates/output-format.md`
- Use `review_type: "Deep Code"` in the template
- Include all sections: Critical, High, Medium, Architectural Notes, Impact Analysis

### Notes

- Do not attempt to build or typecheck the app
- For each issue, include:
  - File path and line number
  - Brief description of the problem
  - Why it matters
  - Suggested fix (with code snippet if helpful)
- Include architectural observations even if not "issues"
- If no issues found, confirm the code looks good for commit
