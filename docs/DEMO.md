# Demo transcript

This is an illustrative transcript of the intended user experience. Exact commands vary by project.

```text
User:
Use game-bug-tester on this project. Do not install anything. Run a focused P0/P1 pass.

Agent:
Capability detection
- Engine: Unity
- Source: available
- Unity executable: available
- Existing tests: EditMode + PlayMode
- Optional adapters: none detected
- Safe test environment: local
- Selected mode: NATIVE

Selected high-risk checks
1. Save round-trip / latest-commit persistence
2. Player out-of-bounds and collision bypass
3. Death-state input lock
4. Shop transaction invariant
5. Scene-transition state persistence

Execution summary
- 5 selected
- 5 executed
- 4 PASS
- 1 GAME_FAILURE

Confirmed failure
BUG-SAVE-003 — scene transition loses quest progression
Reproduction: 3/3
Expected: quest_stage remains 4 after Town -> Dungeon
Actual: quest_stage resets to 0
Evidence: state snapshots + test output
Severity: High
Regression test: generated under project-local QA test folder

Limitations
- Multiplayer race tests not executed: no local multiplayer fixture detected
- Performance budget not evaluated: no project threshold found
```

The important behavior is not the exact text. It is that the agent:

1. detects capabilities first,
2. does not install missing QA tools,
3. selects applicable risks rather than blindly running all patterns,
4. uses strong project-native oracles,
5. separates tool/environment failures from product defects,
6. states what remains untested.
