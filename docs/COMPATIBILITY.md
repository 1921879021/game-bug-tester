# Compatibility

## Agent hosts

The root `SKILL.md` uses only the common Agent Skills core metadata (`name`, `description`) and standard supporting files so it is portable across Codex and Claude Code.

- Codex project scope: `.agents/skills/game-bug-tester/`
- Claude Code project scope: `.claude/skills/game-bug-tester/`

## Engine expectations

| Engine | Core mode | Mandatory extra QA tool |
|---|---|---|
| Unity | Native source/CLI/harness | None |
| Unreal | Native Automation/CLI/Gauntlet where available | None |
| Godot | Native CLI/project-local harness | None |
| Custom/source | Existing toolchain/runtime | None |
| Build-only graphical game | Assisted unless control adapter exists | None for assisted mode |

“None” means no *Game Bug Tester-specific* install. The game’s own engine/toolchain is still required to compile or run its project.
