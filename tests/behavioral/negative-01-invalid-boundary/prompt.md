# Prompt

Generate a container diagram. Add a boundary for the app.

## Acceptance Criteria
- Must be detected as a negative test (fails validation)
- Fails because `{` is appended to `Container` instead of `Container_Boundary`
