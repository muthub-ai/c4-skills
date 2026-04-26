---
sidebar_label: "Mode: Design"
sidebar_position: 1
---

# Design Mode

Use this mode when you want to **design a new system from scratch**. The agent runs a structured 5-phase dialogue to gather requirements before generating any output.

## When it activates

- *"I want to design a new system"*
- *"Let's architect a service for X"*
- Vague idea with no existing code or diagrams

## The 5 Phases

### Phase 1: System Scoping
The agent asks:
> *"What is the name and purpose of the system? In one or two sentences, what does it do and for whom?"*

### Phase 2: Actor & External System Discovery
> *"Who are the primary users? Are there external systems (payment gateways, email providers, identity providers) that this system interacts with?"*

### Phase 3: Container Identification
> *"What are the main deployable units? (e.g., web app, mobile app, REST API, message queue, database)"*

### Phase 4: Technology Stack
> *"What technology does each container use? (e.g., React, Node.js, PostgreSQL)"*

### Phase 5: Output Negotiation
> *"Where should I save this? (local file at docs/architecture/ | inline in this conversation) What format? (Mermaid | PlantUML | Structurizr DSL)"*

## Example Dialogue

**You:**
```
Act as the C4 Designer. I want to design a food delivery platform.
```

**Agent:**
```
Great — I'm in Design mode. Let me ask a few questions to get the framing right.

1. What's the name of this system, and what's its core purpose?
2. Who are the primary users? (Customers, Restaurant owners, Delivery drivers?)
3. Are there external systems to integrate with? (Payment gateway, maps API, SMS?)
```

**You:**
```
Called "QuickBite". Serves customers ordering food, restaurants managing orders,
and drivers delivering. Integrates with Stripe (payments) and Google Maps.
```

**Agent:**
```
Thanks. Let me propose a first draft of the Context diagram before going deeper...

[Produces Level 1 draft]

Does this capture the scope? Shall I add the mobile app for drivers separately,
or treat it as the same "Customer" actor?
```

## Rules in this mode

- Max 5 questions per phase
- Always produces a **Level 1 Context** diagram first, then Level 2 Container
- Does not write to disk until you confirm the diagram
- Any guesses go into an **Assumptions** section, never silently baked into the diagram

## Complex Input: Multiple Bounded Contexts

If your system spans multiple bounded contexts (e.g., a microservices platform), the agent will:
1. Produce a **System Landscape** diagram first (showing all systems)
2. Drill into each system with individual Context diagrams
3. Then produce Container diagrams per system

**Prompt:**
```
Act as the C4 Designer. We have an e-commerce platform split into
3 domains: Order Management, Inventory, and Payments. Each is a separate service.
Design the full architecture.
```
