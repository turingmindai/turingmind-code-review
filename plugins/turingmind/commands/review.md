---
allowed-tools: Bash(git diff:*), Bash(git status:*), Bash(git log:*), Bash(git blame:*), Bash(git show:*)
description: Quick code review for uncommitted local changes
---

Quick code review for uncommitted changes. Fast, focused on critical issues.

## Step 1: Gather Changes (Haiku Agent)

- Run `git status` to see what files have changes
- Run `git diff` for unstaged and `git diff --staged` for staged
- If no changes, inform user and stop
- Identify languages from file extensions
- Return: files changed, languages detected, line counts

## Step 2: Find Project Guidelines (Haiku Agent)

- Find root CLAUDE.md
- Find CLAUDE.md files in directories containing modified files
- Extract actionable review rules

## Step 3: Review (4 Parallel Sonnet Agents)

Launch agents based on detected languages. Each agent reads full file context and returns structured issues:

**Agent 1 - Compliance:**
Use instructions from `@agents/compliance.md`

**Agent 2 - Bugs & Logic:**
Use instructions from `@agents/bugs.md`

**Agent 3 - Security:**
Use instructions from `@agents/security.md`

**Agent 4 - Language-Specific:**
Based on languages detected in Step 1:
- TypeScript/JavaScript: Use `@agents/language-typescript.md`
- Python: Use `@agents/language-python.md`
- Other languages: Apply general best practices

## Step 4: Confidence Scoring (Parallel Haiku Agents)

For each issue from Step 3, score confidence 0-100 using criteria from `@templates/false-positive-rules.md`

## Step 5: Filter & Present

- Filter issues with score < 80
- Apply false positive rules from `@templates/false-positive-rules.md`
- Format output using `@templates/output-format.md`
- Use `review_type: "Code"` in the template
- Only include Critical (95-100) and Warning (80-94) sections

### Notes

- Do not attempt to build or typecheck the app
- For each issue, include:
  - File path and line number
  - Brief description of the problem
  - Why it matters
  - Suggested fix (with code snippet if helpful)
- If no issues found, confirm the code looks good for commit
