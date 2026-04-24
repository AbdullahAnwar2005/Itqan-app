# Exact Design Spec

## Purpose
This file contains the exact numerical design values extracted from the generated design artifacts.
Use this file as the implementation spec for Flutter theme tokens and base components.

If this file conflicts with generic starter-kit component defaults, prefer this file.

---

## 1. Font families

### Interface font
- Primary interface font: `IBM Plex Sans Arabic`
- CSS source defined as:
  - `'IBM Plex Sans Arabic', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif`

### Quran font
- Quran font: `Amiri Quran`
- CSS source defined as:
  - `'Amiri Quran', 'Traditional Arabic', serif`

Implementation rule:
- Use `IBM Plex Sans Arabic` for app UI
- Use `Amiri Quran` only for Quran text display

---

## 2. Base font size
- Base font size: `16px`

---

## 3. Color tokens

## Surface colors
- `surfacePrimary = #FFFFFF`
- `surfaceSecondary = #F8F9FA`
- `surfaceTertiary = #F1F3F5`
- `surfaceElevated = #FFFFFF`
- `surfaceOverlay = rgba(0, 0, 0, 0.6)`

## Text colors
- `textPrimary = #1A1D1F`
- `textSecondary = #6C727A`
- `textTertiary = #9BA1A8`
- `textDisabled = #C4C8CC`
- `textInverse = #FFFFFF`

## Action colors
- `actionPrimary = #2B5F44`
- `actionPrimaryHover = #234A36`
- `actionPrimaryPressed = #1A3628`
- `actionSecondary = #E8F3ED`
- `actionSecondaryHover = #D4E8DD`
- `actionSecondaryPressed = #C0DDD0`

## Semantic colors
- `success = #2B7A4B`
- `successSurface = #E8F5EE`
- `warning = #C77700`
- `warningSurface = #FFF4E5`
- `error = #C92A2A`
- `errorSurface = #FFE8E8`

## Product status colors
- `memorizeActive = #2B5F44`
- `memorizeSurface = #E8F3ED`
- `reviewDue = #C77700`
- `reviewSurface = #FFF4E5`
- `selfTest = #5F3DC4`
- `selfTestSurface = #F3F0FF`
- `completed = #2B7A4B`
- `completedSurface = #E8F5EE`
- `overdue = #C92A2A`
- `overdueSurface = #FFE8E8`

## Confidence colors
- `confidenceHigh = #2B7A4B`
- `confidenceMedium = #C77700`
- `confidenceLow = #C92A2A`

## Border and divider
- `borderSubtle = #E8EAED`
- `borderMedium = #D0D5DD`
- `borderStrong = #A0A7B0`
- `divider = #E8EAED`

## Focus and selection
- `focusRing = #2B5F44`
- `selectionBg = #E8F3ED`

---

## 4. Spacing scale

- `spaceXXS = 4px`
- `spaceXS = 8px`
- `spaceSM = 12px`
- `spaceMD = 16px`
- `spaceLG = 24px`
- `spaceXL = 32px`
- `spaceXXL = 48px`
- `spaceXXXL = 64px`

Implementation notes:
- `16px` is the default spacing unit for standard padding and layout rhythm
- `24px` is the default section separation inside screens
- `32px+` is for large section spacing and major visual separation

---

## 5. Radius scale

- `radiusNone = 0px`
- `radiusXS = 4px`
- `radiusSM = 8px`
- `radiusMD = 12px`
- `radiusLG = 16px`
- `radiusXL = 20px`
- `radiusFull = 9999px`

Implementation notes:
- Default button/input/card radius: `12px`
- Large cards and modal-like surfaces may use `16px`
- Pill/chip/circular elements use `full`

---

## 6. Elevation / shadows

- `shadowXS = 0 1px 2px rgba(0, 0, 0, 0.05)`
- `shadowSM = 0 1px 3px rgba(0, 0, 0, 0.08), 0 1px 2px rgba(0, 0, 0, 0.04)`
- `shadowMD = 0 4px 6px rgba(0, 0, 0, 0.07), 0 2px 4px rgba(0, 0, 0, 0.05)`
- `shadowLG = 0 10px 15px rgba(0, 0, 0, 0.1), 0 4px 6px rgba(0, 0, 0, 0.05)`
- `shadowXL = 0 20px 25px rgba(0, 0, 0, 0.1), 0 10px 10px rgba(0, 0, 0, 0.04)`

Flutter approximation targets:
- `xs -> 1`
- `sm -> 2`
- `md -> 4`
- `lg -> 8`
- `xl -> 16`

Rule:
- Keep shadow usage restrained
- Do not make the app feel floaty or noisy

---

## 7. Typography scale (token level)

