# Sequence Shrinking

V3.4 reduces a failing action sequence with a ddmin-style algorithm.

## Preservation predicate

A candidate is accepted only when:

- it reaches a valid product verdict,
- it fails with the **same invariant signature** as the original sequence,
- repeated runs meet `preserve_fail_rate`.

This prevents a shorter but unrelated crash from replacing the original business-consistency failure.

## Phases

1. Remove chunks.
2. Try smaller complements/chunks when useful.
3. Increase granularity until no chunk can be removed.
4. Single-action cleanup to approach 1-minimality.
5. Re-run the final result for `confirmation_repeats`.

The output is a practically minimal reproducer under the configured oracle and repeat threshold. It is not a formal proof of global minimality in a nondeterministic game.
