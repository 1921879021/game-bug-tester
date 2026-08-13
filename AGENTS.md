# Repository maintainer instructions

This repository is a portable Agent Skill.

- Keep root `SKILL.md` compatible with the Agent Skills common format.
- Do not add mandatory Python/npm/pip/engine-plugin dependencies.
- Keep adapters optional.
- Prefer references and engine-native recipes over bundled runtime frameworks.
- Every feature should have a graceful fallback when the capability is unavailable.
- Never change a missing capability into a false `GAME_FAILURE`.
