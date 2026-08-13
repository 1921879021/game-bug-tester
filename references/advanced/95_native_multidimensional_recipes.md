# Native Recipes for v3.5 Counterexample Minimization

These recipes keep v3.5 usable without mandatory extra software. They are implementation patterns, not packages to install.

## Unity

Use existing project tests or a temporary C# QA harness.

Recommended primitives:

- project methods/hooks for actions and probes;
- `IEnumerator` / frame progression for coarse runtime sequencing;
- engine time or `System.Diagnostics.Stopwatch` for measured timing evidence;
- project-owned reset fixture;
- Unity command-line execution when already available.

Agent procedure:

1. Encode a candidate as C# data (`Step[]` or serializable JSON/YAML equivalent already used by the project).
2. Reset the fixture.
3. Execute actions in order.
4. Measure actual action start times.
5. Probe authoritative/internal state.
6. Compare the declared invariant.
7. Iterate candidates using the v3.5 algorithm.
8. Delete the temporary harness if the user does not want to keep it.

Do not add a Unity package just to run the minimizer.

## Unreal Engine

Prefer the project's existing Automation/Functional/Low-Level test infrastructure.

Useful project-native patterns:

- latent automation commands for ordered actions;
- world timers for delays;
- `FPlatformTime` or engine timing APIs for actual timing evidence;
- test actors/components exposing safe QA-only state hooks;
- Automation reports and logs as evidence.

For multiplayer, use the project's current server/client launch path. Use Gauntlet only when already available in the project/engine workflow.

Do not add a third-party plugin merely for minimization.

## Godot

Use a project-local GDScript or C# harness:

- action list stored as dictionaries/resources;
- `await get_tree().process_frame` for frame sequencing;
- `await get_tree().create_timer(...).timeout` for coarse delays;
- `Time.get_ticks_usec()` / available engine clocks for measured timing;
- project-owned state reset and probes;
- Godot CLI/headless for repeated candidates when the project can run that way.

Do not install GUT/WAT solely for this feature.

## Generic/custom engine

Use the existing project language and lifecycle:

```text
reset_fixture()
for step in candidate:
    wait(step.timing)
    execute(step)
snapshot = probe()
verdict = oracle(snapshot)
```

The agent can implement ddmin, parameter ladders, and timing search directly in the project's language. These algorithms are small enough that a dedicated external runtime is not required.

## Precision rule

Timing requested by a test must not exceed the practical scheduling precision of the environment.

Examples:

- frame-driven game loop: report frame-level precision;
- millisecond timer: report observed millisecond offsets;
- multiplayer process orchestration: measure actual action timestamps on the participating side(s).

Never report a `7.000 ms` critical window when the harness only observes 16.7 ms frames.
