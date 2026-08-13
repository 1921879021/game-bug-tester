# Game Bug Tester

![Agent Skill](https://img.shields.io/badge/Agent%20Skill-portable-4C8BF5)
![Mandatory QA dependencies](https://img.shields.io/badge/mandatory%20QA%20dependencies-none-success)
![Bug patterns](https://img.shields.io/badge/bug%20patterns-81-orange)
![License](https://img.shields.io/badge/license-MIT-blue)

**Native-first game QA for Codex, Claude Code, and other Agent Skills-compatible coding agents.**

Game Bug Tester helps a coding agent inspect a game repository, identify high-risk bug classes, generate project-native tests or small QA harnesses, execute what the existing toolchain supports, collect evidence, minimize reproductions, and produce structured bug reports.

> **No mandatory third-party QA framework. No mandatory Python runtime.** You still need the development environment your game already requires.

[中文说明](README.zh-CN.md) · [Quick start](docs/QUICKSTART.md) · [FAQ](docs/FAQ.md) · [Architecture](docs/ARCHITECTURE.md) · [Compatibility](docs/COMPATIBILITY.md)

## Why this exists

Coding agents are increasingly used to build games, but “run the game and look for bugs” is too vague. Game Bug Tester gives the agent a reusable QA playbook:

```text
Detect capabilities
      ↓
Select applicable high-risk bug patterns
      ↓
Choose the strongest available oracle
      ↓
Prefer native engine/project tests
      ↓
Execute + collect evidence
      ↓
Reproduce + minimize
      ↓
Structured bug report + regression recommendation
```

It is a **skill and testing methodology**, not a promise that every arbitrary game executable can be fully controlled with zero setup.

## 60-second start

### Codex

Put this repository at:

```text
<your-game>/.agents/skills/game-bug-tester/
```

Then ask:

```text
Use game-bug-tester on this repository. Detect the engine and existing test capabilities first. Do not install anything. Run a focused P0/P1 bug pass, prefer native engine tests, and report evidence plus anything you could not test.
```

### Claude Code

Put this repository at:

```text
<your-game>/.claude/skills/game-bug-tester/
```

Then invoke:

```text
/game-bug-tester
```

or ask naturally with the same prompt above.

You can also use the optional copy helpers after downloading/cloning this repository:

```bash
./install/install.sh codex /path/to/your-game
./install/install.sh claude /path/to/your-game
```

Windows PowerShell:

```powershell
./install/install.ps1 codex C:\path\to\your-game
./install/install.ps1 claude C:\path\to\your-game
```

These helpers **only copy the skill**. They do not install packages, plugins, SDKs, MCP servers, or QA frameworks.

## What happens on first run

The skill always starts with capability detection and selects one primary mode:

| Mode | Typical environment | New QA install required? | What it can do |
|---|---|---:|---|
| `NATIVE` | Source + existing engine/toolchain | No | Recommended default; native tests/harnesses/logs/state probes |
| `NATIVE_PLUS` | Native + an adapter already present | No new install | Deeper automation using existing optional tooling |
| `BLACKBOX_ASSISTED` | Compiled build only, no control interface | No | Logs/screenshots/crash analysis + guided/manual-assisted testing |
| `BLACKBOX_AUTOMATED` | Build + existing automation/control layer | No new install | Automated black-box interaction where the adapter supports it |

Missing AltTester, Airtest, Poco, Appium, Selenium, Playwright, or an engine MCP must **not** block normal source-based native testing.

## Native engine strategy

- **Unity** — reuse existing tests first; use Unity Test Framework only if already present; otherwise create a small project-local Editor/runtime QA harness and use the existing Unity CLI/batch workflow.
- **Unreal Engine** — prefer existing Automation / Functional / Low-Level tests and Gauntlet where already available; use Unreal's own command-line automation/reporting.
- **Godot** — reuse existing tests/addons when present; otherwise create a project-local GDScript/C# harness and use the existing Godot CLI/headless workflow. Do not auto-install GUT/WAT.
- **Custom/web engines** — reuse the repository's build/test/run commands and generate harnesses in the project's existing language/runtime.

See `native/` for engine-specific guidance.

## What it knows about

The current catalog contains **81 structured bug patterns** covering:

- crash, freeze, black screen, progression blockers,
- navigation, out-of-bounds, collision and physics,
- gameplay/state transitions, combat and character state,
- UI/input and economy/transaction invariants,
- save/load, migration and persistence,
- performance, graphics, animation and audio,
- AI/navigation and projectile behavior,
- multiplayer replication, reconnect, idempotency and host migration,
- race conditions and state-sequence failures.

Advanced procedures include:

- temporal race-window search,
- failure shrinking,
- stateful action-sequence fuzzing,
- sequence shrinking.

These are documented as **agent-executable algorithms** rather than mandatory bundled Python runners.

## Example result

```text
Capability detection
- Engine: Unity
- Source: available
- Existing tests: EditMode + PlayMode
- Optional adapters: none detected
- Mode: NATIVE

Focused P0/P1 pass
- Save round-trip              PASS
- Scene persistence            GAME_FAILURE
- Collision/out-of-bounds      PASS
- Death-state input lock       PASS
- Shop transaction invariant   PASS

Confirmed bug
Quest stage resets from 4 → 0 after Town → Dungeon
Reproduction: 3/3
Evidence: structured state snapshots + native test output
Severity: High / P1
Regression test: recommended

Untested
- Multiplayer race tests: no local multiplayer fixture detected
- Performance budget: no project threshold found
```

See [the full demo transcript](docs/DEMO.md) and [example report](docs/EXAMPLE_REPORT.md).

## Oracle discipline

Game Bug Tester does **not** guess project-specific expectations.

It will not invent:

- weapon damage,
- item prices,
- cooldowns,
- save semantics,
- acceptable FPS/frame-time budgets,
- replication/convergence windows,
- intended AI behavior.

Those must come from source code, existing tests, configuration, design documentation, or explicit user rules. If the expected behavior cannot be established, the skill should return an unresolved/manual oracle instead of a fake `GAME_FAILURE`.

## Safety

Destructive/live-economy tests must stay out of production. Real purchases, production currency mutation, deliberate save corruption, network fault injection, account deletion/ban flows, and migration tests require an isolated local/test environment.

Automation/build/environment failures are classified separately from product defects. Only an observed violation of an established product invariant should become `GAME_FAILURE`.

## Repository map

```text
SKILL.md                 Portable Agent Skill entry point
references/core/         Bug catalog, risk rules, oracles
references/advanced/     Race/fuzz/shrinking procedures
native/                  Native Unity / Unreal / Godot / generic workflows
optional/                Optional adapter guidance only
assets/native/           Tiny project-local harness starters
templates/               Test, contract and bug-report templates
examples/                Prompts and usage examples
docs/                    Quick start, FAQ, architecture, compatibility
evals/                   Skill behavior evaluation cases
.github/                  CI + contribution templates
```

## Contributing

Contributions are welcome, especially:

- reusable bug patterns with strong oracles,
- native Unity/Unreal/Godot recipes,
- better zero-install fallbacks,
- small reproducible game fixtures/evals,
- optional adapter improvements that remain optional.

A contribution must not make a new third-party runtime or QA framework mandatory for basic use. See [CONTRIBUTING.md](CONTRIBUTING.md).

## Release and repository setup

Maintainers can use:

- [GitHub setup](docs/GITHUB_SETUP.md)
- [Release checklist](docs/RELEASE_CHECKLIST.md)
- [v1.0.0 release notes](RELEASE_NOTES_v1.0.0.md)

## License

MIT. See [LICENSE](LICENSE).
