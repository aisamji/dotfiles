---
name: migrate-permissions
description: Migrate permissions from the current project's local .claude/settings.json or .claude/settings.local.json to global settings
disable-model-invocation: true
allowed-tools: Bash(python *)
---

Run the migration script:

```bash
python ~/.claude/skills/migrate-permissions/scripts/migrate.py
```
