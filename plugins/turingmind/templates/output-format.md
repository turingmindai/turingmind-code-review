---
name: Output Format Template
---

## Output Format

Use this template for presenting review results.

### With Issues Found

```
## {{review_type}} Code Review

**Summary:** Reviewed {{file_count}} files, {{line_count}} lines changed, found {{issue_count}} issues

### Critical (95-100) 🔴
Must fix before committing:

1. **{{file}}:{{line}}** - {{issue}}

   {{reason}}
   
   ```diff
   {{fix}}
   ```

### High Priority (80-94) 🟠
Should fix:

1. **{{file}}:{{line}}** - {{issue}}

   {{reason}}
   
   Suggested: `{{fix}}`

### Medium Priority (70-79) 🟡
Consider fixing:

1. **{{file}}:{{line}}** - {{issue}}

   {{reason}}

### Architectural Notes 📐

- Pattern consistency: {{icon}} {{observation}}
- Test coverage: {{icon}} {{observation}}
- Documentation: {{icon}} {{observation}}
- Dependencies: {{icon}} {{observation}}

### Impact Analysis 💥

- **Affected files:** {{affected_files}}
- **Blast radius:** {{blast_radius}}
- **Breaking changes:** {{breaking_changes}}
```

### Icons

- ✅ Good / Passes
- ⚠️ Warning / Needs attention
- ❌ Problem / Fails
- ℹ️ Informational

### No Issues Found

```
## {{review_type}} Code Review

**Summary:** Reviewed {{file_count}} files, {{line_count}} lines changed

✅ **No significant issues found. Code looks good for commit.**

Checked for: {{checks_performed}}
```

### Section Inclusion Rules

| Section | Quick Review | Deep Review |
|---------|--------------|-------------|
| Critical (95-100) | ✅ | ✅ |
| High Priority (80-94) | ✅ | ✅ |
| Medium Priority (70-79) | ❌ | ✅ |
| Architectural Notes | ❌ | ✅ |
| Impact Analysis | ❌ | ✅ |

