# V1 Scope and Exclusions

## V1 design-system scope

### Foundation
- color tokens
- semantic status tokens
- typography
- spacing
- radius
- elevation
- app theme
- semantic theme extension

### Base components
- AppButton
- AppCard
- AppBadge
- AppInput
- AppTextarea
- AppSwitch
- AppCheckbox
- AppRadioGroup
- AppProgressBar
- AppTabs / segmented control
- AppDialog
- AppBottomSheet
- AppSnackbar / toast
- AppSkeleton

### Product components
- ItqanTopAppBar
- ItqanBottomNav
- SectionHeader
- TodayPrimaryCard
- MemorizeTaskCard
- ReviewTaskCard
- SelfTestTaskCard
- ProgressSummaryCard
- SurahCard
- ReviewQueueItem
- QuranVerseBlock
- ConfidenceSelector
- AudioControlBar
- RecoveryBanner
- WeeklyPlanItem
- EmptyPlanState
- CompletedTodayState

### V1 screens
- Today
- Plan overview
- Memorize session
- Review session
- Self-test session
- Progress
- Library
- Settings (basic)

## Explicit V1 exclusions
Do not implement these unless a real product need appears:
- breadcrumb
- context menu
- menubar
- navigation menu
- pagination
- resizable panels
- command palette
- hover card
- desktop-style sidebar system
- OTP input unless auth flow requires it
- large data tables unless a real screen depends on them

## Why exclusions exist
The generated export contains generic web-oriented primitives. They are not automatically part of the mobile Flutter MVP.
