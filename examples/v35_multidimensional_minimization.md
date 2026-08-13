# v3.5 example — minimizing a complex reconnect reward failure

This example is intentionally tool-agnostic. A coding agent should implement it with the project's existing engine/runtime.

## Initial failing trace

```text
1. open death screen
2. toggle stats panel
3. kill player
4. wait 120 ms
5. claim death reward (quantity=3)
6. switch spectator camera
7. disconnect client_a after 12 ms
8. wait 20 ms
9. reconnect client_a
10. close stats panel
11. claim death reward again (quantity=3)
12. switch scene
```

Observed invariant failure:

```text
reward_grants = 2
expected <= 1
failure_signature = reward_grant_at_most_once
```

## Possible minimized result

```text
1. kill player
2. claim death reward (quantity=1)
3. disconnect client_a
4. reconnect client_a
5. claim death reward again (quantity=1)
```

If timing matters, the report additionally states the measured failure window and a stable replay point. If timing does **not** matter after sequence reduction, the timing constraint should be removed entirely.

## Why this is useful

The developer receives:

- fewer actions,
- simpler parameters,
- only required actors,
- only required timing constraints,
- the same failure signature,
- a measured reproduction rate.

The agent must not claim that this exact minimized trace applies to every game. It is an example of the algorithm.
