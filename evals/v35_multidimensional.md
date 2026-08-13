# v3.5 synthetic minimization evaluation

This is a deterministic specification/evaluation case, not a mandatory runtime.

## Seed counterexample

A synthetic reconnect/reward failure starts with 12 actions containing unrelated UI/camera/scene operations. The required business failure signature is:

```text
reward_grant_at_most_once
```

The synthetic preservation rule requires:

- `kill_player`
- first `claim`
- `disconnect`
- `reconnect`
- second `claim`

in that order, with the effective claim→disconnect delay inside `6..12 ms`.

Both claim quantities start at `3`.

## Expected v3.5 result

Sequence minimization should be able to reduce the 12-action seed to:

```text
kill_player
claim(quantity=1)
disconnect
reconnect
claim(quantity=1)
```

Parameter minimization should reduce both quantities from `3` to `1`.

Timing search should identify an observed synthetic failure window of:

```text
6..12 ms
```

The exact order remains necessary in this fixture. Swapping `claim` and `disconnect` must not be accepted because it no longer preserves the same failure signature.

## Zero-dependency expectation

A coding agent should implement the replay/minimization logic in the project's existing runtime. This eval must not cause the skill to request Python, a fuzzer package, or an external automation framework.
