# Generic/custom engine workflow

Do not impose a new test stack. First inspect the repository for:

- README/CONTRIBUTING/AGENTS/CLAUDE instructions,
- Makefile/CMake/Gradle/package scripts,
- existing test folders and CI workflows,
- engine launch scripts and command-line flags,
- existing debug/telemetry hooks.

Then use the project's current language/runtime to create the smallest possible QA harness. Examples:

- C/C++: existing unit test target or a tiny executable linked to project code.
- C#: existing test project or project-local console/editor runner.
- Java/Kotlin: existing Gradle test/instrumentation setup.
- JavaScript/TypeScript/web games: existing package scripts/browser test tools if already installed.
- Rust: existing `cargo test` and project binaries.

If no reliable automated control exists for a compiled graphical build, use `BLACKBOX_ASSISTED` rather than downloading a tool automatically.
