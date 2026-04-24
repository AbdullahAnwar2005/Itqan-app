# Skill — Offline-First Patterns

## Purpose
Keep the app usable without fragile backend assumptions.

## Rules
- Local persistence should be the primary fallback for important user progress.
- Repositories should hide local/remote origin details.
- UI should not depend on immediate network success to remain coherent.
- Sync should be layered in later, not assumed everywhere now.

## Avoid
- making core session flows network-dependent by accident
- leaking sync concerns into every widget