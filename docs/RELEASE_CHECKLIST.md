# Release checklist

## Repository

- [ ] Repository name and description are set.
- [ ] Topics are configured.
- [ ] `README.md` renders correctly on GitHub.
- [ ] `README.zh-CN.md` language link works.
- [ ] `LICENSE`, `SECURITY.md`, `CONTRIBUTING.md`, and `CODE_OF_CONDUCT.md` are present.

## Skill compatibility

- [ ] Root `SKILL.md` contains portable frontmatter.
- [ ] Codex project-local placement is documented.
- [ ] Claude Code project-local placement is documented.
- [ ] Core behavior does not require Python or a third-party QA framework.
- [ ] Missing optional adapters do not block `NATIVE` mode.

## Knowledge and safety

- [ ] Bug catalog IDs are unique.
- [ ] Bug count is expected.
- [ ] No business oracle is hard-coded without a project contract.
- [ ] Production-destructive test restrictions are documented.
- [ ] Build/tool/environment failures are not classified as `GAME_FAILURE`.

## GitHub hygiene

- [ ] Validation workflow passes.
- [ ] Issue templates render.
- [ ] Pull request template renders.
- [ ] No local paths, credentials, generated logs, or binaries are committed.
- [ ] Release notes are ready.
- [ ] Tag `v1.1.0` only after the final commit passes CI.
