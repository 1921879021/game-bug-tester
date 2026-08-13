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
Reproduction + Shrinking
   ↓
Bug report + regression test
```

The public architecture intentionally separates **knowledge** from **execution tooling**. Knowledge is always available. Execution adapts to what the developer already has.

## Why native-first

A public GitHub skill must work in heterogeneous repositories. Mandatory external QA stacks create setup friction and fail in cloud/CI environments. Native-first testing lets Codex/Claude Code use the same compiler, engine, scripts, and logs the developer already uses.

## Why optional adapters remain

Some bugs are easiest to reproduce by driving a built game. Object/image automation is valuable, but it belongs in an optional capability layer rather than the core dependency chain.
