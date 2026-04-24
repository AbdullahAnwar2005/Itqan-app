# Session Modes Spec

## Overview
Session mode is the core workflow of Itqan.
There are three distinct modes:
- Memorize
- Review
- Self-Test

The system must not pretend these are the same interaction with different labels.

---

## Memorize Mode
Purpose:
- learn and stabilize new material

Must support:
- small chunks
- repetition
- audio assistance
- confidence marking
- mark as stable / needs more work

Primary UI elements:
- SessionHeader
- QuranVerseBlock
- AudioControlBar
- ConfidenceSelector
- chunk progress
- next chunk action

Visual tone:
- supportive
- focused
- calm
- semantic memorization state color allowed

---

## Review Mode
Purpose:
- strengthen retention on previously memorized content

Must support:
- fast flow
- easy continuation
- clear due/overdue status
- low-friction mistake marking
- checkpoints

Primary UI elements:
- SessionHeader
- QuranVerseBlock
- review status indicator
- quick mark controls
- progress / queue visibility

Visual tone:
- efficient
- trustworthy
- not punitive

---

## Self-Test Mode
Purpose:
- assess recall quality with reduced assistance

Must support:
- minimal assistance
- delayed hints
- reveal controls
- result/confidence capture

Primary UI elements:
- SessionHeader
- QuranVerseBlock with hidden/reveal behavior
- hint / reveal panel
- confidence capture
- result summary

Visual tone:
- focused
- clear
- not game-like
- no flashy quiz aesthetics

---

## Shared session rules
- Quran content is visually dominant
- there is always clear system status
- there is always a clear next step
- progress is visible but low-noise
- leaving session should be intentional
- session mode UI should feel isolated from general browsing
