---
sidebar_position: 2
---

# ADR: PostgreSQL over MongoDB

A complete, worked Architecture Decision Record for the fictional Internet Banking System. This demonstrates the full MADR template as produced by `adr-scribe` in **Interview mode**.

**Prompt used:**
```
Act as the adr-scribe. We just decided to use PostgreSQL instead of MongoDB
for the Payments API. We need ACID transactions.
```

---

## Full ADR Output

```markdown
# Use PostgreSQL over MongoDB for Payments API

* Status: Accepted
* Date: 2026-04-26

## Context

The Payments API handles financial transactions that require multi-step
atomicity: debit one account, credit another, and log the event — all
in a single atomic operation. If any step fails, the entire transaction
must be rolled back.

MongoDB 6.0 introduced multi-document transactions, but our current
MongoDB version (4.4) does not support them. An upgrade is possible but
carries significant risk given the volume of existing production data.
PostgreSQL offers first-class ACID transaction support and is well-suited
to structured financial data with clear relational constraints.

Key forces:
- Financial data requires ACID guarantees (non-negotiable)
- Engineering team has deep PostgreSQL expertise
- Time-to-market pressure makes a complex migration unattractive

## Considered Options

* **PostgreSQL 15** — Mature relational database with full ACID support
* **MongoDB 4.4** — Current production database, no multi-document transactions
* **MongoDB 6.0 (upgrade)** — Adds multi-document transactions, but requires
  a major version migration with downtime risk
* **CockroachDB** — Distributed SQL with ACID support, but unfamiliar to the team

## Decision Outcome

Chosen option: **PostgreSQL 15**, because it provides the ACID transaction
guarantees required for financial operations, eliminates the multi-document
transaction problem without a risky database upgrade, and aligns with the
team's existing expertise.

### Positive Consequences

* Full ACID compliance eliminates the risk of partial transaction records
  (e.g., debit recorded, credit missing).
* No major version migration risk — fresh schema on a proven platform.
* Team can leverage existing PostgreSQL knowledge (indexing, query optimization,
  connection pooling with pgBouncer).
* Structured schema enforces data integrity at the database level.

### Negative Consequences

* **Schema migrations** require careful coordination as the data model evolves.
  MongoDB's schema-less nature made ad-hoc field additions trivial.
* **Horizontal scaling** is more complex. PostgreSQL scales vertically by default;
  horizontal sharding requires additional tooling (Citus, read replicas).
* **JSON document storage** is more awkward in PostgreSQL than MongoDB, which may
  matter for flexible metadata fields on transactions.
* Existing MongoDB data for non-payment collections (user preferences, audit logs)
  will remain on MongoDB, creating a **polyglot persistence** situation that
  increases operational complexity.
```

---

## What makes this ADR good

| ✅ | Reason |
|----|--------|
| **4 options listed** | Shows the decision was genuinely evaluated, not a foregone conclusion |
| **Specific version numbers** | PostgreSQL 15, MongoDB 4.4 — removes ambiguity |
| **Context explains the forces** | Not just "we need transactions" — explains *why* the current setup fails |
| **4 negative consequences** | Honest about trade-offs; no free lunch presented |
| **Cross-references polyglot persistence** | Flags the new operational complexity introduced |
