---
sidebar_position: 1
---

# Internet Banking System

A complete worked example showing both a Level 1 Context and Level 2 Container diagram for a fictional Internet Banking System — the canonical C4 model reference example.

## Level 1: System Context

**Prompt used:**
```
Act as the C4 Designer. Generate a Level 1 System Context diagram for
an Internet Banking System. Customers view balances and make payments.
The system connects to an internal email server and a mainframe.
```

**Output:**

```mermaid
C4Context
    title System Context for Internet Banking System

    Person(customer, "Banking Customer", "A customer of the bank, with personal bank accounts.")
    Person_Ext(staff, "Back Office Staff", "Internal bank staff who manage customer accounts.")

    System(banking, "Internet Banking System", "Allows customers to view account balances and make payments online.")

    System_Ext(email, "E-mail System", "The internal Microsoft Exchange email system.")
    System_Ext(mainframe, "Mainframe Banking System", "Stores all core banking information about customers, accounts, transactions, etc.")

    Rel(customer, banking, "Views account balances and makes payments using", "HTTPS")
    Rel(staff, banking, "Manages customer accounts and transactions using", "HTTPS")
    Rel(banking, email, "Sends payment confirmation emails via", "SMTP")
    Rel(banking, mainframe, "Reads account data and posts transactions to", "XML/HTTPS")
```

### Reading this diagram

| Element | Type | Meaning |
|---------|------|---------|
| Banking Customer | `Person` | A human who interacts with the system |
| Back Office Staff | `Person_Ext` | An internal user who also interacts but is outside the system boundary |
| Internet Banking System | `System` | The system we are describing |
| E-mail System | `System_Ext` | An external dependency |
| Mainframe Banking System | `System_Ext` | Another external dependency |

---

## Level 2: Container Diagram

**Prompt used:**
```
Now go deeper. Generate a Level 2 Container Diagram for the
Internet Banking System. Include a React SPA, a Node.js API,
a PostgreSQL database, and a Redis session cache.
```

**Output:**

```mermaid
C4Container
    title Container Diagram for Internet Banking System

    Person(customer, "Banking Customer", "A customer of the bank.")

    System_Boundary(banking, "Internet Banking System") {
        Container(spa, "Single-Page App", "React, TypeScript", "Provides all Internet banking functionality via the customer's web browser.")
        Container(mobile, "Mobile App", "React Native", "Provides a limited subset of banking functionality via mobile device.")
        Container(api, "API Application", "Node.js, Express", "Provides all Internet banking functionality via a JSON/HTTPS API.")
        ContainerDb(db, "Database", "PostgreSQL 15", "Stores user registration, hashed credentials, and transaction history.")
        ContainerDb(cache, "Session Cache", "Redis 7", "Stores active session tokens for authenticated users.")
    }

    System_Ext(email, "E-mail System", "Internal Microsoft Exchange email system.")
    System_Ext(mainframe, "Mainframe Banking System", "Stores all core banking information.")

    Rel(customer, spa, "Views account balances and makes payments using", "HTTPS")
    Rel(customer, mobile, "Views account balances using", "HTTPS")
    Rel(spa, api, "Makes API calls to", "JSON/HTTPS")
    Rel(mobile, api, "Makes API calls to", "JSON/HTTPS")
    Rel(api, db, "Reads from and writes to", "JDBC")
    Rel(api, cache, "Reads and writes session tokens to", "Redis protocol")
    Rel(api, email, "Sends payment confirmation emails via", "SMTP")
    Rel(api, mainframe, "Reads account data from and posts transactions to", "XML/HTTPS")
```

### Key design decisions visible in this diagram

1. **SPA and Mobile App are separate containers** — different technology stacks (`React` vs `React Native`) and can be deployed and scaled independently.
2. **Session cache is separate from the database** — Redis is used for ephemeral session data; PostgreSQL for durable records. This is visible in the diagram without reading any code.
3. **All external system connections go through the API** — the SPA never calls the mainframe directly. This is a security boundary made visible by C4.
