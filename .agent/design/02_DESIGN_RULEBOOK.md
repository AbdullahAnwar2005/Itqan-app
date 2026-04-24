# Design Rulebook

## Global rules
- Never hardcode colors in product widgets. Use tokens only.
- Never hardcode left/right layout values in direction-sensitive UI. Use directional APIs.
- Never use generic starter-kit defaults if they conflict with Itqan semantics.
- Prefer reusable product components over ad hoc widget composition.
- Keep all primary screens visually calm and task-oriented.

## Home / Today rules
- Home must not be a feature grid.
- Home must have one visually dominant primary CTA.
- Above the fold, show only the most relevant tasks and status.
- Review tasks must not be visually weaker than memorization tasks.
- Progress on Home must be summary-first, not dashboard-first.

## Session rules
- Session is the most important flow in the app.
- Session UI must minimize distractions.
- Session screen must use a mode-specific header.
- Quran content must visually dominate assistance controls.
- Secondary controls such as reveal, hints, and audio must remain secondary in hierarchy.
- Progress must be visible but not noisy.

## Quran content rules
- Quran text must use the dedicated Quran font.
- Quran text must never reuse ordinary body text styles.
- Quran text must not sit on decorative or noisy backgrounds.
- Quran text spacing must prioritize readability over density.
- Ayah display and verse grouping must remain visually stable across modes.

## Review rules
- Review is equal in importance to memorization.
- Review due or overdue states must be clearly visible.
- Recovery after missed days must be supportive, not guilt-driven.
- Never shame the user for missed reviews.

## Progress rules
- Show meaningful progress only.
- Avoid vanity metrics.
- Keep progress UI digestible and low-density.
- Use charts only when they add decision value.

## Component rules
- Do not place raw generic `AppCard` in product screens when a product card exists.
- Do not use generic badge variants where semantic mode/state badges exist.
- Use one semantic source of truth for status colors across cards, chips, alerts, and banners.

## Feedback rules
- Success feedback should be calm and lightweight.
- Errors must be actionable.
- Empty states must always offer a clear next step.
- Loading states must preserve layout stability.

## Dark mode
- Dark mode is not considered production-ready until semantic dark tokens are intentionally defined.
- If dark mode is not explicitly implemented, ship light mode only for V1.
