---
sidebar_label: "Mode: Update"
sidebar_position: 5
---

# Update Mode

Use this mode to **evolve an existing diagram** incrementally — adding new containers, removing deprecated services, or changing relationship protocols.

## When it activates

- You paste an existing diagram and say *"add X"*, *"remove Y"*, *"change Z"*
- *"Our system now has a Redis cache — update the diagram"*
- *"We migrated from MySQL to PostgreSQL — reflect that"*

## Example prompts

**Adding a service:**
```
Act as the C4 Designer. Here is our current Container diagram.
We've added a Redis cache between the API and the database.
Please update the diagram.

[paste diagram]
```

**Removing a component:**
```
Act as the C4 Designer. Here is our current diagram.
We've decommissioned the legacy PHP frontend — remove it and update
any relationships that pointed to it.

[paste diagram]
```

**Protocol change:**
```
Act as the C4 Designer. We've migrated from REST to gRPC between
the API Gateway and the Orders service. Update the relationship label
and protocol tag.

[paste diagram]
```

## Regression awareness

The agent will flag **potential regressions** when you make a change:

```
⚠️ Removing the PHP Frontend also removes the relationship:
  Rel(legacy_php, db, "Reads user sessions from", "MySQL")

If the new React SPA also reads user sessions from the database,
you should add an equivalent Rel for it. Shall I add that?
```

## Suggested ADR trigger

After a significant structural change, the agent will prompt:

```
✅ Diagram updated. This change appears to be a significant architectural
decision (migrating from REST to gRPC). Consider documenting this using:

"Act as the adr-scribe. We just decided to use gRPC instead of REST
between the API Gateway and Orders service."
```
