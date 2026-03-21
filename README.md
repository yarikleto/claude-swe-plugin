<p align="center">
  <img src="logo.svg" width="180" height="180" alt="SWE Plugin Logo">
</p>

<h1 align="center">Claude SWE Plugin</h1>

<p align="center">
  <strong>A full software engineering team inside Claude Code.</strong><br>
  CEO orchestrator + 10 specialized agents + 10 skills = from idea to production.
</p>

<p align="center">
  <a href="#quick-start">Quick Start</a> &middot;
  <a href="#the-team">The Team</a> &middot;
  <a href="#skills">Skills</a> &middot;
  <a href="#the-pipeline">Pipeline</a> &middot;
  <a href="#architecture">Architecture</a>
</p>

---

## What Is This?

A Claude Code plugin that transforms Claude into a full software engineering organization. Instead of one AI doing everything, you get a **CEO orchestrator** that delegates work to specialized agents — each with deep domain expertise, clear responsibilities, and strict rules of engagement.

The CEO doesn't write code. The developer doesn't write tests. The tester doesn't touch production code. The designer creates prototypes, not implementations. Everyone has a lane, and the reviewer makes sure nobody crosses it.

## Installation

All commands below run **inside Claude Code** (not in your shell).

### From GitHub (recommended)

```bash
# 1. Add the marketplace (one time)
claude plugins marketplace add https://github.com/yarikleto/claude-swe-plugin

# 2. Install in your project
cd your-project
claude plugins install claude-swe-plugin --scope project
```

### From local directory (development)

```bash
claude --plugin-dir /path/to/claude-swe-plugin
```

### Managing the plugin

```bash
# Update to latest version
claude plugins update claude-swe-plugin@claude-swe-marketplace --scope project

# Uninstall
claude plugins uninstall claude-swe-plugin

# Reload after local changes (dev mode)
/reload-plugins
```

## Quick Start

Once installed, kick off a new project:

```bash
/claude-swe-plugin:swe-init
```

That's it. The CEO will start a conversation with you, understand what you want to build, and drive the entire process.

## The Team

The plugin creates a virtual engineering organization with 10 specialized agents, orchestrated by a CEO persona defined in your project's `CLAUDE.md`.

<table>
<tr>
<td width="50%" valign="top">

### CEO (You / CLAUDE.md)
The orchestrator. Thinks like Bezos (Type 1/Type 2 decisions), Jobs (focus = saying no), Musk (first principles). Never writes code. Delegates everything. Plays devil's advocate. Runs pre-mortems. Uses the Editor Model for delegation (Rabois).

### Designer
Aesthetic sensibility trained on Dieter Rams, Jony Ive, and Swiss design. Knows color theory (60-30-10), typography (modular scale), layout (8px grid). Researches Mobbin/Dribbble/Awwwards before designing. Creates Excalidraw wireframes and HTML+Tailwind interactive prototypes. Adapts to project type (web, mobile, CLI, API, game, desktop).

### UX Engineer
Ensures products are genuinely usable, not just beautiful. Nielsen's 10 Heuristics as a concrete checklist. Checks cognitive load (Miller's, Hick's, Fitts's laws). WCAG AA accessibility is non-negotiable. Adapts to project type — web forms, CLI help text, API developer experience, mobile thumb zones.

