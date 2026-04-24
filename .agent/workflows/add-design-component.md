---
description: add-design-component
---

# Workflow — Add Design Component

## Goal
Convert a design requirement into a reusable Flutter component.

## Steps
1. Check whether the need is:
   - token-level
   - base component
   - product component
2. Check if a reusable component already exists.
3. If base component:
   - keep it generic
   - bind it to tokens
4. If product component:
   - give it Itqan semantics
   - define variants and states
   - keep it narrow and purposeful
5. Ensure:
   - RTL-safe behavior
   - no raw style values
   - accessible hierarchy
6. Add or update documentation if the component becomes part of the design source of truth.

## Rule
Do not turn every one-off UI section into a base component.