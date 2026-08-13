# Stateful Sequence Fuzzing

V3.4 generates **operation sequences**, not only input values. The generator maintains an abstract model to filter obviously impossible actions, while the product oracle is always evaluated from runtime probes.

## Three layers

1. **Action grammar**: operation id, executor, weight, preconditions, parameters.
2. **Abstract effects**: normal-design model used only for generation guidance.
3. **Runtime invariant**: actual server/client snapshot used for PASS/FAIL.

This separation is important: if the implementation contains a bug, its runtime state may diverge from the abstract model. The fuzzer should still discover that divergence rather than updating the model to imitate the bug.

## Generation strategy

The included engine uses a seeded, coverage-guided random walk. It boosts never-seen actions and never-seen adjacent action transitions, while respecting declared preconditions. This is intentionally simple and auditable; projects may replace it with Hypothesis RuleBasedStateMachine, custom model-based testing, or a domain-specific searcher while keeping the same invariant/report format.

## Reset requirement

Every trial and every shrink candidate must start from a deterministic baseline. If a game cannot reset the relevant account/session/world state, automatic sequence minimization is unsafe because two candidate sequences are no longer comparable.
