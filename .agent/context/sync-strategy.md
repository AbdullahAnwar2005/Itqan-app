# Sync Strategy

## Current stance
V1 should not assume a complex backend unless clearly required by an approved feature.

## Preferred posture
- local-first where feasible
- stable offline behavior
- design persistence and repositories so remote sync can be added later

## If sync is added later, define explicitly:
- what is the source of truth
- what data is local-only
- what data syncs
- how conflicts are resolved
- how offline changes are queued
- what user-facing states are needed during sync

## Current decision
Deferred until a real backend requirement appears.