# Design Foundation

## Accepted source material from the generated design
Use these as the trusted foundation:
- semantic color tokens
- Arabic/Quran typography direction
- spacing, radius, elevation scales
- UX principles
- RTL principles
- basic input/dialog/sheet/progress/tab primitives

Ignore the fact that the exported component set includes many web-heavy generic primitives. Those are not automatically part of the Flutter MVP.

## Core design principles
- Today-first experience
- One dominant next action per primary screen
- Recognition over recall
- Progressive disclosure
- Review is first-class, not secondary
- Respectful recovery after missed days
- Clear system status
- Arabic-first readability
- Calm, low-friction interaction
- Long-term usability over visual novelty

## Visual direction
Prefer:
- strong hierarchy
- generous spacing
- clean surfaces
- restrained color usage
- subtle depth
- readable Arabic typography
- stable component rhythm

Avoid:
- glassmorphism
- flashy gradients
- ornamental Islamic motifs
- overloaded dashboards
- too many floating cards
- AI-looking generic UI

## Color semantics
Keep these semantic roles:
- surfacePrimary
- surfaceSecondary
- surfaceTertiary
- surfaceElevated
- textPrimary
- textSecondary
- textTertiary
- actionPrimary
- actionSecondary
- success
- warning
- error
- memorizeActive
- reviewDue
- selfTest
- completed
- overdue
- confidenceHigh
- confidenceMedium
- confidenceLow
- borderSubtle
- borderMedium
- borderStrong
- focusRing

## Typography roles
Use named roles, not HTML heading assumptions:
- display
- pageTitle
- sectionTitle
- cardTitle
- bodyLarge
- body
- bodySmall
- label
- caption
- quranLarge
- quranMedium

## Fonts
- Interface font: IBM Plex Sans Arabic
- Quran font: Amiri Quran

## Important note
The original generated files provide a strong foundation but not a complete Itqan product system.
The agent must build the missing product layer intentionally.
