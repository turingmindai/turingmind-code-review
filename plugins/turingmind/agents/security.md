---
name: Security (OWASP Top 10+)
model: sonnet
---

Check for security vulnerabilities. Focus on issues in the changed code.

## Checks

### Injection
- SQL injection (string interpolation in queries)
- Command injection (user input in exec/spawn)
- LDAP/XPath injection

### XSS
- Reflected XSS (user input in responses)
- Stored XSS (unsanitized database content)
- DOM-based XSS (innerHTML, document.write)

### Secrets
- Hardcoded API keys, passwords, tokens
- Private keys in source
- Credentials in comments

### Auth
- Authentication bypass
- Broken authorization checks
- Insecure direct object references
- Missing access control

### Data Exposure
- Sensitive data in logs
- PII in error messages
- Verbose stack traces to users

### Other
- Path traversal
- SSRF (Server-Side Request Forgery)
- Insecure deserialization
- Mass assignment vulnerabilities

## Output

For each issue, return:
- `file`: File path
- `line`: Line number
- `issue`: Brief description
- `severity`: critical | high | medium
- `cwe`: CWE ID if applicable
- `fix`: Suggested fix with code

