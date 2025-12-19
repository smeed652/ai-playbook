# CorrData Cookbook

A collection of battle-tested recipes for building, operating, and scaling CorrData.

## Quick Start

**New to the cookbook?** Here's how to get started:

```bash
# Find a recipe for what you're doing
grep -r "your-topic" docs/cookbook/

# Or browse by category
ls docs/cookbook/workflows/   # Development processes
ls docs/cookbook/patterns/    # Code patterns
ls docs/cookbook/playbooks/   # Operations guides
```

**Common tasks:**
| I want to... | Read this recipe |
|--------------|------------------|
| Set up VS Code for development | [VS Code Setup](workflows/vscode-setup.md) |
| Start a new sprint | [Sprint Workflow v2.2](workflows/sprint-workflow-v2.md) |
| Understand our tech stack | [Tech Stack Reference](patterns/tech-stack-reference.md) |
| Know what to build first | [Development Sequence](workflows/development-sequence.md) |
| Generate UI with v0.dev | [v0 UI Generation](playbooks/v0-ui-generation.md) |
| Add a GraphQL module | [GraphQL Schema Design](patterns/graphql-schema.md) |
| Add external data source | [Adding External Data Source](playbooks/adding-external-data-source.md) |
| Add an MCP tool | [Onboarding MCP Tool](playbooks/onboarding-mcp-tool.md) |
| Create REST endpoint | [Creating REST Endpoint](playbooks/creating-rest-endpoint.md) |
| Set up deployment | [Deployment Setup](playbooks/deployment-setup.md) |
| Understand our patterns | [Three-Layer Database](patterns/three-layer-database.md) |

## Philosophy

This cookbook captures **what actually works** - not theory, but proven patterns extracted from real sprints, real failures, and real wins. Every recipe includes:

1. **Context** - When and why to use this recipe
2. **Ingredients** - What you need before starting
3. **Steps** - Clear, actionable instructions
4. **Learnings** - What we discovered along the way
5. **Anti-patterns** - What NOT to do

## Structure

```
cookbook/
├── workflows/       # Development & operational workflows
│   ├── sprint-workflow-v2.md      # Parallel agent sprint execution
│   ├── development-infrastructure.md # Agents, skills, commands
│   ├── documentation-approach.md  # How we document
│   └── epic-planning.md           # Multi-sprint epic management
│
├── patterns/        # Reusable code patterns
│   ├── graphql-module.md          # Adding new GraphQL modules
│   ├── mcp-tool.md                # Creating MCP tools
│   ├── migration-pattern.md       # Database migrations
│   └── provider-pattern.md        # External data providers
│
├── integrations/    # External system integrations
│   ├── fema-flood-zones.md        # FEMA NFHL integration
│   ├── usgs-seismicity.md         # Earthquake data
│   ├── npms-pipeline-data.md      # Pipeline registry
│   └── insar-subsidence.md        # Satellite displacement
│
├── cloud/           # Cloud infrastructure
│   └── aws-infrastructure.md      # AWS EC2/ECR/Cognito setup
│
└── playbooks/       # Troubleshooting & operations
    ├── deployment-setup.md        # Staging/production deployment
    ├── project-execution-lessons.md # Lessons from 109 sprints
    └── database-recovery.md       # Disaster recovery
```

## Using This Cookbook

### For Developers

1. Before starting a new feature, check if a relevant recipe exists
2. Follow recipes step-by-step - they're battle-tested
3. **Contribute back**: Update recipes with new learnings

### For Claude Code Agents

Recipes are designed to be agent-readable. When working on a task:
1. Check the cookbook for relevant patterns
2. Follow the recipe structure
3. Report deviations in postmortem

### For External Sharing

Selected recipes are synced to Mintlify for public documentation:
- `/Volumes/Foundry/Development/CorrData/mintlify-docs/cookbook/`
- Run `npm run sync-cookbook` to update

## Example: Using a Recipe

Here's how to use the Sprint Workflow recipe:

**1. Check the Context section** - Make sure this recipe applies:
```markdown
## Context
**When to use this recipe:**
- Starting any new sprint in CorrData
- Coordinating multiple work streams
```

**2. Gather the Ingredients** - Ensure prerequisites are met:
```markdown
## Ingredients
- [ ] Sprint planning file in docs/sprints/1-todo/
- [ ] Claude Code with slash commands configured
- [ ] Database running
```

**3. Follow the Steps** - Execute in order:
```bash
/sprint-start 106        # Step 1: Initialize
# ... Plan agent runs    # Step 2: Team design
# Answer questions       # Step 3: Clarify
/sprint-next 106         # Step 4+: Implementation
/sprint-complete 106     # Final: Complete
```

**4. Check Learnings** - Avoid known pitfalls:
```markdown
## Anti-Patterns
### Don't: Spawn Agents Without File Ownership
**Why it's bad**: Merge conflicts, race conditions
```

**5. Contribute Back** - If you learn something new, update the recipe!

## Contributing

### Adding a New Recipe

