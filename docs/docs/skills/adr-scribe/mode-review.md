---
sidebar_label: "Mode: Review"
sidebar_position: 3
---

# Review Mode (adr-scribe)

Use this mode to get a **structured critique** of an existing ADR. The agent checks it for completeness, balance, and adherence to the MADR standard.

## When it activates

- You paste an existing ADR
- *"Review this ADR"*, *"Is this ADR complete?"*

## The checklist

| Check | Pass condition |
|-------|---------------|
| **Title** | Clear, decision-oriented (not "Database Options") |
| **Status** | One of: Proposed, Accepted, Deprecated, Superseded |
| **Context** | Explains the forces at play, not just the solution |
| **Options** | At least 2 alternatives listed |
| **Decision** | Clear chosen option with rationale |
| **Positive consequences** | At least 1 listed |
| **Negative consequences** | At least 1 listed (mandatory — no free lunches) |
| **Completeness** | No TODO/placeholder sections |

## Example

**You:**
```
Act as the adr-scribe. Please review this ADR:

# Use Microservices

* Status: Accepted

## Context
We want to scale our system.

## Decision Outcome
We will use microservices.

### Positive Consequences
* Better scalability.
```

**Agent output:**
```
## ADR Review

🔴 **Critical Issues**

1. **Missing: Considered Options** — An ADR without alternatives is not an ADR,
   it's an announcement. What other approaches did you consider?
   (Modular monolith, SOA, serverless?)

2. **Missing: Negative Consequences** — Microservices introduce significant
   operational complexity (distributed tracing, network latency, service
   discovery). This must be documented.

🟡 **Warnings**

3. **Context is too vague** — "We want to scale" doesn't capture the specific
   forces. Which dimension? (User load? Team size? Deployment frequency?)

4. **Decision rationale is absent** — Why microservices over a modular monolith?
   What specific scaling characteristic drove this choice?

🟢 **Good**
- Status is set correctly.
- Title is clear.

**Suggested next step:** Use Interview mode to rebuild this ADR properly.
```
