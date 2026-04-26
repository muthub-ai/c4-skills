# Prompt: Context Diagram from Prose

> **Skill:** `c4designer`  
> **Mode:** `Document-Prose`

Give this prompt verbatim to the agent after installing the `c4designer` skill:

---

Act as the C4 Designer. Please read the following README and produce a Level 1 System Context Diagram. Output as a Markdown file with embedded Mermaid C4.

---

**README to analyze:**

> # Internet Banking System
> 
> This is a mock repository for testing. The system serves banking customers by allowing them to view account balances and make payments. It uses an external Microsoft Exchange e-mail system to send notifications to customers.

## Acceptance Criteria
- Must generate a `C4Context` diagram
- Must include the `Person` (Banking Customer)
- Must include the `System` (Internet Banking System)
- Must include the `System_Ext` (E-mail System)
- Must include `Rel` statements with explicit intent labels
