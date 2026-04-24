# Tech Stack

## App framework
- Flutter

## State management
- Riverpod

## Navigation
- go_router or equivalent declarative routing
- keep route definitions centralized

## Local persistence
- choose local-first persistence when product state must survive app restarts
- likely SQLite/Drift if relational persistence becomes necessary
- use simple local storage only for small preference state

## Localization
- Arabic-first
- RTL-native from day one
- structure code to support later additional locales without distorting Arabic UX

## Audio
- audio playback support is expected for memorization/review support
- design the system so audio controls remain secondary to Quran content

## Design system
- token-driven
- product components layered over base components
- no ad hoc styling in screens

## Logging / analytics
- keep interface boundaries clean so analytics can be added later without contaminating UI code

## Build philosophy
- do not introduce packages just because the generated web export used them
- choose Flutter-native or Flutter-appropriate solutions deliberately