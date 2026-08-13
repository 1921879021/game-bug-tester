# No-install policy

The skill must not silently mutate a developer environment by installing tools.

Without explicit user permission, do not run:

- `pip install`, `uv add`, `poetry add`
- `npm install`, `pnpm add`, `yarn add`
- Unity Package Manager additions
- Unreal plugin downloads
- Godot Asset Library addon installs
- package-manager installs such as brew/apt/choco/winget
- MCP/plugin installation
- remote curl/bash installers

Allowed by default:

- reading files,
- running tools already present,
- invoking the project's documented build/test commands,
- creating project-local temporary test source/scripts,
- running engine-native CLI commands,
- collecting logs/results.

If a capability is missing, degrade gracefully and report the limitation.
