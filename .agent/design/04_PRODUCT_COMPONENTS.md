# Itqan Product Components

## 1. ItqanTopAppBar
Purpose: top-level screen header for mobile
Used in: Today, Plan, Progress, Library, Settings
Variants:
- standard
- large title
- session mode
Rules:
- must be RTL-aware
- action placement must follow directional rules
- session mode can use semantic mode color treatment

## 2. ItqanBottomNav
Purpose: primary navigation across app areas
Items:
- Today
- Plan
- Session (only if retained in IA)
- Progress
- Library
Rules:
- must remain simple
- labels in Arabic
- no more than final approved IA items

## 3. SectionHeader
Purpose: reusable header for content sections
Data:
- title
- subtitle optional
- trailing action optional
Rules:
- title hierarchy must be clear
- trailing action secondary only

## 4. TodayPrimaryCard
Purpose: main card on the Today screen that answers “what should I do now?”
Data:
- main action label
- due summary
- resume context if available
- primary CTA
States:
- default
- no plan
- completed today
- overdue recovery

## 5. MemorizeTaskCard
Purpose: represent a new memorization task
Data:
- surah
- verse range
- estimated time
- progress
- status
States:
- default
- active
- completed
- needs more work

## 6. ReviewTaskCard
Purpose: represent a review task
Data:
- surah
- verse range
- last review age
- urgency
- estimated effort
States:
- due
- overdue
- completed
Rule:
- visual priority must not be weaker than memorization

## 7. SelfTestTaskCard
Purpose: represent a self-test task
Data:
- surah
- verse range
- last score optional
- confidence optional
States:
- ready
- in progress
- completed

## 8. ProgressSummaryCard
Purpose: compact summary of meaningful progress
Metrics allowed:
- consistency
- memorized units
- review completion
- test trend
Avoid:
- vanity counters

## 9. SurahCard
Purpose: browse or reference surah-related information in the Library or plan flow
Data:
- surah name
- memorized coverage
- review status
- quick action optional

## 10. ReviewQueueItem
Purpose: compact row item inside review lists/queues
Data:
- surah
- verse range
- due status
- last reviewed
- action affordance

## 11. QuranVerseBlock
Purpose: display Quran content in sessions
Modes:
- memorize
- review
- self-test
States:
- default
- focused
- hint revealed
- hidden assistance
Rules:
- use Quran font
- stable spacing
- no decorative background
- strong contrast only

## 12. AudioControlBar
Purpose: control recitation or playback support
Controls may include:
- play / pause
- replay
- speed optional
- loop optional
Rule:
- must remain secondary to Quran content

## 13. ConfidenceSelector
Purpose: capture learner confidence after work on a chunk
Values:
- high
- medium
- low
Rules:
- very low friction
- semantic color mapping only

## 14. RecoveryBanner
Purpose: supportive re-entry after missed days
Data:
- missed review count or days
- supportive message
- CTA
Rule:
- no guilt language

## 15. WeeklyPlanItem
Purpose: represent part of the weekly plan
Data:
- day label
- memorization goal
- review goal
- state
States:
- upcoming
- due
- completed
- adjusted

## 16. EmptyPlanState
Purpose: prompt the user to create a plan
Must include:
- clear explanation
- one primary CTA

## 17. CompletedTodayState
Purpose: calm end-of-day success state
Must include:
- completion message
- low-noise next action
