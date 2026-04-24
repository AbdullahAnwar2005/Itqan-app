# Skill — Riverpod Patterns

## Purpose
Use Riverpod in a controlled, predictable way.

## Rules
- Providers should have clear names and clear ownership.
- Presentation providers should not hide data-layer side effects.
- Derived UI state should be computed outside widgets when possible.
- Avoid rebuilding large widget trees unnecessarily.
- Keep async loading/error/content states explicit.

## Prefer
- small focused providers
- feature-local providers where appropriate
- clear distinction between source state and derived state

## Avoid
- over-centralized provider files
- provider spaghetti
- embedding navigation or persistence logic in purely visual widgets