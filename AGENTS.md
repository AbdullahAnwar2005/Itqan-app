# AGENTS.md

This repository is the source code for **Itqan**, an Arabic-first Quran memorization and revision app.

## Primary objective
Build a calm, production-quality Flutter app that helps users:
- memorize new verses
- review previously memorized material
- self-test their recall
- continue for months and years with low friction and strong retention support

## Product identity
Itqan is **not**:
- a generic Quran reader
- a decorative Islamic app
- a noisy gamified productivity app

Itqan **is**:
- a memorization operating system
- Arabic-first and RTL-native
- focused on daily continuity, clarity, and trust

## Read order for the agent
1. `.agent/context/product.md`
2. `.agent/context/architecture.md`
3. `.agent/context/constraints.md`
4. `.agent/context/domain-model.md`
5. `.agent/context/feature-map.md`
6. `.agent/design/README.md`
7. relevant workflow file
8. relevant skill file

## Source-of-truth hierarchy
When guidance conflicts, prefer:
1. explicit user instructions in chat
2. this file
3. `.agent/context/*`
4. `.agent/design/*`
5. `.agent/workflows/*`
6. `.agent/skills/*`

## Non-negotiable rules
- Do not generate code before checking the relevant context files.
- Do not treat exported generic web UI primitives as the product system.
- Do not build feature-grid home screens.
- Do not place business logic inside widgets.
- Do not hardcode colors, spacing, or typography values in product widgets.
- Do not use left/right directional assumptions in RTL-sensitive UI.
- Do not overbuild features outside the approved V1 scope.
- Prefer the smallest correct vertical slice over broad speculative scaffolding.

## Implementation posture
- Flutter-first
- Riverpod-based state management
- modular feature structure
- design-token driven UI
- product components over raw generic primitives
- offline-first friendly architecture
- clean separation between presentation, application/domain rules, and data access

## Expected agent behavior
Before implementing any feature:
- identify the affected feature module
- read the design constraints relevant to it
- identify domain entities and state boundaries
- propose the smallest viable change set
- implement with reusable components
- self-review against RTL, architecture, and design rules
- update decision or current-state files if the change affects project memory