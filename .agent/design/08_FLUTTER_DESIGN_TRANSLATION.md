# Flutter Design Translation

## Goal
Translate the design foundations into a Flutter design system without carrying over unnecessary web-starter-kit baggage.

## Layer 1 — Tokens
Create:
- `app_colors.dart`
- `app_spacing.dart`
- `app_radius.dart`
- `app_elevation.dart`
- `app_typography.dart`

Also create:
- `itqan_theme_extension.dart`
for product semantics such as:
- memorizeActive
- reviewDue
- selfTest
- completed
- overdue
- confidenceHigh
- confidenceMedium
- confidenceLow

## Layer 2 — Theme
Create:
- `app_theme.dart`
- `app_input_theme.dart`
- `app_card_theme.dart`
- `app_appbar_theme.dart`
- `app_dialog_theme.dart`
- `app_bottom_nav_theme.dart`

## Layer 3 — Base components
Create:
- `AppButton`
- `AppCard`
- `AppBadge`
- `AppInput`
- `AppTextarea`
- `AppSwitch`
- `AppCheckbox`
- `AppRadioGroup`
- `AppProgressBar`
- `AppTabs`
- `AppDialog`
- `AppBottomSheet`
- `AppToast`
- `AppSkeleton`

## Layer 4 — Product components
Create:
- `ItqanTopAppBar`
- `ItqanBottomNav`
- `SectionHeader`
- `TodayPrimaryCard`
- `MemorizeTaskCard`
- `ReviewTaskCard`
- `SelfTestTaskCard`
- `ProgressSummaryCard`
- `SurahCard`
- `ReviewQueueItem`
- `QuranVerseBlock`
- `AudioControlBar`
- `ConfidenceSelector`
- `RecoveryBanner`
- `WeeklyPlanItem`

## Build order
1. Tokens
2. Theme
3. Base components
4. Product components
5. Screen composition

## Important warning
Do not start by translating every exported generic component from the generated files.
Translate only the pieces that serve the approved V1 mobile product.
