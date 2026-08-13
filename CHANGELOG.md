# Changelog

## 1.1.0 — 2026-08-13

Knowledge baseline **v3.5**.

- Added multi-dimensional counterexample minimization.
- Can minimize action sequence/order, actor set, safe parameter domains, timing constraints, and declared environment perturbations.
- Added preservation-by-failure-signature and repeated-run gates.
- Added stable timing-window preference and actual-timing evidence rules.
- Added native Unity / Unreal / Godot / generic implementation recipes.
- Added a portable minimization contract template and public example.
- Preserved 81 bug patterns; this release improves reproduction quality rather than adding classifications.
- Preserved the zero-mandatory-dependency policy: no required Python, AltTester, Airtest, Poco, plugin, package, or MCP installation.
- GitHub Actions shell validation uses `bash scripts/check-structure.sh` and tracked shell scripts remain executable.

## 1.0.0 — 2026-08-13

First GitHub-ready public release, based on the v3.4 knowledge baseline.

- Portable root `SKILL.md` for Agent Skills-compatible coding agents.
- Native-first capability detection and graceful fallback modes.
- No mandatory third-party QA framework.
- No mandatory Python runtime.
- Unity / Unreal Engine / Godot / generic native workflows.
- AltTester / Airtest / Poco guidance kept optional.
- 81 structured bug patterns plus race/fuzz/shrinking algorithms.
- English and Chinese quick-start documentation.
- GitHub issue/PR templates, CI structure validation, release checklist, FAQ and demo.
- Cross-platform copy helpers for Codex and Claude Code project-local skill layouts.
