---
sidebar_label: "Mode: Retro-Document"
sidebar_position: 2
---

# Retro-Document Mode

Use this mode when a decision has **already been made** and you want to document it retroactively from a PR, commit, or code diff.

## When it activates

- You provide a PR link or git diff
- *"Retro-document the decision to switch from X to Y"*
- *"This PR migrated us from JWT to session cookies — document the ADR"*

## Example prompt

```
Act as the adr-scribe in Retro-Document mode.
This PR migrated our authentication from JWT tokens to server-side sessions.

[paste PR description or diff]
```

## What the agent infers

From the PR/diff, the agent infers:

| Inferred from | ADR field |
|--------------|-----------|
| PR title | ADR title |
| Files changed | Technology involved |
| PR description | Context and rationale |
| Removed code | Options that were rejected |
| New dependencies | Technology chosen |
| Comments/reviews | Trade-offs and concerns |

## Assumptions

Anything not explicitly stated in the PR will be listed in the **Assumptions** section of the generated ADR. This is intentional — it prevents the agent from silently inventing rationale.

```markdown
## Assumptions (requires human review)

- Assumed the primary motivation was security (session fixation risk with JWTs).
  Please verify and update the Context section if the reason was different.
- Assumed Redis was chosen for session storage based on the added dependency.
  If a different store is used, update the ADR accordingly.
```

## Handling large PRs

For PRs with many changes, focus the agent:

```
Act as the adr-scribe. This PR has many changes but the key architectural
decision is the migration from REST to gRPC. Focus only on that change
and ignore the unrelated CSS updates.

[paste PR]
```
