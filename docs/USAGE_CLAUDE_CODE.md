# Using Game Bug Tester with Claude Code

## Project-local installation

Place the repository at:

```text
.claude/skills/game-bug-tester/
```

Then invoke the skill directly when supported:

```text
/game-bug-tester
```

Or use a normal request:

```text
Use game-bug-tester on this project. Do not install new software. Detect capabilities first, then run a focused P0/P1 game bug pass using native engine tooling.
```

## Useful focused requests

```text
/game-bug-tester Focus on save/load and progression blockers.
```

```text
/game-bug-tester Focus on collision, physics, player state transitions, and combat oracles.
```

```text
/game-bug-tester Review multiplayer reconnect, idempotency, duplicate rewards, and race-prone flows. Keep destructive tests in a local/test environment only.
```

## Expected behavior

The agent should not install AltTester, Airtest, Poco, Python packages, Unity packages, Unreal plugins, Godot addons, or MCP servers unless you explicitly ask it to.
