# Game Bug Tester v1.1.0

Knowledge baseline: **v3.5**

This release adds **multi-dimensional counterexample minimization** while preserving Game Bug Tester's native-first, zero-mandatory-dependency architecture.

## What's new

A confirmed failing reproduction can now be reduced across multiple dimensions:

- action sequence and required action order,
- distinct actors/clients,
- declared-safe parameters,
- timing constraints,
- declared environment perturbations.

The minimizer preserves the same failure signature and uses repeated runs for flaky defects.

## Example

A long failure such as:

```text
open UI → kill → wait → claim x3 → camera toggle → disconnect after 12ms
→ wait → reconnect → close UI → claim x3 → scene change
```

can be reduced, when supported by evidence, toward:

```text
kill
→ claim x1
→ disconnect
→ reconnect
→ claim x1
```

If timing is truly required, the report keeps the observed failure window and a stable replay point. If timing is unnecessary, it is removed.

## Zero mandatory dependencies

v1.1.0 does **not** require developers to install:

- Python or Python packages,
- AltTester,
- Airtest,
- Poco,
- MCP servers,
- npm packages,
- extra Unity packages,
- Unreal plugins,
- Godot addons.

The coding agent implements the minimization procedure with the project's existing engine/language/toolchain.

## Native-first recipes

- Unity: C# / existing tests / project-local harness / Unity CLI.
- Unreal Engine: project-native C++ / Automation / Functional tests / existing Gauntlet workflows.
- Godot: GDScript or C# / Godot CLI/headless.
- Custom engines: existing language, test runner, build/run scripts.

## Bug catalog

The catalog remains at **81 structured bug patterns**. This release improves how failures are minimized and communicated rather than inflating the classification count.

## New files

- `references/advanced/94_multidimensional_counterexample_minimization.md`
- `references/advanced/95_native_multidimensional_recipes.md`
- `templates/counterexample-minimization-contract.yaml`
- `templates/minimization-report.yaml`
- `examples/v35_multidimensional_minimization.md`

## License

MIT
