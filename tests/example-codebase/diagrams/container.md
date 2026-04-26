# Level 2 — Container — Internet Banking System

> **Diagram type**: Container
> **Scope**: The components inside the Internet Banking System.
> **Audience**: Software developers and operators.

## Overview

This diagram shows the high-level architecture of the Internet Banking System. It consists of a React Single-Page Application (SPA) serving as the frontend, a Node.js/Express REST API handling business logic, and a PostgreSQL database for persistent storage. It interacts with an external E-mail System.

## Diagram

```mermaid
C4Container
    title Container diagram for Internet Banking System
    
    Person(customer, "Banking Customer", "A customer of the bank, with personal bank accounts.")
    System_Ext(email_system, "E-mail System", "The internal Microsoft Exchange e-mail system.")
    
    System_Boundary(banking_system, "Internet Banking System") {
        Container(spa, "Single-Page App", "React", "Provides all internet banking functionality to customers via their web browser.")
        Container(api, "API Application", "Node.js/Express", "Provides internet banking functionality via a JSON/HTTPS API.")
        ContainerDb(db, "Database", "PostgreSQL 15", "Stores user registration information, hashed authentication credentials, access logs, etc.")
    }
    
    Rel(customer, spa, "Visits and interacts with", "HTTPS")
    Rel(spa, api, "Makes API calls to", "JSON/HTTPS")
    Rel(api, db, "Reads from and writes to", "JDBC")
    Rel(api, email_system, "Sends e-mails using", "SMTP")
    Rel(email_system, customer, "Sends e-mails to", "SMTP/IMAP")
```

## Legend

- **Person / actor**: human user of the system
- **System (in scope)**: the system the diagram is about
- **External system**: out-of-scope system our system interacts with
- **Container**: independently deployable application or data store

## Elements

| Element | Type | Technology | Responsibility |
|---|---|---|---|
| *Banking Customer* | *Person* | *—* | *A customer who uses the system to manage their money.* |
| *Single-Page App* | *Container* | *React* | *Provides all internet banking functionality to customers via their web browser.* |
| *API Application* | *Container* | *Node.js/Express* | *Provides internet banking functionality via a JSON/HTTPS API.* |
| *Database* | *ContainerDb* | *PostgreSQL 15* | *Stores user registration information, hashed authentication credentials, access logs, etc.* |
| *E-mail System* | *System_Ext* | *Microsoft Exchange* | *Sends emails to customers.* |

## Key relationships

| From | To | Intent | Protocol / Technology |
|---|---|---|---|
| *Banking Customer* | *Single-Page App* | *Visits and interacts with* | *HTTPS* |
| *Single-Page App* | *API Application* | *Makes API calls to* | *JSON/HTTPS* |
| *API Application* | *Database* | *Reads from and writes to* | *JDBC* |
| *API Application* | *E-mail System* | *Sends e-mails using* | *SMTP* |

## Notable architectural decisions

- **PostgreSQL Database**: Chosen over MongoDB to ensure strict ACID compliance for financial transactions.
- **Single Page Application**: Chosen to provide a rich, responsive user experience decoupled from backend deployments.

## Links to other levels

- *↑ [Level 1 - Context Diagram](./context.md) — more abstract view*
