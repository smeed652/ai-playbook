---
description: "Create a new epic to group related sprints"
allowed-tools: [Read, Write, Glob, Bash]
---

# Create Epic: $ARGUMENTS

Create a new epic file for organizing related sprints.

## Instructions

### 1. Parse Arguments

Parse $ARGUMENTS:
- If just a title (e.g., "Mobile Field Application"), auto-assign epic number
- If "{N} Title" (e.g., "14 Mobile Field Application"), use N as epic number
- If no title provided, ask the user for one

### 2. Get Next Epic Number (if auto-assigning)

If no epic number was provided in $ARGUMENTS:

```bash
# Read counter file
cat docs/epics/next-epic.txt
```

Use that number as the epic number.

### 3. Validate Epic Number

Check if epic number already exists:
```bash
find docs -name "epic-{N}_*" -type d 2>/dev/null
ls docs/epics/epic-{N}_*.md 2>/dev/null
```

**If epic number already exists:**
```
ERROR: Epic {N} already exists at: {path}

Use a different epic number, or use /epic-new without a number to auto-assign.
Current next available: {counter value}
```

### 4. Create Slug

Convert title to slug:
- Lowercase
- Replace spaces with hyphens
- Remove special characters
- Example: "Mobile Field Application" → "mobile-field-application"

### 5. Create Epic Directory Structure

Create the sprint folder for this epic:
```bash
mkdir -p docs/sprints/1-todo/epic-{N}_{slug}
```

### 6. Create Epic File

Create `docs/epics/epic-{N}_{slug}.md` using this template:

```markdown
---
epic: {N}
title: "{Title}"
status: planning
created: {TODAY YYYY-MM-DD}
---

# Epic {N}: {Title}

## Overview

{To be filled in - describe the strategic initiative}

## Success Criteria

- [ ] {Define measurable outcomes}

## Sprints

| Sprint | Title | Status |
|--------|-------|--------|
| -- | TBD | planned |

## Backlog

- [ ] {Add unassigned tasks}

## Notes

Created: {TODAY}
```

### 7. Update Counter File

**IMPORTANT**: After successfully creating the epic, increment the counter:

```bash
# Calculate next number
NEXT=$((EPIC_NUMBER + 1))

# Update counter file
echo "$NEXT" > docs/epics/next-epic.txt
```

### 8. Report

Output:
```
Created: docs/epics/epic-{N}_{slug}.md
Epic Number: {N}
Sprint folder: docs/sprints/1-todo/epic-{N}_{slug}/
Next available epic: {new counter value}

Next steps:
1. Fill in the Overview and Success Criteria
2. Use /sprint-new "<title>" --epic={N} to create sprints for this epic
```