### Architect
Domain-agnostic. Thinks in trade-offs (Richards & Ford). Starts simple (Gall's Law). Boring technology by default (McKinley). Classifies decisions as Type 1/Type 2. Writes ADRs. Creates C4 diagrams. Knows patterns for web, mobile, CLI, game, blockchain, embedded, data pipelines. Designs for failure.

### DBA (Database Master)
Database-agnostic — chooses the right engine for the domain (relational, document, graph, key-value, time-series, embedded). Knows DDD bounded contexts, event sourcing, CQRS, temporal data, saga/outbox patterns. Domain-specific modeling (e-commerce, financial, social, IoT). Zero-downtime migrations. "The database outlives the application."

</td>
<td width="50%" valign="top">

### Developer
Data structures first, code second (Torvalds). Full freedom in implementation — chooses approach, patterns, structure. Eliminates edge cases through better design, not conditionals (Torvalds' "good taste"). Immutability and pure functions by default (Hickey, Carmack). May write own tests during development. Owns documentation and DB migrations. **Must not modify existing tests from previous tasks.**

### Tester (QA)
Verifies AFTER the developer implements. Writes tests to confirm the feature works as intended — behavior and outcomes, not implementation details. Equivalence partitioning, boundary values, state transitions, error guessing. Knows the test doubles taxonomy (Meszaros). **Forbidden from touching production code.**

### Reviewer
Triple gatekeeper: (1) Separation — verifies tester didn't touch production code, developer didn't break existing tests. (2) Robustness — implementation is genuine, general, and robust (not fitted to test cases). (3) Test quality + code quality — tests verify behavior not implementation, acceptance criteria met, goal achieved. Marks criteria checkboxes `[x]` on APPROVE. Nothing ships without APPROVE.

### DevOps
Full infrastructure stack: CI/CD, Docker, reverse proxy (Caddy/nginx/Traefik), caching (CDN + proxy + browser), load balancing, SSL/TLS (Mozilla profiles, auto-certs), compression (brotli/gzip, pre-compressed), rate limiting (3 layers: edge → gateway → app), structured logging (Loki/ELK, correlation IDs), environment management (dev/staging/prod parity, feature flags). Starts simple (PaaS > K8s). Creates handoff guides for client actions. Clear boundary with architect: architect decides WHAT, DevOps implements HOW it runs.

### Manual QA
Exploratory tester — finds bugs that specs don't predict. Session-based exploratory testing (James Bach, Michael Bolton). Runs at milestone checkpoints, not per-task. Adapts tools to project type: Playwright for web/mobile/game UI; Bash + curl/scripts for CLI, API, libraries, backend services. Covers cross-feature interactions, input edge cases, error recovery, state/timing issues. Doesn't write tests or fix code — reports findings with evidence and reproduction steps.

### Researcher
Intelligence analyst with 6 modes: market/domain research, codebase exploration, technology evaluation, UX research, bug investigation, infrastructure comparison. BLUF reporting. Confidence levels (confirmed/likely/possible/speculative). Any agent can delegate here.

</td>
</tr>
</table>

## Separation of Concerns

> **Developer implements with full freedom (may write tests). Tester verifies with tests (must not touch production code).**

Developer goes first, QA verifies after. Developer can write their own tests during development but must not modify existing tests from previous tasks. Tester writes verification tests to confirm the goal was achieved — tests behavior, not implementation details.

## Skills

| Skill | Purpose | Agent |
|-------|---------|-------|
| `/swe-init` | Project kickoff — conversation, product vision, prototypes, iterate until approved | CEO |
| `/swe-designer-spec` | Extract design specification from approved prototype (tokens, components, screens) | Designer |
| `/swe-architect-design` | System design — architecture, ADRs, data model, APIs, C4 diagrams | Architect + DevOps |
| `/swe-dba-schema` | Database schema — tables, indexes, constraints, ER diagram, migration plan | DBA |
| `/swe-devops-deploy` | Infrastructure — CI/CD, Docker, hosting, CDN, monitoring + client handoff guides | DevOps |
| `/swe-architect-tasks` | Decompose system design into tasks with statuses, dependencies, acceptance criteria | Architect |
| `/swe-tester-plan` | Test strategy — frameworks, pyramid, coverage map, Definition of Done | Tester |
| `/swe-sprint` | Task cycle: developer implements → QA verifies with tests → reviewer → designer/UX → DONE. Milestone: all agents give verdicts → client reviews → CEO synthesizes | CEO |
| `/swe-brief` | CEO revisits product vision, checks reality vs plan, updates strategic documents | CEO |
| `/swe-sync` | Quick sync — CEO reviews recent changes, updates knowledge base | CEO |

## The Pipeline

```
/swe-init              Client conversation → Product vision → Prototypes
                        → UX review → Client approval → Design spec extracted
      ↓
/swe-architect-design  System design (architect + devops together)
      ↓
/swe-dba-schema        Database schema, ER diagram, migrations
      ↓
/swe-devops-deploy     CI/CD, Docker, hosting, monitoring + handoff guides
      ↓
/swe-architect-tasks   Task breakdown — walking skeleton first, vertical slices
                        (uses design-spec for screen refs + visual criteria)
      ↓
/swe-tester-plan       Test strategy, frameworks, coverage map
      ↓
/swe-sprint            For each task:
                         ┌─ developer implements (full freedom, may write tests)
                         ├─ QA verifies with tests (behavior, not implementation)
                         ├─ reviewer verifies (separation + anti-cheat + test quality + code quality)
                         ├─ designer checks visual fidelity (UI tasks)
                         ├─ UX engineer checks usability (UI tasks)
                         └─ DONE → next task
                        Milestone checkpoint:
                         ├─ designer + UX + manual QA give verdicts (parallel)
                         ├─ client reviews: direction check + feedback
                         └─ CEO synthesizes → fix bugs / adjust architecture / add tasks
```

## The Task Cycle

```
TODO → IN_PROGRESS → VERIFYING → IN_REVIEW → DONE
                                      ↓
                               CHANGES_REQUESTED → fix → IN_REVIEW
                                      ↓
                                   BLOCKER → revert → IN_PROGRESS
```

### Special task types

- **`setup`** — developer only → reviewer (bootstrap, scaffolding)
- **`refactor`** — developer → reviewer → tester runs regression (no new tests)
- **`performance`** — researcher profiles → developer optimizes → tester benchmarks
- **`hotfix`** — fast-track: developer fixes → reviewer quick review → tester adds regression test after

### Bootstrap (first sprint)

Before the first task cycle, the bootstrap phase runs:
1. **Developer** scaffolds the project (package.json, directory structure, configs)
2. **Tester** sets up test infrastructure (framework, config, directory, trivial passing test)
3. **DevOps** creates Dockerfile, docker-compose, CI pipeline

## Circuit Breakers

The CEO stops the cycle and talks to the client when:

- A task fails review **twice** (retry loop)
- Developer **can't implement** (design flaw, contradictory criteria)
- QA **can't verify** (unclear criteria, untestable implementation)
- **All tasks blocked** (nothing productive to do)
- Task is **much bigger than estimated** (scope discovery)
- **Design doesn't match reality** (fundamental flaw found)
- Repeated **separation violations** (systemic problem)
- Every **3-5 tasks**: pulse check with the client

**Golden rule:** When in doubt, STOP and ASK. One clarifying question is cheaper than rebuilding the wrong thing.

## Architecture

```
claude-swe-plugin/
├── .claude-plugin/
│   ├── plugin.json                 # Plugin manifest
│   └── marketplace.json            # Marketplace discovery
├── .mcp.json                       # Playwright MCP for screenshots
├── hooks/
│   └── hooks.json                  # 5 hooks (see Hooks section)
├── scripts/
│   ├── session-start.sh            # Loads CEO brain into context
│   ├── iron-rule-check.sh          # Blocks tester from editing production files
│   ├── auto-format.sh              # Runs formatter after edits
│   ├── stop-save-progress.sh       # Warns about unsaved progress on session end
│   └── post-commit-remind.sh       # Reminds to update task status
├── agents/
│   ├── architect.md                # Domain-agnostic system design, ADRs, C4
│   ├── dba.md                      # Database-agnostic schema, migrations, integrity
│   ├── designer.md                 # Prototypes, visual review, design spec
│   ├── developer.md                # Implementation with full freedom (may write tests)
│   ├── devops.md                   # CI/CD, infrastructure, handoff guides
│   ├── manual-qa.md                # Exploratory testing, edge cases, cross-viewport
│   ├── researcher.md               # 6-mode intelligence analyst
│   ├── reviewer.md                 # Separation + robustness + test quality + code quality gate
│   ├── tester.md                   # QA verification, writes tests after implementation (forbidden from production code)
│   └── ux-engineer.md              # Nielsen's 10 heuristics, accessibility
└── skills/
    ├── swe-init/SKILL.md           # Project kickoff
    ├── swe-designer-spec/SKILL.md  # Design specification
    ├── swe-architect-design/SKILL.md # System design
    ├── swe-dba-schema/SKILL.md     # Database schema design
    ├── swe-devops-deploy/SKILL.md  # Infrastructure setup
    ├── swe-architect-tasks/SKILL.md # Task decomposition
    ├── swe-tester-plan/SKILL.md    # Test strategy
    ├── swe-sprint/SKILL.md         # Task execution cycle
    ├── swe-brief/SKILL.md          # Strategic review
    └── swe-sync/SKILL.md           # Quick sync
```

### Project Documents (generated in `.claude/`)

```
.claude/
├── ceo-brain.md              # CEO strategic knowledge base
├── product-vision.md         # Product vision (approved by client)
├── design-spec.md            # Design tokens, components, screens
├── system-design.md          # Architecture, ADRs, data model, APIs
├── database-schema.md        # DB schema, ER diagram, migrations, indexes
├── infra-plan.md             # Infrastructure, CI/CD, costs
├── tasks/                    # Task files (one per task)
│   ├── _overview.md          # Milestones, critical path, Definition of Done
│   ├── TASK-001.md           # Individual task files
│   └── ...
├── test-plan.md              # Test strategy
├── prototypes/               # All prototype versions (never deleted)
├── handoff/                  # Client action guides (from DevOps)
├── research/                 # All research output (from Researcher)
├── contracts/                # Interface contracts per task (from Architect)
└── decisions/                # Individual ADR files
```

## Hooks (Automated Enforcement)

5 hooks run automatically — no manual invocation needed:

| Hook | Event | What it does |
|------|-------|-------------|
| **CEO Brain Loader** | `SessionStart` | Loads `.claude/ceo-brain.md` into context. If missing, reminds to run `/swe-init`. |
| **Separation Enforcer** | `PreToolUse` (Edit\|Write) | **Mechanically BLOCKS** tester from editing production files. Uses `agent_type` to identify who's editing. Developer has full freedom. Language-agnostic: covers JS/TS, Python, Ruby, Go, Rust, Java, C/C++, Swift, Dart, Elixir, PHP, C#, Haskell, Lua, Shell, and more. |
| **Auto-Formatter** | `PostToolUse` (Edit\|Write) | Runs the project's formatter after every code edit. Tries prettier/biome first, falls back to language-specific tools (gofmt, rustfmt, black, rubocop, clang-format, etc.). Async, non-blocking. |
| **Save Progress Guard** | `Stop` | **Warns** if tasks are still `IN_PROGRESS`, uncommitted changes exist, or CEO brain is stale. Reminds to save work before leaving. |
| **Post-Commit Reminder** | `PostToolUse` (Bash) | After `git commit`, reminds to update task status in `.claude/tasks/`. |

The separation hook provides **mechanical enforcement** — even if the tester agent "forgets" the rule, the hook physically blocks the write to production files.

## Adapts to Any Project Type

This is not a web-only plugin. It adapts to whatever you're building:

| Project Type | Designer | UX Engineer | Manual QA | Architect | DBA | DevOps |
|---|---|---|---|---|---|---|
| **Web App** | HTML+Tailwind prototypes | Full heuristic + a11y audit | Playwright: viewports, forms, keyboard | Modular monolith / hexagonal | Postgres + JSONB | Vercel/Railway + CDN |
| **Mobile App** | HTML mobile viewport | Touch targets, thumb zones, HIG | Playwright: viewport sim, gestures | Clean Architecture MVVM | SQLite / Core Data | App store handoff guides |
| **CLI Tool** | Terminal mockups, shell scripts | Help text, flags, `NO_COLOR` | Bash: flags, pipes, exit codes, stderr | Plugin architecture | Flat files / SQLite | Homebrew/cargo publish |
| **API/SDK** | Code examples, README docs | DX: naming, errors, docs | Bash + curl: payloads, auth, rate limits | Clear public surface, semver | Depends on domain | Docs hosting, versioning |
| **Game** | Screen mockups, HUD layout | Controls, onboarding, menus | Playwright/Bash: rapid inputs, state | ECS / scene graph | Depends on persistence | Build pipeline, distribution |
| **Blockchain** | State diagrams | Config ergonomics | Bash: tx edge cases, config | Consensus + state machine | Embedded / distributed | Node deployment |
| **Backend/Infra** | Architecture diagrams | Error logging, config | Bash: health, load, restart, config | Event-driven / pipeline | Domain-specific | Cloud setup, monitoring |

## Philosophy

Built on the shoulders of:

- **Bezos** — Type 1/Type 2 decisions, Working Backwards, disagree and commit
- **Jobs** — Focus = saying no, DRI (one person per task)
- **Musk** — First principles, "the best part is no part"
- **Kent Beck** — "make it work, make it right, make it fast", test-driven thinking
- **Torvalds** — Data structures first, "good taste" (eliminate edge cases through design)
- **Dieter Rams** — "As little design as possible"
- **Don Norman** — Affordances, signifiers, conceptual models
- **Nielsen** — 10 Usability Heuristics
- **Gene Kim** — The Three Ways of DevOps
- **Martin Kleppmann** — Designing Data-Intensive Applications
- **Martin Fowler** — Testing pyramid, evolutionary architecture
- **Sandi Metz** — "Duplication is far cheaper than the wrong abstraction"
- **Codd & Date** — Relational theory, normalization
- **Markus Winand** — SQL performance, "Use The Index, Luke"
- **James Bach** — Exploratory Testing 3.0, Session-Based Test Management
- **Michael Bolton** — Context-driven testing, exploratory vs scripted

## License

MIT
