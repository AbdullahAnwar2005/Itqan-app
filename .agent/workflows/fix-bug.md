---
description: fix-bug
---

# Workflow — Fix Bug

## Goal
Fix the root cause with the smallest safe change.

## Steps
1. Identify the exact symptom.
2. Identify reproduction path.
3. Determine the layer:
   - presentation
   - state/provider
   - domain coordination
   - repository
   - data source
4. Confirm the root cause before patching.
5. Patch the narrowest correct layer.
6. Review for regressions in:
   - RTL
   - design consistency
   - provider rebuild behavior
   - persistence flow
7. Update `current-state.md` if the bug meaningfully affects project status.
8. Update `decisions.md` only if the fix changes a long-term rule.

## Do not
- patch symptoms in the widget layer when the issue is deeper
- mix refactors with the bug fix unless necessary