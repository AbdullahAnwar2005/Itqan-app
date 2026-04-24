# Skill — Flutter Feature Implementation

## Purpose
Build Flutter features in a stable, modular way.

## Rules
- Put feature code under `lib/features/<feature>/`.
- Keep screens thin.
- Extract reusable feature widgets before screens become crowded.
- Keep business logic out of UI widgets.
- Prefer explicit models and view states over loosely structured maps.
- Reuse design tokens and product widgets.

## Recommended feature shape
- screen/page
- widgets
- providers/controllers
- domain/application services if needed
- repository contracts or usage points

## Avoid
- giant screen files
- raw styling scattered across feature widgets
- direct persistence calls from UI