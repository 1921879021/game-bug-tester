# GitHub repository setup

Recommended repository name:

```text
game-bug-tester
```

Recommended description:

```text
Open Agent Skill for Codex, Claude Code, and compatible coding agents to test Unity, Unreal, Godot, and custom game projects for common bugs — native-first, with no mandatory third-party QA framework.
```

Recommended topics:

```text
agent-skills
game-development
game-testing
qa
automated-testing
codex
claude-code
unity
unreal-engine
godot
bug-testing
software-testing
```

Recommended repository settings:

- Enable Issues.
- Enable Discussions after there is enough community traffic.
- Keep Actions enabled so `.github/workflows/validate.yml` can validate pull requests.
- Protect the default branch once external contributors begin submitting PRs.
- Require the `validate-skill` check before merge when branch protection is enabled.
- Add a private security contact before inviting public vulnerability reports.

## Suggested About panel

**Description**

> Open Agent Skill for systematic game bug testing with Codex, Claude Code, and compatible coding agents.

**Website**

Leave blank initially unless the project gets a documentation site.

## Social preview

A social preview image is useful but not required for v1.0.0. If you add one later, keep it simple:

- project name: `Game Bug Tester`
- subtitle: `Native-first game QA for coding agents`
- small callouts: `Unity · Unreal · Godot · Custom`
- avoid claims such as “finds every bug” or “works on every executable with zero setup”
