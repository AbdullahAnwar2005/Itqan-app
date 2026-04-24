# Current State

## Status
- Stage: Increment 1 complete — User Setup Foundation implemented
- Focus: user setup flow, simple local persistence, app launch decision.
- Code generation status: setup flow complete, routing handles the onboarding check.

## What is implemented
- V0 foundation (tokens, app theme, app shell, RTL logic)
- `lib/features/setup/` (Increment 1)
  - `domain`: `UserSetup` entity + `MemorizationIntensity` enum.
  - `data`: `UserSetupLocalSource` (SharedPreferences) + `UserSetupRepository`.
  - `application`: `isSetupCompleteProvider` + `setupControllerProvider`.
  - `presentation`: `SetupScreen` (3-step minimal form).
- `lib/core/routing/app_router.dart` — redirect logic based on `isSetupCompleteProvider`.

## Current priority
Proceed with specific feature development:
1. Today screen — real content (TodayPrimaryCard, task list)
2. Plan feature skeleton
3. Session feature (core product flow)

## Known risks
- Icons in ItqanBottomNav are Material Icons placeholders — should be replaced with design-aligned icons.
- Session tab in BottomNav tab order needs IA review when session feature is designed.
- Stub screens exist for Plan/Session/Progress/Library — must be removed/replaced per feature.

## Blocking issues
- none

## Notes for future agent runs
- V1 is light mode only — do not add dark mode without a proper semantic dark token decision.
- All token usage must go through the token files; no per-widget hardcoded values.
- ItqanThemeExtension.light is the source of product semantic colors.
- RTL is declared via locale; do not force Directionality manually.
- Use `SharedPreferences` only for simple state (like `UserSetup`), use SQLite/Drift if relational persistence becomes necessary later.