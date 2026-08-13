# Unreal Engine native workflow (no third-party QA install)

## Detect

Look for `.uproject`, `Source/`, `Config/`, `Content/`, `.Build.cs`, existing Automation/Functional/Low-Level tests, and project UAT/Gauntlet scripts.

## Execution order

1. Reuse existing Unreal tests.
2. Prefer Automation Test Framework / Automation Spec / Functional Tests for deterministic project behavior.
3. Use command-line automation and export reports when the editor/client is available.
4. Use Gauntlet for session/multi-client orchestration when the project already supports it through the Unreal installation/workflow.
5. Do not install unrelated external QA frameworks by default.

## Native CLI pattern

Unreal supports command-line automation such as:

```text
-ExecCmds="Automation RunTest <TestName>;Quit"
-ReportExportPath="<output>"
```

Discover the correct Editor/Client executable and project arguments from the project/CI rather than hardcoding paths.

## Good native targets

- C++ gameplay/business rules.
- Actor/component state and world invariants.
- Functional map tests.
- Network replication and multi-client tests.
- Data validation and asset/reference checks.
- Logs, ensure/assert/crash evidence.
- Performance captures when the project already has a measurement workflow.

## Generated test policy

Place temporary test code in a clearly named project test location, compile it with the project's existing toolchain, show the diff, and keep or remove it based on the user's preference.
## v1.1 / v3.5 minimization

For a confirmed complex failure, keep candidate generation/replay inside project-native C++/Automation/Functional-test infrastructure. Use latent commands/timers plus engine timing evidence as available. Do not add a plugin or Python fuzzer just for shrinking. See `references/advanced/94_multidimensional_counterexample_minimization.md` and `95_native_multidimensional_recipes.md`.

