# Publishing checklist

Use `docs/RELEASE_CHECKLIST.md` as the main release checklist.

Minimum automated check:

```bash
./scripts/check-structure.sh
```

Before creating `v1.0.0`:

- confirm root `SKILL.md` remains portable,
- confirm core docs do not require Python or a third-party QA adapter,
- confirm optional adapters are clearly optional,
- confirm no local paths, secrets, credentials, generated logs, or game binaries are committed,
- confirm 81 bug IDs are present and unique,
- smoke-test Codex and Claude Code project-local placement,
- configure repository description/topics,
- configure a private security contact or vulnerability-reporting path,
- copy `RELEASE_NOTES_v1.0.0.md` into the GitHub Release body.
