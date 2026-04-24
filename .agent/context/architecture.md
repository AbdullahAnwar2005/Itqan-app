# Architecture

## High-level approach
Use a modular Flutter architecture with clear separation between:
- presentation
- application/domain coordination
- data access
- shared/core infrastructure

## Target module structure
Recommended top-level `lib/` organization:

- `core/`
  - shared infrastructure
  - design system
  - routing
  - localization
  - common utilities
  - common error/result abstractions
- `features/`
  - `today/`
  - `plan/`
  - `session/`
  - `progress/`
  - `library/`
  - `settings/`

## Layer responsibilities

### Presentation
Contains:
- screens
- pages
- view widgets
- feature-specific reusable UI widgets
- Riverpod consumers/providers that are presentation-facing only

Must not:
- talk directly to database clients
- embed memorization business rules
- compute scheduling/review algorithms inline in widgets

### Application / Domain coordination
Contains:
- use-case style services
- orchestration of feature flows
- session state transitions
- plan generation / review scheduling rules
- mapping between repositories and UI-facing states

Must not:
- depend on widget layer
- hardcode UI concerns

### Data
Contains:
- repository implementations
- local data sources
- remote data sources if added later
- DTO / persistence models
- mapping to domain entities

Must not:
- leak persistence details into presentation

## Feature boundaries

### Today
Shows the current operational view:
- today summary
- due tasks
- resume state
- recovery state

### Plan
Defines memorization and revision setup:
- targets
- weekly plan
- pace
- active surah / ranges

### Session
Core execution flow:
- memorize mode
- review mode
- self-test mode
- progress capture
- confidence capture
- interruption-safe state

### Progress
Meaningful progress only:
- consistency
- completion
- review quality
- weak areas
- test trends

### Library
Supportive browsing / reference:
- surahs
- memorized coverage
- status markers
- search/filter if needed

### Settings
Preferences and basic app config

## Dependency direction
Presentation -> application/domain coordination -> repositories -> data sources

Never:
- widget -> DB directly
- widget -> remote client directly
- widget -> scheduling algorithm directly

## Design-system boundary
Design tokens and base components live in `core/design`.
Product-specific widgets live in feature modules or `core/design/product` only if they are truly cross-feature.

## Recommended rule
Build small vertical slices:
- entity/state
- repository contract
- use-case/controller
- screen/widget
- test/review