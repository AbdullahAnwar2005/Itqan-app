# RTL Implementation Rules

## Core rule
Itqan is Arabic-first and RTL-native.
RTL is not a later adaptation.

## Layout
- Use directional APIs for padding, margin, alignment, and positioning.
- Avoid hardcoded left/right in product widgets.
- Action placement must be reviewed in RTL contexts.
- Drawers/sheets/dialog close affordances must be checked for RTL appropriateness.

## Icons
- Directional icons must be mirrored intentionally.
- Neutral icons do not need mirroring.
- Do not rely on LTR defaults from starter-kit components.

## Text
- Arabic interface text aligns to the right by default.
- Quran text uses the Quran font and dedicated line-height/spacing.
- Avoid ultra-light weights in Arabic UI.

## Lists and cards
- Leading/trailing structure must be tested in RTL.
- Status badges and action icons must be placed intentionally, not inherited blindly from LTR web components.

## Progress
- Progress direction must be consciously decided for RTL.
- Do not assume a generic LTR progress fill behavior is correct.

## Flutter-specific rules
- Prefer `EdgeInsetsDirectional`.
- Prefer `AlignmentDirectional`.
- Use RTL-aware icon handling where necessary.
- Test every product component in Arabic first, not after English.
