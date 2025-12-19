# ai-playbook

Battle-tested patterns, workflows, and tools for AI-assisted software development with Claude Code.

## Quick Start

### New Machine Setup

```bash
# Clone the playbook
git clone https://github.com/smeed652/ai-playbook.git
cd ai-playbook

# Set up Claude Code symlinks
./scripts/setup-claude.sh
```

### New Project Setup

```bash
# Initialize a new project with sprint workflow
./scripts/init-project.sh /path/to/new-project my-project-name
```

## What's Included

```
ai-playbook/
├── commands/           # Slash commands for Claude Code
│   ├── sprint-*.md     # Sprint lifecycle (/sprint-start, /sprint-next, etc.)
│   ├── epic-*.md       # Epic management (/epic-new, /epic-start, etc.)
│   └── project-*.md    # Project setup (/project-create)
│
├── agents/             # Specialized agent definitions
│   ├── context-fetcher.md
│   ├── date-checker.md
│   ├── file-creator.md
│   └── test-runner.md
│
├── skills/             # Reusable skill definitions
│   ├── validate-graphql.md
│   ├── validate-mcp.md
│   ├── run-migrations.md
│   ├── lint-fix.md
│   └── smoke-tests.md
│
├── templates/          # Project templates
│   ├── project/        # New project boilerplate
│   │   ├── CLAUDE.md
│   │   └── .claude/
│   └── sprint-template.md
│
├── workflows/          # Development process documentation
├── patterns/           # Code pattern documentation
├── playbooks/          # How-to guides
│
├── sprint-steps.json   # Sprint workflow step definitions
└── scripts/
    ├── setup-claude.sh   # Set up ~/.claude symlinks
    └── init-project.sh   # Initialize new project
```

## Sprint Workflow

The playbook includes a complete sprint workflow system:

```bash
/sprint-start 1      # Initialize sprint, spawn Plan agent
/sprint-next 1       # Advance to next step
/sprint-status 1     # Check current progress
/sprint-complete 1   # Finish sprint with checklist
```

### Workflow Phases

| Phase | Steps | Description |
|-------|-------|-------------|
| 1. Planning | 1.1-1.4 | Read sprint, design architecture, clarify requirements |
| 2. Implementation | 2.1-2.4 | TDD: write tests, implement, run tests, fix failures |
| 3. Validation | 3.1-3.4 | Verify migrations, quality review, refactor |
| 4. Documentation | 4.1 | Generate dialog examples |
| 5. Commit | 5.1 | Stage and commit changes |
| 6. Completion | 6.1-6.4 | Update sprint file, checklist, close |

## Epic Management

Organize sprints into epics:

```bash
/epic-new            # Create new epic
/epic-start 1        # Start working on epic
/epic-status 1       # Check epic progress
/epic-complete 1     # Complete epic
```

## Commands Reference

### Sprint Commands
| Command | Description |
|---------|-------------|
| `/sprint-new` | Create a new sprint from template |
| `/sprint-start <N>` | Initialize and start sprint N |
| `/sprint-next <N>` | Advance to next step |
| `/sprint-status <N>` | Show current progress |
| `/sprint-complete <N>` | Run checklist and complete |
| `/sprint-blocked <N>` | Mark as blocked |
| `/sprint-abandon <N>` | Abandon sprint |

### Epic Commands
| Command | Description |
|---------|-------------|
| `/epic-new` | Create new epic |
| `/epic-start <N>` | Start epic |
| `/epic-status <N>` | Show epic status |
| `/epic-list` | List all epics |
| `/epic-complete <N>` | Complete epic |
| `/epic-archive <N>` | Archive completed epic |

### Project Commands
| Command | Description |
|---------|-------------|
| `/project-create` | Initialize new project |
| `/project-update` | Sync workflow updates |

## Documentation

### Workflows
- [Sprint Workflow v2](workflows/sprint-workflow-v2.md) - Complete sprint lifecycle
- [Development Infrastructure](workflows/development-infrastructure.md) - Agents, skills, commands
- [Documentation Approach](workflows/documentation-approach.md) - How to document

### Patterns
- [GraphQL Schema](patterns/graphql-schema.md) - GraphQL with Strawberry
- [Provider Pattern](patterns/provider-pattern.md) - External data abstraction
- [MCP Tool Registry](patterns/mcp-tool-registry.md) - LLM tool definitions

### Playbooks
- [Adding External Data Source](playbooks/adding-external-data-source.md)
- [Onboarding MCP Tool](playbooks/onboarding-mcp-tool.md)
- [Project Execution Lessons](playbooks/project-execution-lessons.md)

## How It Works

The playbook uses symlinks to integrate with Claude Code:

```
~/.claude/
├── commands -> /path/to/ai-playbook/commands/
├── agents -> /path/to/ai-playbook/agents/
├── skills -> /path/to/ai-playbook/skills/
├── templates -> /path/to/ai-playbook/templates/
└── sprint-steps.json -> /path/to/ai-playbook/sprint-steps.json
```

This means:
- **Single source of truth**: All commands live in the playbook repo
- **Easy updates**: `git pull` updates all your commands
- **Portable**: Clone on new machine, run setup script, done

## Contributing

1. Fork the repo
2. Make changes to commands/patterns/workflows
3. Test with a real project
4. Submit PR

## License

MIT
