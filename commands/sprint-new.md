---
description: "Create a new sprint planning file from template"
allowed-tools: [Read, Write, Glob, Bash]
---

# Create Sprint $ARGUMENTS

Create a new sprint planning file for Sprint **$ARGUMENTS**.

## Instructions

### 1. Determine Sprint Number, Title, and Epic

Parse $ARGUMENTS:
- If empty or just a title (no number), **auto-assign** from counter file
- If just a number (e.g., "5"), prompt user for title
- If "5 Feature Name", use "5" as number and "Feature Name" as title
- If includes "--epic=N", extract epic number N and remove from title
- Example: "53 Photo Capture --epic=3" → Sprint 53, Title "Photo Capture", Epic 3
- Example: "New Feature --epic=13" → Auto-assign next number, Title "New Feature", Epic 13

Epic is optional - sprints can exist without an epic.

### 2. Get Next Sprint Number (if auto-assigning)

If no sprint number was provided in $ARGUMENTS:

```bash
# Read counter file
cat docs/sprints/next-sprint.txt
```

Use that number as the sprint number.

### 3. Validate Sprint Number

Use Glob to check ALL sprint directories for existing sprints:
```bash
find docs/sprints -name "sprint-{N}_*.md" -o -name "sprint-{N}*.md" 2>/dev/null
```

**If sprint number already exists:**
```
ERROR: Sprint {N} already exists at: {path}

Use a different sprint number, or use /sprint-new without a number to auto-assign.
Current next available: {counter value}
```

### 4. Create Sprint Directory (if needed)

Determine the target directory:
- If `--epic=N` specified: `docs/sprints/1-todo/epic-{N}_*/` (find existing epic folder)
- If epic folder doesn't exist, create it or warn
- If no epic: `docs/sprints/1-todo/`

```bash
mkdir -p docs/sprints/1-todo
```

### 5. Create Sprint File

Create `docs/sprints/1-todo/{epic-folder}/sprint-{N}_{slug}.md` where:
- `{N}` is the sprint number (no zero-padding for numbers > 99)
- `{slug}` is lowercase, hyphenated title (e.g., "user-authentication")

Use this template:

```markdown
---
sprint: {N}
title: "{Title}"
status: todo
epic: {Epic number or null}
created: {TODAY YYYY-MM-DD}
---

# Sprint {N}: {Title}

## Overview

| Field | Value |
|-------|-------|
| Sprint | {N} |
| Title | {Title} |
| Epic | {Epic number or "None"} |
| Status | Todo |
| Created | {TODAY} |

## Goal

{One sentence describing what this sprint accomplishes}

## Background

{Why is this needed? What problem does it solve?}

## Requirements

### Functional Requirements

- [ ] {Requirement 1}
- [ ] {Requirement 2}
- [ ] {Requirement 3}

### Non-Functional Requirements

- [ ] {Performance, security, or other constraints}

## Dependencies

- **Sprints**: {List any sprints that must be completed first, or "None"}
- **External**: {External dependencies like APIs, libraries, etc.}

## Scope

### In Scope

- {What's included}

### Out of Scope

- {What's explicitly NOT included}

## Technical Approach

{High-level description of how this will be implemented}

## Tasks

### Phase 1: Planning
- [ ] Review requirements with stakeholder
- [ ] Design code architecture
- [ ] Clarify any ambiguous requirements

### Phase 2: Implementation
- [ ] Write tests
- [ ] Implement feature
- [ ] Fix any test failures

### Phase 3: Validation
- [ ] Verify migrations (if applicable)
- [ ] Quality review
- [ ] Refactoring

### Phase 4: Documentation
- [ ] Create dialog example (if applicable)
- [ ] Update relevant docs

## Acceptance Criteria

- [ ] {Criterion 1 - how do we know this is done?}
- [ ] {Criterion 2}
- [ ] All tests passing
- [ ] Code reviewed and refactored

## Open Questions

- {Any questions that need answers before or during implementation}

## Notes

{Any additional context, links, references}
```

### 6. Update Counter File

**IMPORTANT**: After successfully creating the sprint file, increment the counter:

```bash
# Calculate next number
NEXT=$((SPRINT_NUMBER + 1))

# Update counter file
echo "$NEXT" > docs/sprints/next-sprint.txt
```

### 7. Update Epic File (if epic specified)

If --epic=N was provided:
1. Find the epic file: `docs/epics/epic-{NN}_*.md`
2. Add a new row to the Sprints table:
   ```
   | {Sprint} | {Title} | planned |
   ```
3. If epic file not found, warn user but still create sprint

### 8. Report

Output:
```
Created: docs/sprints/1-todo/{epic-folder}/sprint-{N}_{slug}.md
Sprint Number: {N}
Epic: {Epic number and title, or "None (standalone sprint)"}
Next available sprint: {new counter value}

Next steps:
1. Fill in the sprint details (Goal, Requirements, etc.)
2. Run /sprint-start {N} when ready to begin
```
