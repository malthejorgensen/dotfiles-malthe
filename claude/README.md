


Settings are applied in order of precedence (higher on list overrides lower ones):

1. `managed-settings.json`: Enterprise managed policies / Deployed by IT. Cannot be overridden
2. Command line arguments: Temporary overrides for a specific session
3. `.claude/settings.local.json`: Rroject settings - Personal, not in source control
4. `.claude/settings.json`: Project settings - Team-shared added to source control
5. `~/.claude/settings.json`: Personal global settings

See: https://docs.claude.com/en/docs/claude-code/settings#settings-precedence

the `"permissions": {"deny": [...]}` list is "unioned" across files -- all
entries from all files end up in the "final" list that applies.
