# Contributing

Contributions are welcome.

The core compatibility rule is simple:

> **A contribution must not make a new third-party runtime or QA framework mandatory for basic source-based use.**

## Good contributions

- new reusable bug patterns with strong, falsifiable oracles,
- native Unity / Unreal / Godot recipes,
- better safe fallbacks for build-only testing,
- small reproducible examples or eval fixtures,
- improved evidence/reporting guidance,
- optional adapter docs that remain optional,
- tests proving the skill does not overclaim capabilities.

## New bug pattern checklist

Include:

1. stable ID and category,
2. prerequisites,
3. trigger/test action,
4. expected invariant/oracle,
5. evidence needed to confirm the failure,
6. default severity,
7. known false-positive conditions,
8. any safety restrictions.

Do not add a pattern that can only be “detected” through a vague visual guess when a stronger structured oracle is normally available.

## Pull requests

Before opening a PR:

```bash
./scripts/check-structure.sh
```

Windows maintainers can run:

```powershell
./scripts/check-structure.ps1
```

Also review `docs/RELEASE_CHECKLIST.md` when changing public compatibility, install behavior, or release structure.
