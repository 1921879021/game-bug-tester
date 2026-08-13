# Architecture

```text
Coding Agent
   ↓
Game Bug Tester SKILL.md
   ↓
Capability Detection
   ├─ NATIVE
   ├─ NATIVE_PLUS
   ├─ BLACKBOX_ASSISTED
   └─ BLACKBOX_AUTOMATED
   ↓
Risk Planner (81 bug patterns)
   ↓
Engine-native test / project-local harness
   ↓
Evidence + Oracle
   ↓
Reproduction + Multi-Dimensional Minimization
   ↓
Bug report + regression test
```

The public architecture intentionally separates **knowledge** from **execution tooling**. Knowledge is always available. Execution adapts to what the developer already has.

## Why native-first

A public GitHub skill must work in heterogeneous repositories. Mandatory external QA stacks create setup friction and fail in cloud/CI environments. Native-first testing lets Codex/Claude Code use the same compiler, engine, scripts, and logs the developer already uses.

## Why optional adapters remain

Some bugs are easiest to reproduce by driving a built game. Object/image automation is valuable, but it belongs in an optional capability layer rather than the core dependency chain.


## v1.1 / knowledge baseline v3.5

The minimization layer now treats a failing reproducer as a structured counterexample with multiple dimensions:

```text
sequence
+ actors
+ parameters
+ timing
+ declared environment perturbation
```

The coding agent minimizes those dimensions with the **project's existing runtime/toolchain**. The repository intentionally does not add a mandatory minimizer executable or Python package.

See:

- `references/advanced/94_multidimensional_counterexample_minimization.md`
- `references/advanced/95_native_multidimensional_recipes.md`
- `templates/counterexample-minimization-contract.yaml`
