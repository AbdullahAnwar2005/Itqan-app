# Decisions Log

Use this file as a lightweight ADR log.

## Template
### [Decision title]
- Date:
- Status: proposed | accepted | deprecated
- Context:
- Decision:
- Alternatives considered:
- Why this was chosen:
- Consequences:

---

### [Architecture style for Itqan]
- Date: YYYY-MM-DD
- Status: accepted
- Context: Need a structure that supports feature growth, design-system reuse, and clear business-logic boundaries.
- Decision: Use modular Flutter architecture with feature folders and clear separation between presentation, coordination/domain logic, and data access.
- Alternatives considered: flat folder structure, widget-first only organization
- Why this was chosen: reduces drift and keeps the agent aligned with stable boundaries.
- Consequences: more initial structure, better long-term maintainability.

### [Arabic-first and RTL-native from the start]
- Date: YYYY-MM-DD
- Status: accepted
- Context: Product is designed primarily for Arabic-speaking users and Quran memorization workflows.
- Decision: Implement Arabic-first and RTL-native behavior as a first-order rule, not a later adaptation.
- Alternatives considered: bilingual-neutral start
- Why this was chosen: avoids deep UI drift and wrong layout assumptions.
- Consequences: stricter component and layout rules.

### [Design system approach]
- Date: YYYY-MM-DD
- Status: accepted
- Context: Generated design output contains strong foundations but also many generic web primitives.
- Decision: Keep the good foundations, ignore unnecessary generic baggage, and build Itqan-specific product components on top of base Flutter components.
- Alternatives considered: direct one-to-one translation of generated files
- Why this was chosen: direct translation would import irrelevant complexity and weak product semantics.
- Consequences: requires product component specification before broad UI implementation.

---

### [V1 ships light mode only]
- Date: 2026-04-19
- Status: accepted
- Context: The generated dark mode tokens are not considered fully product-ready per design spec § 12.
- Decision: V1 ships light mode only. `AppTheme.light` is the single ThemeData. `themeMode` is not set.
- Alternatives considered: implement both modes from the start
- Why this was chosen: prevents premature dark-mode work before semantic dark tokens are defined; avoids half-baked dark UI.
- Consequences: dark mode requires a new decision entry and a proper semantic dark token set before implementation.

---

### [RTL enabled via locale, not forced Directionality]
- Date: 2026-04-19
- Status: accepted
- Context: RTL must be first-order, not an afterthought.
- Decision: Declare `locale: const Locale('ar')` in `MaterialApp.router` with `GlobalWidgetsLocalizations.delegate`. Flutter sets RTL automatically. Do not force `Directionality` manually at the app level.
- Alternatives considered: wrapping root with explicit `Directionality(textDirection: TextDirection.rtl)`
- Why this was chosen: locale-driven RTL is the correct Flutter pattern; it also ensures system widgets (dialogs, pickers, etc.) get correct directionality.
- Consequences: all new widgets must be tested with AR locale active, not by checking textDirection directly.

---

### [UserSetup Local Persistence via SharedPreferences]
- Date: 2026-04-19
- Status: accepted
- Context: Need to persist the user's initial setup details (capacities, intensity preference) to drive app launch flow.
- Decision: Use `SharedPreferences` for `UserSetup` persistence, hidden behind a clean `UserSetupRepository`.
- Alternatives considered: Hive, Isar, SQLite/Drift.
- Why this was chosen: The setup data is small, flat, key-value preference state. A full local database is overkill at this phase. The repository boundary ensures `SharedPreferences` can be swapped out easily later if needed.
- Consequences: Setup check at app launch can be synchronous. If complex/relational entities are added later (e.g. tracking specific ayahs), a dedicated DB (like Drift) will be needed for those entities instead of SharedPreferences.