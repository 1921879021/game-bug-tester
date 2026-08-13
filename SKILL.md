---
name: game-bug-tester
description: Systematically test game projects for common bugs using the project's existing engine, source code, build tools, logs, and native test capabilities. Use for Unity, Unreal, Godot, or other game repositories when asked to find, reproduce, regression-test, or report gameplay, physics, UI, save/load, performance, AI, networking, or state-sequence bugs. Do not require or auto-install third-party QA tools; optional adapters may be used only when already available or explicitly requested.
---

# Game Bug Tester

Public zero-mandatory-dependency edition. Knowledge baseline: v3.5.

## Mission

Act as a game QA engineer inside the current repository. Prefer the project's **existing engine and toolchain** over third-party automation frameworks. Work from evidence, keep risky actions inside safe test environments, and distinguish product failures from test-tool failures.

## Non-negotiable rules

1. **Do not install software, packages, plugins, SDKs, Python modules, npm packages, Unity packages, Unreal plugins, Godot addons, MCP servers, or QA frameworks unless the user explicitly asks you to.**
2. **Native-first.** Use tools already present in the project or engine installation.
3. **No guessed business oracle.** Never invent damage, prices, cooldowns, save semantics, replication rules, or acceptable performance thresholds.
4. **Automation failure is not a game bug.** Classify locator/build/launch/environment failures separately.
5. **Do not test destructive/live-economy operations against production accounts or live services.** Purchases, currency mutation, save corruption, network fault injection, bans, deletes, and migration tests require an isolated test environment.
6. **Minimize repository pollution.** Put temporary generated QA files under an obvious project-local test folder, show the diff, and remove them when they are no longer needed unless the user wants to keep them.
7. **Do not claim black-box full automation if you only have a compiled game and no control interface.** Degrade gracefully to static/log/manual-assisted testing.

## Phase 0 — Capability detection (always first)

Inspect the repository and classify the available mode without downloading anything.

Detect:
- Engine: Unity / Unreal / Godot / custom / web / unknown.
- Source availability.
- Engine executable or project-local launch commands.
- Existing tests and test frameworks.
- Existing CI scripts, Makefile, package scripts, build scripts, README launch instructions.
- Existing optional adapters (AltTester, Airtest, Poco, Appium, Selenium, Playwright, engine MCP, etc.).
- Whether a safe local/test environment exists.

Choose exactly one primary mode:

- `NATIVE`: source + engine/toolchain available; no optional QA adapter required.
- `NATIVE_PLUS`: native mode plus an already-installed optional adapter.
- `BLACKBOX_ASSISTED`: build only; can inspect logs/screenshots and guide/manual-drive tests, but cannot reliably control every UI/gameplay action.
- `BLACKBOX_AUTOMATED`: build only plus an already-available automation/control adapter.

Report the selected mode briefly before changing files or running long tests.

## Engine routing

### Unity
Read `native/unity.md`.

Priority:
1. Reuse existing Unity tests if present.
2. If Unity Test Framework is already available, generate focused EditMode/PlayMode tests and run them with the Unity CLI.
3. If it is not already available, **do not install it**. Generate a temporary project-local Editor/native harness and invoke it with Unity batch mode / `-executeMethod` where appropriate.
4. For runtime-only issues, build or launch the existing project and collect Player/Editor logs plus project state hooks that you add temporarily to the test build.

### Unreal Engine
Read `native/unreal.md`.

Priority:
1. Reuse existing Automation/Functional/Low-Level/Gauntlet tests.
2. Generate project-native Automation tests when source and build environment allow it.
3. Run with Unreal command-line automation and export reports.
4. Use Gauntlet only when it is already part of the Unreal installation/project workflow; do not add third-party QA frameworks by default.

### Godot
Read `native/godot.md`.

Priority:
1. Reuse existing tests/addons if already present.
2. Otherwise generate a project-local GDScript/C# test harness and run it with the existing Godot executable, preferably headless when appropriate.
3. **Do not auto-install GUT/WAT or other addons.**

### Other/custom engines
Read `native/generic.md`. Prefer the repository's own build/test/run commands and generate test harnesses in the project's existing language/runtime.

