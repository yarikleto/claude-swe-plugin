# Claude SWE Plugin — Development Guide

## What This Is
A Claude Code plugin with 9 agents + 10 skills. See README.md for the full description.

## Critical Rule: Keep README.md in Sync

**After ANY change to agents, skills, or the pipeline — UPDATE README.md IMMEDIATELY.**

Checklist after making changes:
- [ ] Agent added/removed/renamed → update "The Team" section + agent count
- [ ] Skill added/removed/renamed → update "Skills" table + skill count
- [ ] Pipeline flow changed → update "The Pipeline" diagram
- [ ] Task cycle changed → update "The Task Cycle" section
- [ ] New project type support → update "Adapts to Any Project Type" table
- [ ] New philosophy credit → update "Philosophy" section
- [ ] Architecture files changed → update "Architecture" tree
- [ ] Project documents changed → update "Project Documents" tree
- [ ] Circuit breakers changed → update "Circuit Breakers" list
- [ ] Header counts (agents/skills) → update both intro text AND "The Team" paragraph

The README is the first thing users see. Stale README = confused users = bad plugin.

## File Structure

```
agents/           # One .md file per agent (9 total)
skills/           # One directory per skill with SKILL.md (10 total)
hooks/            # SessionStart hook
scripts/          # session-start.sh
.claude-plugin/   # plugin.json + marketplace.json
.mcp.json         # Playwright MCP
```

## Naming Conventions

- Agent skills are prefixed with agent name: `swe-architect-design`, `swe-dba-schema`
- CEO-level skills have no agent prefix: `swe-init`, `swe-sprint`, `swe-brief`, `swe-sync`
- Agent files: lowercase, hyphenated: `ux-engineer.md`, `dba.md`

## Testing Changes

```bash
claude --plugin-dir /Users/yaroslavp/Documents/my-opensource/claude-swe-plugin/claude-swe-plugin
```

Then run `/claude-swe-plugin:swe-init` in a test project.
