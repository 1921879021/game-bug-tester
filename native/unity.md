# Unity native workflow (no third-party QA install)

## Detect

Look for `ProjectSettings/ProjectVersion.txt`, `Packages/manifest.json`, `Assets/`, `.asmdef`, and existing test assemblies.

## Execution order

1. Reuse project tests first.
2. Check whether `com.unity.test-framework` is already present in the project/package lock.
3. If present, create focused EditMode/PlayMode tests and run them from the Unity command line.
4. If absent, **do not add it automatically**. Create a temporary Editor script under an obvious QA folder and invoke a static entry point with Unity `-batchmode -executeMethod`.
5. For runtime-only behavior, add isolated QA hooks to a development/test build, run the existing game, and verify structured state/logs.

## Useful native commands

When Unity Test Framework is already present, the agent can use the project's Unity executable with arguments such as `-runTests`, `-batchmode`, `-projectPath`, `-testResults`, and `-testPlatform`.

When it is not present, use a project-local Editor entry point and Unity batch mode, for example conceptually:

```text
Unity -batchmode -quit -projectPath <project> -executeMethod GameBugTester.EditorRunner.Run -logFile <log>
```

Do not assume the Unity executable path. Discover it from the environment, project docs, CI, Unity Hub/editor installation, or ask the user if necessary.

## What to test natively

- Scriptable business rules: damage, cooldown, inventory, economy, quests.
- Scene/prefab/reference integrity.
- Colliders, layers, tags, Rigidbody settings, bounds and spawn positions.
- Save/load serialization and migrations using project APIs.
- AI/NavMesh state using project and Unity APIs.
- PlayMode state transitions.
- Build/editor/player logs and exceptions.

## Temporary harness policy

Prefer a path such as `Assets/GameBugTesterGenerated/`. Keep generated files small and removable. Do not overwrite production scripts merely to make a test pass. Report every file added/changed.

A tiny optional harness starter is in `assets/native/unity/`.
