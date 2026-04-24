---
description: review-code
---

# Workflow — Review Code

## Review checklist

### Architecture
- Does this respect feature boundaries?
- Is business logic kept out of widgets?
- Are dependencies flowing in the correct direction?

### Design system
- Are tokens used instead of raw values?
- Are product components reused correctly?
- Is Quran text treated with dedicated styles?

### UX
- Is there a clear primary action?
- Is the screen calm and low-friction?
- Does it match Itqan's today-first, review-first-class approach?

### RTL
- Are directional APIs used correctly?
- Any hidden LTR assumptions?
- Are directional icons appropriate?

### State
- Are providers scoped correctly?
- Any unnecessary rebuilds?
- Is state derived in the right layer?

### Scope
- Is this V1-appropriate?
- Any overbuilt abstractions?

## Output style
The review should identify:
- what is correct
- what is risky
- what should change now
- what can wait