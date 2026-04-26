---
sidebar_label: "Mode: Review"
sidebar_position: 4
---

# Review Mode

Use this mode to get a **structured critique** of an existing C4 diagram. The agent evaluates it against Simon Brown's official review checklist and the additional rules enforced by `c4designer`.

## When it activates

- You paste an existing Mermaid / PlantUML / Structurizr diagram
- *"Review this diagram"*, *"Is this good?"*, *"What's wrong with this?"*
- *"Explain what this diagram shows"*

## The checklist

The agent runs through:

### Simon Brown's Official Checklist
- ✅ Does every diagram have a **title**?
- ✅ Is there a **legend** / key?
- ✅ Does every element have a **description**?
- ✅ Does every relationship have a **label**?
- ✅ Is the diagram **consistent** with other levels?
- ✅ Are **acronyms** and **jargon** explained?
- ✅ Is the **scope** appropriate for the target audience?

### c4designer Additions
- ✅ Are all `Rel` labels descriptive (no "Uses", "Calls", "Reads")?
- ✅ Do all `Container` elements state their **technology**?
- ✅ Are all arrows **unidirectional** (no `BiRel`)?
- ✅ Are there any **undefined aliases** in `Rel` statements?
- ✅ Are **boundaries** using `System_Boundary` / `Container_Boundary` (not `{` appended to a container)?

## Example

**You:**
```
Act as the C4 Designer in Review mode. Please critique this diagram:

[paste diagram]
```

**Agent output:**
```
## Review: Container Diagram for Payments Service

### Issues Found

🔴 **Critical**
- Line 12: `Rel(api, db, "Uses")` — bare "Uses" label is forbidden.
  Replace with a descriptive intent, e.g., "Reads payment records from".

🟡 **Warnings**
- The diagram has no title. Add `title Container diagram for Payments Service`.
- `Container(cache, "Redis")` — missing technology parameter.
  Should be `Container(cache, "Cache", "Redis 7", "Stores session tokens.")`.

🟢 **Good**
- All external systems are included.
- Relationships are unidirectional.
```

## Getting an explanation instead of a critique

```
Act as the C4 Designer. Please explain what this diagram shows to a
non-technical stakeholder.

[paste diagram]
```

The agent will produce a plain-English narrative describing the architecture.
