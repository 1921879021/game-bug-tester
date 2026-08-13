# Example prompts

## Quick risk pass

> Use game-bug-tester on this repository. Do not install anything. Detect the engine, choose the 10 highest-risk applicable bug tests, run what can be tested natively, and report evidence and gaps.

## Save/load

> Test save/load and scene-transition persistence. Use only the project’s existing toolchain. Add a regression test for every confirmed bug.

## Physics/gameplay

> Find high-risk collision, out-of-bounds, dash/jump, death-state, and cooldown bugs. Prefer deterministic engine-native tests over visual guessing.

## Multiplayer

> Review and test reconnect, duplicate reward, simultaneous claim, state convergence, and host-migration risks. Do not touch production services.
