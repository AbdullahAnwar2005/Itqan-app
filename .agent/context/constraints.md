# Constraints

## Product constraints
- Itqan is not a generic Quran reader.
- Itqan is not a dashboard-first app.
- Review must be treated as equal in importance to memorization.
- Session mode is the product core.

## UX constraints
- Home must not be a feature grid.
- One dominant CTA per main screen.
- Avoid noisy or celebratory gamification patterns.
- Recovery after missed days must be supportive.

## Design constraints
- Use design tokens only.
- Use named typography roles only.
- Quran text must use dedicated Quran styles.
- Do not invent new colors or radii per widget.

## Architecture constraints
- No business logic inside widgets.
- No direct database/client access from presentation widgets.
- Keep feature boundaries explicit.
- Reuse product widgets before creating new UI patterns.

## RTL constraints
- Use directional APIs.
- No implicit LTR assumptions in product components.
- Audit icon direction intentionally.

## Scope constraints
- V1 excludes generic web-heavy components unless a real mobile product need appears.
- Do not implement speculative systems not justified by current feature scope.

## Agent constraints
- Read context before generating code.
- Prefer minimal viable implementation.
- Update project memory files when decisions or state materially change.