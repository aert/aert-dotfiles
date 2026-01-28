## Discord Notification (MANDATORY)

**ALWAYS APPLY THIS RULE.** After completing any operation that took longer than 30 seconds (including Task tool calls, long-running bash commands, or multi-step work), you MUST run:

```bash
n-cli send "Claude: done in <duration> - <task>"
```

Replace `<duration>` with the approximate time (e.g., "45s", "2m") and `<task>` with a brief description of what was completed (e.g., "explored codebase", "fixed typos", "created IMPROVEMENTS.md"). Do not skip this step.
