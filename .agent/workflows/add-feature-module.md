---
description: add-feature
---

# Workflow — Add Feature Module

## Goal
Create a new feature module without breaking consistency.

## Steps
1. Confirm the feature is approved by product scope.
2. Add entry to `feature-map.md`.
3. Define domain vocabulary in `domain-model.md` if needed.
4. Create the feature folder under `lib/features/`.
5. Add only necessary subfolders.
6. Reuse base and product components where possible.
7. Keep routing, providers, and repositories explicit.
8. Update `current-state.md`.

## Rule
Do not create feature modules that exist only as speculative placeholders.