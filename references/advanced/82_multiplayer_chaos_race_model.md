# Multiplayer Chaos / Race Model (v3.2)

## Purpose

Sequential multiplayer tests often miss defects that only appear when two valid operations overlap. V3.2 therefore treats **relative timing** as an explicit test dimension.

## Model

A race case defines:

- authoritative invariant;
- participating executors;
- branch operations;
- relative offset sweep;
- repeat count / optional seed;
- valid terminal states;
- evidence requirements.

`race_action` uses a common barrier and schedules each branch relative to the same monotonic epoch. Negative offsets are normalized so the earliest branch starts at zero while preserving relative order.

## Result validity

A trial is useful only when process/driver health is good and the measured timing falls within the test's tolerance. If a branch fails to execute because a driver/process died, classify it as environment/tool failure, not product failure.

## Preferred Oracles

1. server ledger / authoritative state;
2. exactly-once counters keyed by request/business id;
3. ownership cardinality;
4. allowed complete terminal-state set;
5. client convergence after the authority invariant has been verified.

## Safety

Race injection is only permitted in explicit QA/test environments. Never automate real purchases, production inventories, destructive account actions, or live-service fault injection without an isolated test contract.
