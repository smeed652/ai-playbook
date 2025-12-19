---
description: "Abandon one or more sprints (cancelled, won't be completed)"
allowed-tools: [Read, Write, Edit, Bash, Glob]
---

# Abandon Sprint(s)

Mark one or more sprints as abandoned (cancelled, won't be completed). Supports comma-separated sprint numbers for batch abandonment.

**NOTE**: If the sprint is temporarily blocked and will resume later, use `/sprint-blocked` instead.

## Instructions

### 1. Parse Arguments

`$ARGUMENTS` should contain: `<sprint_numbers> <reason>`

Sprint numbers can be:
- A single number: `34`
- Comma-separated list: `34,35,36` (no spaces around commas)

Examples:
- `34 Requirements changed, need to re-plan`
- `36 Feature no longer needed`
- `53,54,55 Epic restructured, these sprints superseded`

If only a reason is provided (no number):
- Use Glob to find all sprint state files: `.claude/sprint-*-state.json`
- If multiple found, ask user which sprint(s) to abandon
- If only one found, use that sprint number
- If none found, report "No active sprint to abandon."

**Parsing logic:**
1. Split `$ARGUMENTS` on first space to get `<sprint_part>` and `<reason>`
2. If `<sprint_part>` contains commas, split on `,` to get list of sprint numbers
3. Validate each number is numeric
4. Process each sprint in order

State file path: `.claude/sprint-{N}-state.json`

### 2. Find Sprint Files (for each sprint)

For each sprint number in the list:

1. **Find the sprint file** (required):
   ```bash
   SPRINT_FILE=$(find docs/sprints -name "sprint-{N}_*.md" -o -name "sprint-{N}*.md" | grep -v "\-\-" | head -1)
   ```

2. **Read state file if it exists** (optional):
   - If `.claude/sprint-{N}-state.json` exists, read it for progress info
   - If no state file, sprint was never started (backlog) - that's fine, still abandon it

If a sprint file doesn't exist:
- Note which sprint(s) don't exist
- Continue with sprints that do exist
- Report missing sprints at the end

### 3. Confirm with User

**For single sprint:**
```
Are you sure you want to ABANDON Sprint N: <title>?

This means the sprint is CANCELLED and won't be completed.
If this is a temporary blocker, use /sprint-blocked instead.

Current progress:
- Phase: X of 6
- Steps completed: Y
- Current step: Z.W

Reason for abandonment: <reason>

Type "yes" to confirm abandonment.
```

**For multiple sprints:**
```
Are you sure you want to ABANDON these sprints?

| Sprint | Title | Phase | Steps Done |
|--------|-------|-------|------------|
| 53 | Shared Core Package | 1 of 6 | 2 |
| 54 | Mobile Auth | 2 of 6 | 5 |
| 55 | Offline Support | 1 of 6 | 1 |

This means ALL listed sprints are CANCELLED and won't be completed.
If these are temporary blockers, use /sprint-blocked instead.

Reason for abandonment: <reason>

Type "yes" to confirm abandonment of ALL sprints above.
```

### 4. Process Each Sprint

**For each sprint in the list, perform steps 4a-4e:**

#### 4a. Calculate Hours Worked

- Read the `started` timestamp from YAML frontmatter
- Current time minus started time = hours (decimal)
- This tracks time invested even for cancelled sprints

#### 4b. Update Sprint File Metadata

Update YAML frontmatter:
```yaml
---
sprint: N
title: <title>
status: abandoned
started: <original timestamp>
abandoned_at: <current ISO 8601 timestamp>
hours: <calculated hours>
abandon_reason: "<reason>"
completed: null
---
```

Update the markdown table (if present):
- Set `| **Status** |` to `Abandoned`
- Add note: "Abandoned on <date>: <reason>"

#### 4c. Move Sprint File to Abandoned Directory

**All abandoned sprints go to `5-abandoned/`** - regardless of whether they were part of an epic. Abandonment is immediate and final.

```bash
# Ensure abandoned directory exists
mkdir -p docs/sprints/5-abandoned

# Find the sprint file (could be anywhere in docs/sprints)
SPRINT_FILE=$(find docs/sprints -name "sprint-{N}_*.md" -o -name "sprint-{N}*.md" | grep -v "\-\-" | head -1)

# Move to abandoned directory with --abandoned suffix
BASENAME=$(basename "$SPRINT_FILE" .md)
mv "$SPRINT_FILE" "docs/sprints/5-abandoned/${BASENAME}--abandoned.md"
```

**Note**: Epic membership doesn't affect abandonment. You can abandon one sprint from an epic without waiting for other sprints.

#### 4d. Update State File

Update `.claude/sprint-{N}-state.json`:

```json
{
  "status": "abandoned",
  "abandoned_at": "<current ISO timestamp>",
  "abandon_reason": "<reason>"
}
```

Keep all other fields intact for audit trail.

#### 4e. Update README

Update `docs/sprints/README.md`:
- Add sprint to the Abandoned section
- Include hours worked and reason

### 5. Report

**For single sprint:**
```
Sprint N: <title> - ABANDONED

Reason: <reason>
Hours invested: <hours>

Progress at abandonment:
- Phase: X of 6
- Steps completed: <count>
- Current step was: <step>

Sprint file moved to: docs/sprints/5-abandoned/<filename>--abandoned.md
State file preserved at .claude/sprint-{N}-state.json for reference.

To start a new sprint: /sprint-start <N>
```

**For multiple sprints:**
```
ABANDONED {count} SPRINTS

Reason: <reason>
Total hours invested: <sum of all hours>

| Sprint | Title | Phase | Hours |
|--------|-------|-------|-------|
| 53 | Shared Core Package | 1/6 | 2.5 |
| 54 | Mobile Auth | 2/6 | 8.0 |
| 55 | Offline Support | 1/6 | 1.0 |

All files moved to: docs/sprints/5-abandoned/
State files preserved at .claude/sprint-{N}-state.json for reference.

To start a new sprint: /sprint-start <N>
```

**If some sprints were not found:**
```
Note: The following sprints were not found and skipped:
- Sprint 56: No sprint file exists
- Sprint 57: No sprint file exists
```

---

## Usage

```
/sprint-abandon <N> <reason>
/sprint-abandon <N1>,<N2>,<N3> <reason>
```

Examples:
```
# Single sprint
/sprint-abandon 34 Requirements changed, need to re-plan
/sprint-abandon 36 Feature no longer needed after customer feedback

# Multiple sprints (comma-separated, no spaces)
/sprint-abandon 53,54,55 Epic restructured, these sprints superseded
/sprint-abandon 37,38 Both sprints replaced by consolidated sprint 39
```
