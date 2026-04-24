---
description: Implement Feature
---

# Workflow — Implement Feature

## Goal
Implement a feature cleanly, within architecture and design constraints.

## Steps
1. Read:
   - `AGENTS.md`
   - relevant files in `.agent/context/`
   - relevant design files
2. Identify:
   - target feature module
   - domain entities involved
   - existing reusable components
3. Define the smallest viable vertical slice.
4. Propose file changes before broad implementation.
5. Implement in this order:
   - data/model contracts if needed
   - coordination/domain logic
   - presentation state
   - reusable UI
   - screen composition
6. Review against:
   - architecture constraints
   - design rules
   - RTL rules
   - scope boundaries
7. Update `current-state.md` if project state changed.
8. Update `decisions.md` if a real design or architecture decision was made.

## Do not
- build entire future systems speculatively
- skip context reading
- duplicate UI patterns that already exist in the product layer