---
sidebar_label: "Mode: Interview"
sidebar_position: 1
---

# Interview Mode

Use this mode to **draft a new ADR** through a guided conversation. The agent interviews you to gather the context, options considered, and the decision rationale — then produces a complete MADR document.

## When it activates

- *"We just decided to use X instead of Y"*
- *"Help me document this architectural decision"*
- *"We chose PostgreSQL over MongoDB"*

## The interview flow

The agent asks these questions in order:

1. **Title:** *"What is the short title for this decision? (e.g., 'Use PostgreSQL over MongoDB')"*
2. **Status:** *"Is this decision Proposed, Accepted, or still under review?"*
3. **Context:** *"What problem or constraint led to this decision? What are the forces at play?"*
4. **Options:** *"What alternatives did you consider? List them, even if briefly."*
5. **Decision:** *"Which option did you choose, and why?"*
6. **Positive consequences:** *"What benefits does this decision bring?"*
7. **Negative consequences:** *"What trade-offs or risks does this decision introduce?"*

:::warning
The agent will **refuse to finalize** an ADR without at least one negative consequence. Every real architectural decision has trade-offs — an ADR that only lists benefits is considered incomplete.
:::

## Example dialogue

**You:**
```
Act as the adr-scribe. We just decided to use PostgreSQL instead of MongoDB
for our payments API.
```

**Agent:**
```
I'm in Interview mode. Let me ask a few questions to draft this ADR properly.

1. What was the primary reason for choosing PostgreSQL over MongoDB?
   (e.g., ACID transactions, team familiarity, cost, specific feature)
```

**You:**
```
We need ACID transactions for payment records. MongoDB doesn't support
multi-document transactions well in our version.
```

**Agent:**
```
Got it. What options did you formally consider?
(PostgreSQL, MongoDB, CockroachDB, Amazon Aurora, etc.)
```

...and so on until a complete ADR is drafted.

## Output

```markdown
# Use PostgreSQL over MongoDB for Payments API

* Status: Accepted
* Date: 2026-04-26

## Context

The Payments API requires strong consistency guarantees for financial
transactions. Multi-document operations (e.g., debit one account,
credit another) must be atomic...

## Considered Options

* PostgreSQL 15
* MongoDB 6.0
* CockroachDB

## Decision Outcome

Chosen option: **PostgreSQL 15**, because it provides native ACID
transaction support across multiple rows and tables, which is essential
for financial data integrity...

### Positive Consequences

* Full ACID compliance eliminates the risk of partial payment records.
* Team has existing expertise with PostgreSQL.

### Negative Consequences

* Schema migrations require coordination across services.
* Horizontal scaling is more complex than MongoDB's native sharding.
```
