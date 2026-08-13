# FAQ

## Does this install anything?

No by default. The core skill is documentation, structured bug knowledge, templates, and native-engine workflows. It explicitly tells the agent not to install packages, plugins, SDKs, QA frameworks, or MCP servers unless you ask.

## Do I need Python?

No. The public release does not bundle mandatory Python runners. Advanced race/fuzz/shrinking procedures are written as algorithms the coding agent can implement with the project's existing language and runtime.

## Do I need AltTester, Airtest, or Poco?

No for source-based native testing. If one is already installed, the skill may use it as an optional enhancement. A build-only black-box project can benefit from an automation adapter, but the skill will not install one automatically.

## Can it test any Unity project?

It can inspect and plan tests for Unity projects and use native project/engine capabilities when available. The exact automation depth depends on the project's architecture, testability, Unity version, build environment, and whether runtime state can be observed. It does not promise full automation for every project.

## Can it test Unreal and Godot?

Yes through native-first workflows documented in `native/unreal.md` and `native/godot.md`. It reuses existing project tests first and avoids mandatory external QA frameworks.

## Can it test a finished EXE/APK with no source?

Partially. Without a control interface, the skill can analyze logs, screenshots, crashes, configuration, and guide reproducible manual tests (`BLACKBOX_ASSISTED`). Full black-box automation requires an already-available control/automation layer.

## Does it automatically know expected damage, prices, cooldowns, save semantics, or performance targets?

No. Those are project-specific business or design oracles. The agent must derive them from code, tests, configuration, documentation, or explicit user rules. Otherwise it must mark the oracle as unresolved/manual rather than guess.

## Does it guarantee the game is bug-free if tests pass?

No. Passing tests only establish what was tested under the observed conditions. Reports should always list remaining untested areas and capability limits.

## Is it safe for production/live services?

Destructive tests are not. Real-money purchases, production currency mutation, deliberate save corruption, network fault injection, migration tests, account deletion/ban flows, and similar operations require an isolated test environment.

## How should I contribute a new bug pattern?

Include a stable ID, category, prerequisites, trigger, expected invariant/oracle, required evidence, default severity, and false-positive conditions. See `CONTRIBUTING.md` and the issue template.


## Does v1.1 multi-dimensional minimization require a fuzzer or Python package?

No. It is specified as an agent-executable algorithm. The coding agent implements the small amount of candidate generation/replay logic in the project's existing language/runtime when needed. Unity can use C#, Unreal can use project-native C++/Automation infrastructure, Godot can use GDScript/C#, and custom engines can use their current test/runtime tooling.

If the project cannot reliably schedule or measure a timing dimension, the agent reports that limitation and uses a coarser or manual matrix rather than installing extra software.
