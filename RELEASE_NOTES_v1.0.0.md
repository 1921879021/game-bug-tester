# Game Bug Tester v1.0.0

First public release of **Game Bug Tester**, an Agent Skill that helps Codex, Claude Code, and other compatible coding agents systematically test game projects for common bugs.

## Highlights

- Native-first workflow for Unity, Unreal Engine, Godot, and custom game projects.
- **No mandatory third-party QA framework.**
- **No mandatory Python runtime.**
- 81 structured bug patterns across stability, physics, gameplay, UI/input, save/load, AI, projectiles, performance, multiplayer, and race/state-sequence failures.
- Project-specific oracle discipline: the skill does not guess prices, damage, cooldowns, save semantics, network convergence rules, or performance budgets.
- Advanced procedures for temporal race-window search, failure shrinking, stateful sequence fuzzing, and sequence shrinking.
- Optional AltTester / Airtest / Poco guidance remains optional and never blocks native testing.
- Safety gates for real-money economy, save corruption, network fault injection, account mutation, and other destructive tests.

## Install

Put this repository in your game project as a project-local skill:

**Codex**

```text
.agents/skills/game-bug-tester/
```

**Claude Code**

```text
.claude/skills/game-bug-tester/
```

Then ask the coding agent to use `game-bug-tester` and detect capabilities before testing.

## Recommended first prompt

```text
Use game-bug-tester on this repository. Detect the engine and existing test capabilities first. Do not install anything. Run a focused P0/P1 bug pass, prefer native engine tests, and report evidence plus anything you could not test.
```

## Important limitation

A coding agent cannot reliably control every UI/gameplay action in an arbitrary compiled build without a control interface. Build-only projects therefore fall back to assisted analysis unless an automation adapter is already available.

## Compatibility philosophy

The project is designed to degrade gracefully. Missing optional tools reduce automation depth; they must not turn into false game failures or trigger automatic dependency installation.
