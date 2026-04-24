# Itqan UI/UX Language

## Purpose
This file defines the intended UI/UX language for Itqan.
It is not a token file and not a theme file.
It is the design intent that must guide:
- theme creation
- component design
- screen composition
- interaction decisions
- product hierarchy

If generated design artifacts conflict with this file, prefer this file.

---

## 1. Product character

Itqan should feel like:
- a calm memorization operating system
- disciplined
- trustworthy
- focused
- supportive
- stable
- respectful

Itqan should **not** feel like:
- a generic Quran reader
- a decorative Islamic app
- a flashy productivity dashboard
- a gamified streak machine
- a social/media product
- a web SaaS app translated into mobile

The user should feel:
- “I know what to do now”
- “the app remembers for me”
- “the app is helping me continue”
- “the interface is calm and reliable”

---

## 2. Core UX posture

The product is built around:
- memorization
- review
- self-test
- continuity over time

The UX must optimize for:
- low cognitive load
- recognition over recall
- long-term repeated use
- clear next action
- respectful recovery after missed days

The app should answer, as quickly as possible:
- What should I do now?
- What is due today?
- Where did I stop?
- Am I on track?

---

## 3. Navigation philosophy

Primary app areas:
1. Today
2. Plan
3. Session
4. Progress
5. Library

Navigation should feel:
- shallow
- obvious
- calm
- mobile-first

Avoid:
- deep nested navigation
- desktop-style menu complexity
- too many secondary branches
- hidden critical actions

The user should not need to “explore the app” to continue memorization work.

---

## 4. Home / Today screen language

The Today screen is the operational center of the app.

Its visual language should communicate:
- immediate clarity
- one dominant next action
- only the most important information
- current memorization/review/test duties
- continuity and progress without noise

The Today screen must **not** become:
- a feature grid
- a dashboard full of metrics
- a menu of unrelated tools
- a decorative landing page

Preferred structure:
- strong top summary or primary card
- one main CTA
- a small number of task cards
- concise progress summary
- recovery banner only when needed

---

## 5. Session language

Session is the most important flow in Itqan.

Session UI must feel:
- focused
- minimal
- uninterrupted
- intentional
- task-first

Quran content must be visually dominant.

Controls such as:
- audio
- hint/reveal
- confidence selection
- chunk navigation

must support the workflow without competing with the text.

Each session mode needs its own feel:

### Memorize mode
Should feel:
- supportive
- guided
- calm
- chunk-based

### Review mode
Should feel:
- efficient
- fluid
- due-aware
- continuity-focused

### Self-test mode
Should feel:
- serious
- low-assistance
- clear
- non-game-like

Session screens should not resemble quiz apps or decorative reading apps.

---

## 6. Visual language

Preferred visual characteristics:
- premium but restrained
- clean surfaces
- generous spacing
- subtle depth
- strong hierarchy
- low-noise composition
- modern but not trendy
- readable Arabic-first layout

Avoid:
- glassmorphism
- aggressive gradients
- excessive shadows
- overly rounded “playful” UI
- ornamental Islamic decoration
- bright celebratory visuals
- too many floating panels

The interface should look mature, composed, and dependable.

---

## 7. Component language

Components should feel:
- simple
- purposeful
- reusable
- semantically meaningful

There are two layers of components:

### Base components
Examples:
- button
- card
- input
- dialog
- bottom sheet
- tabs
- switch
- progress bar

These should stay generic and token-driven.

### Product components
Examples:
- TodayPrimaryCard
- MemorizeTaskCard
- ReviewTaskCard
- SelfTestTaskCard
- QuranVerseBlock
- ConfidenceSelector
- RecoveryBanner
- ProgressSummaryCard
- WeeklyPlanItem

These must carry Itqan semantics and must not be replaced by raw generic components in product screens.

---

## 8. Status and semantic language

The app must visually distinguish:
- memorization
- review
- self-test
- completed
- overdue
- confidence levels

This semantic distinction should be visible in:
- badges
- cards
- banners
- progress elements
- status text
- highlights

But the app must not become color-noisy.
Semantic color should support hierarchy, not dominate it.

---

## 9. Typography language

Typography is central to the product experience.

The interface should feel:
- highly readable
- Arabic-native
- calm
- well spaced

Interface font:
- IBM Plex Sans Arabic

Quran font:
- Amiri Quran

Typography must distinguish clearly between:
- page titles
- section titles
- card titles
- body content
- metadata
- Quran content

Quran content must never feel like normal app body text.

Quran text should feel:
- clear
- dignified
- stable
- comfortable for repeated reading

Avoid:
- cramped verse layout
- decorative backgrounds behind Quran
- weak contrast
- thin interface font weights

---

## 10. Arabic-first and RTL-native behavior

This app is not merely RTL-compatible.
It is Arabic-first and RTL-native.

That means:
- layouts should be conceived in RTL first
- directional spacing must be intentional
- icon direction must be audited
- alignment rules must support Arabic reading rhythm
- hierarchy must feel natural to Arabic users

Do not build LTR-first UI and mirror it at the end.

---

## 11. Motion and feedback language

Motion should feel:
- subtle
- fast
- supportive
- non-theatrical

Use motion to clarify:
- entering/exiting session states
- revealing supporting information
- saving/progress feedback
- opening sheets/dialogs

Avoid:
- bouncy delight animations
- loud celebratory transitions
- playful motion that weakens the product’s seriousness

Feedback should be:
- clear
- calm
- actionable

Success should feel reassuring, not performative.
Errors should explain what happened and what to do next.

---

## 12. Progress language

Progress must feel:
- meaningful
- digestible
- grounded in retention
- not vanity-driven

Good progress content:
- consistency
- completed memorization units
- review completion
- weak areas
- self-test trend

Avoid:
- badge explosions
- pseudo-achievement systems
- metrics with no decision value
- dense analytics dashboards on core screens

---

## 13. Recovery language

Missed days and overdue review are expected realities.

The app should respond with:
- respectful recovery
- supportive copy
- practical re-entry actions
- no guilt framing

The emotional tone should be:
- steady
- supportive
- non-judgmental

---

## 14. Content and copy language

Copy should be:
- direct
- clear
- calm
- supportive
- non-technical

Avoid:
- marketing tone
- dramatic motivational language
- vague labels
- jargon-heavy system wording

Good copy helps the user act immediately.

---

## 15. Explicit anti-patterns

Do not allow the app to drift into any of these:
- feature-grid homepage
- dashboard-first product identity
- generic Quran browser identity
- desktop/web SaaS component language
- visual over-decoration
- over-gamified progress systems
- flashy AI-generated aesthetic
- shallow “beautiful but unclear” layouts

---

## 16. Final principle

The system should always prefer:
- continuity over novelty
- clarity over decoration
- memorization workflow over browsing
- product semantics over generic components
- calmness over stimulation