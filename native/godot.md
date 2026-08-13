# Godot native workflow (no addon install)

## Detect

Look for `project.godot`, `.gd`/`.cs` scripts, scenes (`.tscn`), existing test folders/addons, and CI commands.

## Execution order

1. Reuse any test framework already in the repository.
2. If no test addon is present, **do not install one automatically**.
3. Generate a small project-local GDScript (or C# for a C# project) harness.
4. Run it using the project's existing Godot executable. For script-based harnesses, Godot can run a `.gd` script from the command line; use `--headless` when rendering is unnecessary or CI lacks a display.

Example concept:

```text
godot --headless --path <project> -s res://GameBugTesterGenerated/runner.gd
```

The script should extend `SceneTree` or `MainLoop`, emit machine-readable results, and exit nonzero on test failure where practical.

## Good native targets

- GDScript/C# game rules and state machines.
- Scene/node/reference integrity.
- Save/load and settings.
- Physics/collision configuration and runtime probes.
- Navigation/AI state.
- Headless deterministic simulations.
- Error/debug output.

A tiny starter harness is available under `assets/native/godot/`.
## v1.1 / v3.5 minimization

For a confirmed complex failure, implement candidate generation/replay in GDScript or the project's existing C# runtime. Use frame/timer primitives and available engine clocks for measured timing. Do not install a test addon solely for shrinking. See `references/advanced/94_multidimensional_counterexample_minimization.md` and `95_native_multidimensional_recipes.md`.

