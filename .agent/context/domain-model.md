# Domain Model

## Purpose
Define stable vocabulary so the agent does not invent inconsistent product concepts.

## Core entities

### Surah
Represents a surah reference.
Fields may include:
- id
- arabicName
- order
- verseCount

### AyahRange
Represents a verse span within a surah.
Fields may include:
- surahId
- startAyah
- endAyah

### SessionMode
Enum:
- memorize
- review
- selfTest

### ConfidenceLevel
Enum:
- high
- medium
- low

### TaskStatus
Enum candidates:
- upcoming
- due
- overdue
- active
- completed
- paused
- needsMoreWork

### MemorizationTask
Represents a new memorization unit.
Fields may include:
- id
- range
- estimatedDuration
- status
- confidence
- repetitionTarget

### ReviewTask
Represents a review unit.
Fields may include:
- id
- range
- dueDate
- lastReviewedAt
- urgency
- status

### SelfTestTask
Represents a self-test unit.
Fields may include:
- id
- range
- lastScore
- status

### DailyPlan
Represents what the user should do today.
Fields may include:
- date
- memorizeTasks
- reviewTasks
- selfTestTasks
- summary

### Session
Represents an active or completed work session.
Fields may include:
- id
- mode
- taskId or task reference
- startedAt
- endedAt
- progress
- confidenceResult
- notes or mistake markers

### ProgressSnapshot
Represents summarized progress.
Fields may include:
- consistency
- memorizedUnits
- reviewCompletionRate
- weakAreas
- selfTestTrend

### ReviewUrgency
Enum candidates:
- normal
- dueSoon
- due
- overdue

## Rule
All feature code should reuse this vocabulary unless a deliberate decision is recorded in `decisions.md`.