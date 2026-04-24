# Design Gap Review

## Summary
The generated output is a strong foundation, but not yet a full Itqan product design system.

## What the generated output did well
- semantic token foundation
- Arabic and Quran typography direction
- UX principles
- RTL principles
- many reusable generic primitives
- initial Flutter handoff guidance

## Main gaps

### Gap 1 — Product components missing
Missing or not truly implemented:
- progress card
- session card
- surah card
- review queue item
- verse block
- audio control bar
- confidence selector
- hint/reveal panel
- weekly plan item

### Gap 2 — Core screens not truly built
The brief asked for real core screens, but the output mainly delivered documentation and generic component pages.

### Gap 3 — Hard usage rules missing
The principles exist, but the system lacks a strict implementation rulebook.

### Gap 4 — Semantic component APIs missing
Tokens know about memorize/review/self-test and confidence states, but most components expose only generic variants.

### Gap 5 — Quran interaction system missing
Typography exists, but the actual verse display and interaction system is not fully specified.

### Gap 6 — Session mode system incomplete
Memorize, Review, and Self-Test are defined conceptually, but not as a complete UI sub-system.

### Gap 7 — State matrix missing
There is no single source of truth for product component states such as overdue, recovery, completed today, and no plan yet.

### Gap 8 — RTL-native enforcement incomplete
RTL guidance exists, but many exported primitives still reflect LTR web defaults.

### Gap 9 — Dark mode parity missing
Dark mode is not yet product-semantic and should not be treated as production-ready.

### Gap 10 — Too much generic baggage
The export includes many generic web/desktop components that should not be translated directly into Flutter V1.

## Resolution strategy
Close the gaps by:
1. keeping the good foundation
2. defining product components explicitly
3. defining hard rules
4. implementing a Flutter token/theme layer
5. building only approved V1 product components
