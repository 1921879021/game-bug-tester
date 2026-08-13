# Using Game Bug Tester with Codex

## Project-local installation

Place the repository at:

```text
.agents/skills/game-bug-tester/
```

A simple local copy is enough. The root `SKILL.md` is the entry point.

## Recommended prompts

### High-risk smoke pass

```text
Use game-bug-tester. Inspect the current game project, detect engine/tooling, do not install anything, and run the smallest useful P0/P1 bug pass. Prefer native tests and give me evidence for every failure.
```

### Save/load pass

```text
Use game-bug-tester to focus on save/load, scene transitions, state persistence, interrupted saves, and migration risks that are actually applicable to this project. Do not invent persistence rules; infer them from code/tests/docs or mark manual oracle required.
```

### Physics/gameplay pass

```text
Use game-bug-tester to test collision, out-of-bounds, fall-through, movement state, death/input lock, and combat invariants that can be verified with this project's native engine capabilities.
```

### Multiplayer/race pass

```text
Use game-bug-tester to inspect the multiplayer architecture and build a safe local race-condition test plan. Only run disconnect/fault/race tests in an isolated test environment. Minimize any reproducible failing sequence.
```

## Expected behavior

The skill should first report capability detection and one selected mode. Missing optional adapters must not stop a source-based native test run.

## Built-in installer option

Codex also provides a built-in `$skill-installer` for curated/local skill setup. You can ask it to install a skill from this GitHub repository once the repository URL is public. This is optional; the project-local `.agents/skills/game-bug-tester/` layout remains the most explicit repo-scoped setup.
