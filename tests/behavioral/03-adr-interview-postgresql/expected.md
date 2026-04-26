# 0001. Use PostgreSQL over MongoDB for Core Banking API

* Status: Accepted
* Date: 2026-04-26

## Context and Problem Statement

The Internet Banking API requires a primary data store to manage user accounts, authentication credentials, and financial transactions. We need a database that guarantees data consistency for all financial operations.

## Decision Drivers

* Strict ACID compliance required for financial transactions.
* Complex relational queries needed for auditing.
* Team familiarity with SQL-based databases.

## Considered Options

* Option 1: PostgreSQL
* Option 2: MongoDB

## Decision Outcome

Chosen option: "Option 1: PostgreSQL", because it provides robust, out-of-the-box ACID compliance which is non-negotiable for a banking system.

### Positive Consequences

* Guarantees data consistency across complex multi-step account transfers.
* Well-understood schema and query model for financial data.
* Extensive tooling for point-in-time recovery and backups.

### Negative Consequences

* Schema migrations are more complex and require careful coordination during CI/CD.
* Horizontal write scaling is harder than NoSQL alternatives.