## Risk-driven test planning

Read these first when relevant:
- `references/core/bug_catalog.yaml` — 81 structured bug patterns.
- `references/core/14_genre_profiles.yaml` — genre weighting.
- `references/core/15_state_transition_catalog.yaml` — high-yield state combinations.
- `references/core/10_test_oracle.md` — oracle rules.
- `references/core/11_severity_priority.md` — severity/priority.

Prioritize P0/P1 classes first:
- crash/freeze/black screen/progression blocker,
- save corruption or state loss,
- out-of-bounds/fall-through/collision bypass,
- duplicated economy/reward/transaction state,
- multiplayer divergence or reconnect duplication,
- unrecoverable AI/navigation deadlock,
- severe performance regression.

Do not blindly run all 81 patterns. Select tests whose prerequisites exist in the current project.

## Test workflow

For each selected risk:

1. Identify prerequisites and relevant source/scenes/assets/config.
2. Determine the strongest available oracle.
3. Prefer a deterministic native test or project-local harness.
4. Execute the smallest useful test.
5. Capture evidence: logs, stack traces, state snapshots, test output, relevant screenshots if available.
6. If failure is observed, rerun safely to estimate reproducibility.
7. Minimize the reproduction sequence/parameters when practical.
8. Output a structured bug report using `templates/bug-report.yaml`.
9. Add a regression test when the project supports it.

## Oracle priority

Use the strongest available evidence in this order:

1. Authoritative/internal structured state or server state.
2. Numeric invariant / exact state transition.
3. Engine object/component state.
4. Log/event/exception evidence.
5. UI hierarchy/state.
6. Screenshot/video/visual judgment.
7. Manual confirmation.

Never replace a stronger oracle with a weaker visual guess.

## Stateful and race testing

For bugs that depend on order/timing, use the algorithms in:
- `references/advanced/86_temporal_window_search.md`
- `references/advanced/87_failure_shrinking.md`
- `references/advanced/90_stateful_sequence_fuzzing.md`
- `references/advanced/92_sequence_shrinking.md`
- `references/advanced/94_multidimensional_counterexample_minimization.md`
- `references/advanced/95_native_multidimensional_recipes.md`

### v3.5 — multi-dimensional counterexample minimization

When a failing trace is too complex, minimize **action sequence + actors + parameters + timing + declared environment perturbations** while preserving the same failure signature.

Rules:

1. Confirm the baseline failure before shrinking.
2. Delete actions/chunks first.
3. Simplify actors only when identity/concurrency semantics are preserved.
4. Shrink parameters only through project-declared valid domains or values derived from project code/config.
5. Remove unnecessary waits before searching for a narrow timing window.
6. Record actual timing; timing-invalid trials are test-quality failures, not product verdicts.
7. Re-run candidates and require the configured preservation failure rate.
8. Iterate dimensions to a fixed point because parameter/timing changes may make additional actions removable.
9. Prefer a stable, human-usable reproducer over a needlessly fragile ultra-precise schedule.
10. Emit what could not be minimized and why.

These are **algorithms, not mandatory Python runners**. Implement them with tools already available in the current project/environment. If no practical runtime exists, provide a deterministic manual/engine-native test matrix instead of installing one.

## Optional adapters

Only read `optional/` when:
- the adapter is already installed/configured, or
- the user explicitly asks to use/install it.

Absence of AltTester/Airtest/Poco must never block native testing.

## Failure classification

Use these result classes:
- `PASS`
- `GAME_FAILURE`
- `BUILD_FAILURE`
- `AUTOMATION_FAILURE`
- `ENVIRONMENT_FAILURE`
- `INCONCLUSIVE`
- `MANUAL_ORACLE_REQUIRED`

Only `GAME_FAILURE` is a confirmed product defect.

## Output

Summarize:
- detected engine and mode,
- tests selected and why,
- tests executed,
- confirmed/suspected bugs,
- evidence,
- exact reproduction steps,
- severity/priority,
- regression tests added or recommended,
- limitations caused by unavailable capabilities.

If nothing fails, say what was tested and what remains untested. Never claim the game is bug-free.
