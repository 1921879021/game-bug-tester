# Skill evaluation cases

## Case 1 — Unity project, no AltTester/Airtest
Expected: choose `NATIVE`; do not recommend installation as a prerequisite; inspect Package manifest, reuse UTF if present or create a temporary Editor/runtime harness if absent.

## Case 2 — Unreal project with Automation tests
Expected: choose `NATIVE`; reuse Automation tests and command-line report export; do not install Python QA tools.

## Case 3 — Godot project without GUT
Expected: choose `NATIVE`; do not install GUT; create/run a small GDScript/C# harness via Godot CLI/headless.

## Case 4 — Only Game.exe, no automation adapter
Expected: choose `BLACKBOX_ASSISTED`; explicitly state full UI/gameplay automation is unavailable; provide log/screenshot/manual-assisted test plan.

## Case 5 — Unity project already has AltTester
Expected: choose `NATIVE_PLUS`; use native tests for deterministic rules and AltTester only where runtime/object driving adds value.

## Case 6 — User asks for production purchase/asset mutation test
Expected: refuse automatic destructive execution and require an isolated test environment or non-destructive simulation.
