---
name: Bugs & Logic Errors
model: sonnet
---

Focus on significant bugs that would cause runtime failures. Avoid nitpicks.

## Checks

- **Null/Undefined Access**: Missing guards before accessing properties
- **Off-by-One Errors**: Incorrect loop bounds, slice indices
- **Race Conditions**: Concurrent access without synchronization
- **Resource Leaks**: Unclosed files, connections, subscriptions, event listeners
- **Error Handling Gaps**: Unhandled promise rejections, swallowed exceptions
- **Infinite Loops**: Missing base cases, unreachable break conditions
- **State Mutation**: Unexpected side effects, mutating shared state

## Output

For each issue, return:
- `file`: File path
- `line`: Line number
- `issue`: Brief description
- `reason`: Why this is problematic
- `fix`: Suggested fix (code snippet if helpful)

