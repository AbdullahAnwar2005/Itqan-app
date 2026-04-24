# Screen Architecture

## 1. Today
Goal:
- answer what the user should do now

Composition:
- ItqanTopAppBar
- TodayPrimaryCard
- RecoveryBanner if needed
- MemorizeTaskCard / ReviewTaskCard / SelfTestTaskCard
- ProgressSummaryCard optional compact version
- ItqanBottomNav

Primary CTA:
- Start Today's Session

Do not:
- use feature grid
- show dense dashboards
- show many competing actions

## 2. Plan
Goal:
- configure and understand the memorization system

Composition:
- ItqanTopAppBar
- plan summary section
- WeeklyPlanItem list
- active surah / targets
- pace adjustment controls
- recovery logic summary if relevant

## 3. Session
Goal:
- execute the current work with maximum clarity

Composition:
- SessionHeader
- QuranVerseBlock
- mode-specific controls
- AudioControlBar as needed
- ConfidenceSelector as needed
- progress and chunk controls
- exit/save behavior

## 4. Progress
Goal:
- show meaningful, decision-supportive progress

Composition:
- ItqanTopAppBar
- ProgressSummaryCard
- selected charts only if useful
- weak areas summary
- retention/test trend
- no noisy dashboard layout

## 5. Library
Goal:
- support browsing and reference, not dominate the product

Composition:
- ItqanTopAppBar
- search/filter if needed
- SurahCard list
- status markers
- quick actions only if useful

## 6. Settings
Goal:
- manage preferences simply

Composition:
- top app bar
- language
- appearance if supported
- notifications
- recitation/audio preferences
- app/about
