# Quick start

Game Bug Tester is a repository-local Agent Skill. It does not require a mandatory Python runtime or third-party QA framework.

## 1. Put the skill in your project

### Codex

Copy this repository to:

```text
<your-game>/.agents/skills/game-bug-tester/
```

### Claude Code

Copy this repository to:

```text
<your-game>/.claude/skills/game-bug-tester/
```

You may use the optional copy helper after downloading/cloning this repository:

```bash
./install/install.sh codex /path/to/your-game
./install/install.sh claude /path/to/your-game
```

Windows PowerShell:

```powershell
./install/install.ps1 codex C:\path\to\your-game
./install/install.ps1 claude C:\path\to\your-game
```

The helper only copies the skill. It does not install packages, plugins, SDKs, or QA frameworks.

## 2. Ask for a focused pass first

Recommended first prompt:

```text
Use game-bug-tester on this repository. Detect the engine and existing test capabilities first. Do not install anything. Run a focused P0/P1 bug pass, prefer native engine tests, and report evidence plus anything you could not test.
```

## 3. Review capability detection

Before changing files or starting long tests, the agent should report one primary mode:

- `NATIVE`
- `NATIVE_PLUS`
- `BLACKBOX_ASSISTED`
- `BLACKBOX_AUTOMATED`

If you have source plus the normal engine/toolchain, `NATIVE` is the expected default.

## 4. Let the agent create the smallest useful harness

The skill should reuse existing tests whenever possible. If a temporary QA harness is needed, it should be project-local, small, easy to review, and removable after the run.

## 5. Read the report

A useful result includes:

- engine and selected mode,
- tests selected and why,
- tests executed,
- confirmed/suspected failures,
- evidence,
- exact reproduction steps,
- severity/priority,
- regression-test recommendation,
- untested areas and capability limits.

## Do I need AltTester, Airtest, Poco, or Python?

No for normal source-based use. Those are optional enhancements only. A compiled build with no source and no control interface cannot be fully automated by a coding agent; in that case the skill degrades to `BLACKBOX_ASSISTED` rather than installing tools behind your back.


## v1.1: ask the agent to minimize a failing reproducer

Example:

```text
Use game-bug-tester to minimize this failing reproduction. Preserve the same failure signature. Reduce unnecessary actions, parameters and timing constraints. Use only the project's existing engine/toolchain and do not install anything.
```

If the failure is timing-sensitive, ask for both the observed failure window and a stable replay point. If the current environment cannot measure the requested precision, the agent must say so instead of installing a timing tool.