### Raw text sizes
- `textXS = 12px`
- `textSM = 14px`
- `textBase = 16px`
- `textLG = 18px`
- `textXL = 20px`
- `text2XL = 24px`
- `text3XL = 30px`
- `text4XL = 36px`
- `text5XL = 48px`

### Line heights
- `leadingTight = 1.25`
- `leadingSnug = 1.375`
- `leadingNormal = 1.5`
- `leadingRelaxed = 1.625`
- `leadingLoose = 2`

### Font weights
- `normal = 400`
- `medium = 500`
- `semibold = 600`
- `bold = 700`

---

## 8. Named typography roles

### Display
- Font: `IBM Plex Sans Arabic`
- Size: `48px`
- Weight: `700`
- Line height: `1.2`

### PageTitle
- Font: `IBM Plex Sans Arabic`
- Size: `30px`
- Weight: `600`
- Line height: `1.3`

### SectionTitle
- Font: `IBM Plex Sans Arabic`
- Size: `24px`
- Weight: `600`
- Line height: `1.4`

### CardTitle
- Font: `IBM Plex Sans Arabic`
- Size: `20px`
- Weight: `600`
- Line height: `1.4`

### BodyLarge
- Font: `IBM Plex Sans Arabic`
- Size: `18px`
- Weight: `400`
- Line height: `1.6`

### Body
- Font: `IBM Plex Sans Arabic`
- Size: `16px`
- Weight: `400`
- Line height: `1.6`

### BodySmall
- Font: `IBM Plex Sans Arabic`
- Size: `14px`
- Weight: `400`
- Line height: `1.5`

### Label
- Font: `IBM Plex Sans Arabic`
- Size: `14px`
- Weight: `500`
- Line height: `1.4`

### Caption
- Font: `IBM Plex Sans Arabic`
- Size: `12px`
- Weight: `400`
- Line height: `1.5`

### QuranLarge
- Font: `Amiri Quran`
- Size: `24px`
- Weight: `400`
- Line height: `2.0`

### QuranMedium
- Font: `Amiri Quran`
- Size: `18px`
- Weight: `400`
- Line height: `1.8`

---

## 9. Default component sizing rules

### Buttons
Primary and secondary buttons:
- Horizontal padding: `24px`
- Vertical padding: `12px`
- Radius: `12px`
- Text role: `Label`

Small button:
- Horizontal padding: `16px`
- Vertical padding: `8px`

Text button:
- no filled background
- use `actionPrimary`

Icon button:
- default touch target should remain comfortable
- circular or rounded treatment allowed depending on context

### Inputs
- Height target: around `44px - 48px`
- Horizontal padding: `16px`
- Vertical padding: `12px`
- Radius: `12px`
- Background: `surfaceTertiary`
- Border: `borderSubtle`
- Focus ring: `focusRing`

### Cards
- Default internal padding: `16px`
- Large card padding: `24px`
- Radius: `12px` default
- Border: `borderSubtle`
- Surface: `surfaceElevated`

### Chips / badges
- Use full or small rounded treatment
- Small horizontal padding
- Semantic color mapping only

### Bottom navigation
- Keep visually stable and low-noise
- Use `actionPrimary` for selected state
- Use `textTertiary` for unselected state

---

## 10. Layout rules

### Mobile grid
- Margin: `16px`
- Gutter: `16px`
- Columns: `4` or `6`
- Max width reference from generated docs: `428px`

### Section rhythm
- Card internal gap often uses `16px`
- Section-to-section gap typically `24px`
- Large vertical separations use `32px+`

---

## 11. Semantic mapping rules

Use these mappings consistently:

### Memorize
- Accent: `memorizeActive`
- Surface: `memorizeSurface`

### Review
- Accent: `reviewDue`
- Surface: `reviewSurface`

### Self-test
- Accent: `selfTest`
- Surface: `selfTestSurface`

### Success / completed
- Accent: `completed` or `success`
- Surface: `completedSurface` or `successSurface`

### Overdue / critical
- Accent: `overdue` or `error`
- Surface: `overdueSurface` or `errorSurface`

### Confidence
- High -> `confidenceHigh`
- Medium -> `confidenceMedium`
- Low -> `confidenceLow`

---

## 12. Light / dark mode note

The generated light tokens are usable and should be the source of truth for V1.

The generated dark mode is not considered fully product-ready.
Do not implement dark mode casually.
Choose one of these explicitly:
- V1 ships light mode only
- or define a proper semantic dark token system before implementing dark mode

---

## 13. Flutter implementation rules

When translating to Flutter:
- preserve these exact values unless there is a strong technical reason not to
- if an approximation is required, document it
- use named roles, not arbitrary per-widget values
- do not let generic component defaults override these exact specs