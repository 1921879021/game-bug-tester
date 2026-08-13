# Example bug report

```yaml
bug_id: BUG-SAVE-003
title: Quest progression resets after scene transition
status: confirmed
severity: high
priority: p1
engine: Unity
mode: NATIVE
build: local-test-build
reproducibility:
  attempts: 3
  reproduced: 3
prerequisites:
  - quest `q_intro` is active
  - quest_stage is 4
steps:
  - enter Town
  - set/advance quest stage to 4 through normal game flow
  - transition to Dungeon
  - read authoritative quest state
expected:
  quest_stage: 4
actual:
  quest_stage: 0
oracle:
  type: structured_state_equality
  source: project quest-state service
evidence:
  - before_state.json
  - after_state.json
  - native_test_output.xml
suspected_area:
  - scene transition persistence
  - quest state initialization
regression_test:
  recommended: true
notes:
  - no third-party QA adapter was used
```

A report should be adapted to the current project. Do not invent build numbers, business rules, or expected values.