1. Choose the appropriate category (workflow, pattern, integration, playbook)
2. Use the template: `docs/cookbook/_TEMPLATE.md`
3. Include real examples from actual sprints
4. Document learnings and anti-patterns
5. Update this README with the new recipe

### Updating Existing Recipes

1. After each sprint, review relevant recipes
2. Add new learnings to the "Learnings" section
3. Update anti-patterns if you discovered new pitfalls
4. Increment the version if significant changes

## Recipe Index

### Workflows

| Recipe | Description | Version | Last Updated |
|--------|-------------|---------|--------------|
| [VS Code Setup](workflows/vscode-setup.md) | Multi-terminal setup for parallel Claude agents | 1.0 | 2025-12-18 |
| [Sprint Workflow](workflows/sprint-workflow-v2.md) | Parallel agent development, epic/sprint lifecycle | 2.2 | 2025-12-14 |
| [Development Sequence](workflows/development-sequence.md) | Optimal build order for maximum synergy | 1.0 | 2025-12-14 |
| [Database Migrations](workflows/database-migrations.md) | Schema evolution with Alembic | 1.0 | 2025-12-14 |
| [Development Infrastructure](workflows/development-infrastructure.md) | Agents, skills, commands setup | 1.0 | 2025-12-13 |
| [Documentation Approach](workflows/documentation-approach.md) | How we document everything | 1.0 | 2025-12-13 |
| [Postmortem Process](workflows/postmortem-process.md) | Sprint retrospectives & action items | 1.0 | 2025-12-13 |

### Patterns

| Recipe | Description | Version | Last Updated |
|--------|-------------|---------|--------------|
| [Tech Stack Reference](patterns/tech-stack-reference.md) | All libraries, components, and rationale | 1.0 | 2025-12-14 |
| [Three-Layer Database](patterns/three-layer-database.md) | PostgreSQL + TimescaleDB + PostGIS + Neo4j | 1.0 | 2025-12-14 |
| [Provider Pattern](patterns/provider-pattern.md) | External data provider abstraction | 1.0 | 2025-12-14 |
| [GraphQL Schema Design](patterns/graphql-schema.md) | Strawberry types, DataLoaders, N+1 prevention | 1.0 | 2025-12-14 |
| [MCP Tool Registry](patterns/mcp-tool-registry.md) | LLM tool definitions with JSON Schema | 1.0 | 2025-12-14 |
| [Domain Model Layering](patterns/domain-model-layering.md) | SQLAlchemy → Dataclass → Pydantic → Strawberry | 1.0 | 2025-12-14 |
| [Alert Engine](patterns/alert-engine.md) | Rule-based alerting system | 1.0 | 2025-12-14 |
| [Configuration Management](patterns/configuration-management.md) | Environment & settings | 1.0 | 2025-12-14 |

### Integrations

| Recipe | Description | Version | Last Updated |
|--------|-------------|---------|--------------|
| FEMA Flood Zones | NFHL REST API integration | 1.0 | Sprint 112 |
| USGS Seismicity | Earthquake catalog | 1.0 | Sprint 110 |
| InSAR Subsidence | Satellite displacement data | 1.0 | Sprint 111 |

### Cloud

| Recipe | Description | Version | Last Updated |
|--------|-------------|---------|--------------|
| [AWS Infrastructure](cloud/aws-infrastructure.md) | EC2, ECR, Cognito, CloudWatch setup | 1.0 | 2025-12-13 |

### Playbooks

| Recipe | Description | Version | Last Updated |
|--------|-------------|---------|--------------|
| [v0 UI Generation](playbooks/v0-ui-generation.md) | AI-powered React/shadcn/ui component generation | 1.0 | 2025-12-14 |
| [Adding External Data Source](playbooks/adding-external-data-source.md) | Step-by-step external API integration | 1.0 | 2025-12-14 |
| [Onboarding MCP Tool](playbooks/onboarding-mcp-tool.md) | Creating new LLM-accessible tools | 1.0 | 2025-12-14 |
| [Creating REST Endpoint](playbooks/creating-rest-endpoint.md) | When and how to add REST endpoints | 1.0 | 2025-12-14 |
| [Project Execution Lessons](playbooks/project-execution-lessons.md) | Lessons from 119+ sprints | 1.0 | 2025-12-14 |
| [Deployment Setup](playbooks/deployment-setup.md) | Staging & production deployment | 1.0 | 2025-12-13 |

---

## ADR Synthesis

For a complete analysis of all 49 ADRs and their mapping to cookbook recipes, see:
- **[ADR-SYNTHESIS.md](ADR-SYNTHESIS.md)** - Full audit report with priority order
- **Sprint 116** - Systematic recipe creation from ADRs

---

## Maintenance

This cookbook is a **living document**. It should be:
- Updated after every sprint postmortem
- Reviewed quarterly for outdated recipes
- Synced to Mintlify for external sharing
- Cross-referenced with ADRs when adding new recipes

**Owner**: Development Team
**Last Review**: 2025-12-14
**Sprints Covered**: 1-119
