# Multi-Dimensional Counterexample Minimization

Knowledge baseline: **v3.5**

## Goal

A failing game test often contains much more than the defect actually needs:

- too many actions,
- extra clients/actors,
- oversized or arbitrary parameters,
- unnecessary waits,
- a narrow timing relationship,
- unrelated scene or session setup.

V3.5 combines the temporal search ideas from v3.3 with stateful sequence shrinking from v3.4. The objective is to turn a complicated failing run into a **small, stable, evidence-preserving counterexample** that a developer can reproduce and convert into a regression test.

The core procedure is an algorithm for the coding agent. It does **not** require Python, a special fuzzer, or a third-party QA framework.

## Counterexample model

Represent the reproducer as a structured object:

```yaml
sequence:
  - executor: client_a
    action: kill_player
    params: {}
    timing:
      after_previous_ms: 0

  - executor: client_a
    action: claim_death_reward
    params:
      reward_id: death_reward
    timing:
      after_previous_ms: 0

  - executor: server
    action: disconnect_client
    params:
      client_id: client_a
    timing:
      after_previous_ms: 8

oracle:
  failure_signature: reward_grant_at_most_once
```

The dimensions that may be simplified are:

1. **Action set** — delete actions or whole chunks.
2. **Action order** — simplify or search ordering inside explicitly declared reorderable groups while preserving hard dependencies.
3. **Executor/actor set** — reduce the number of clients/agents when the same failure remains.
4. **Parameters** — simplify numeric, enum, boolean, collection, vector, string, and identifier parameters using declared safe domains.
5. **Timing** — remove waits, move offsets toward simpler values, search PASS/FAIL boundaries, and find a stable reproduction point.
6. **Environment perturbation** — reduce latency/loss/jitter/fault magnitude only when the contract declares that dimension safe to vary.

Do not mutate dimensions that are not declared shrinkable.

## Preservation predicate

A candidate counterexample is accepted only when all of the following hold:

- it is valid for the game/project preconditions;
- the test itself executes successfully enough to produce a product verdict;
- it triggers the **same failure signature** as the baseline;
- repeated runs meet the configured failure-rate threshold;
- measured timing error stays within the configured tolerance for timing-sensitive cases;
- the candidate does not introduce a more severe unrelated failure that masks the original defect.

`BUILD_FAILURE`, `AUTOMATION_FAILURE`, `ENVIRONMENT_FAILURE`, and invalid timing trials do not count as preserved product failures.

## Optimization objective

Use a lexicographic objective unless the project contract overrides it:

1. fewer actions;
2. fewer distinct actors/executors;
3. fewer explicit non-default parameters;
4. simpler parameter values;
5. fewer timing constraints;
6. wider stable timing window;
7. offsets closer to zero or project defaults when equally stable.

This intentionally prefers a **human-usable stable reproducer** over a fragile one that requires an unnecessarily exact microsecond-scale schedule.

## Phase A — confirm the baseline

Before minimizing anything:

1. save build/commit/engine version;
2. save the original sequence, parameters, requested timing, actual timing, and environment;
3. run the baseline for `baseline_repeats`;
4. identify one stable `failure_signature`;
5. stop if the failure cannot be reproduced at the configured threshold.

Do not shrink a one-off unexplained failure as though it were deterministic.

## Phase B — sequence ddmin

Apply chunk deletion first because action count usually dominates reproduction complexity:

1. split the sequence into chunks;
2. remove each chunk candidate;
3. replay;
4. keep the deletion only if the preservation predicate holds;
5. increase granularity until no chunk can be removed;
6. do single-action cleanup.

Preserve required setup/actions that cannot be regenerated safely.

## Phase C — order simplification/search

Do **not** arbitrarily permute the whole trace. Use a declared partial-order contract.

The contract can define:

- hard `must_precede` dependencies that may never be violated;
- same-actor ordering that the real game/runtime naturally enforces;
- small reorderable groups where adjacent swaps or bounded permutations are legal;
- actions whose order may be relaxed into concurrency/race testing.

A safe bounded strategy is:

1. keep all hard dependencies;
2. try adjacent swaps inside each reorderable group;
3. keep a new order only if it preserves the same failure signature;
4. prefer the canonical/simple order declared by the project when several orders fail equally;
5. if the failure survives multiple legal orders, report that the exact order is **not** required;
6. if only one order preserves the defect, keep that order as part of the minimal trigger.

For large groups, do not enumerate factorial permutations. Use pairwise swaps, dependency-aware topological candidates, or a project-provided small candidate set.

## Phase D — actor/executor reduction

When the contract marks an actor dimension shrinkable:

- try replacing secondary clients with the primary client where semantics allow;
- remove observers that do not affect the oracle;
- reduce an N-agent crowd toward the smallest N that still triggers the same failure;
- never collapse actors when identity, ownership, authority, or concurrency is part of the failure semantics.

Example: a simultaneous unique-claim defect generally cannot be reduced from two claimants to one.

## Phase E — parameter simplification

Only shrink through declared domains/ladders.

### Numeric parameters

Prefer candidates such as:

```text
current
→ nearest declared boundary
→ default
→ 1
→ 0
```

The exact ladder must respect the parameter's type and valid range.

For quantities, `1` is often a useful simple value. For signed offsets, `0` is often useful. For damage/currency, do not invent valid values: derive them from project code/config or a contract.

### Enum/boolean parameters

Try:

- project default,
- simplest declared enum,
- false/true only when both are valid.

### Collections

Use ddmin-style removal of elements, then simplify remaining elements.

### Vectors/positions

Shrink components independently only inside declared legal/nav/collision regions. Prefer project landmarks, spawn points, integer coordinates, or other stable references over arbitrary floating-point coordinates.

### Strings/IDs

Do not blindly shorten production identifiers. Only reduce values when the contract defines synthetic/test IDs or a safe equivalence class.

## Phase F — timing minimization

For timing-sensitive failures:

1. remove unnecessary waits;
2. test zero offset where valid;
3. coarse-scan the declared range if the failure window is unknown;
4. locate PASS/FAIL boundaries;
5. bisect boundaries to the configured resolution;
6. repeat points inside the candidate window;
7. report both:
   - the observed failure window,
   - a recommended stable reproduction point.

Always record **actual monotonic timing**, not just requested delay.

Trials whose timing error exceeds `timing_tolerance_ms` are invalid evidence, not product PASS/FAIL.

## Phase G — environment simplification

If the failure was found with network/physics/load perturbation and the dimension is explicitly shrinkable:

- decrease packet loss,
- decrease latency/jitter,
- reduce agent count,
- reduce spawn rate,
- reduce repeated operations,
- remove unrelated fault injection.

The smallest perturbation that preserves the same defect is often highly diagnostic.

Do not inject faults against production/live services.

## Phase H — fixed-point cross-dimensional pass

Dimensions interact. A parameter reduction can make another action removable; deleting an action can make a wait unnecessary.

Therefore repeat:

```text
sequence
→ order
→ actor
→ parameter
→ timing
→ environment
```

until a full pass produces no strictly better preserved candidate or the evaluation budget is exhausted.

## Phase I — final confirmation

Re-run the final candidate for `confirmation_repeats`.

Report:

- original vs minimized action count;
- original vs minimized actor count;
- ordering constraints that were removed, changed, or proven necessary;
- parameters changed and their original/minimized values;
- original timing conditions;
- observed stable failure window;
- recommended replay point;
- exact failure signature;
- failure count / valid repetitions;
- timing-invalid trial count;
- build/commit/engine version;
- any dimensions not minimized and why.

## Pseudocode

```text
best = confirm(original)

best = shrink_sequence(best)

repeat
    changed = false

    for reducer in [
        shrink_order,
        shrink_actors,
        shrink_parameters,
        shrink_timing,
        shrink_environment,
        shrink_sequence
    ]:
        candidate = reducer(best)

        if preserves_same_failure(candidate)
           and complexity(candidate) < complexity(best):
            best = candidate
            changed = true

until not changed or budget_exhausted

confirm(best)
emit_minimal_repro(best)
```

## Flaky defects

For nondeterministic failures, use repeated trials.

A candidate should only replace the current best when:

```text
failures / valid_trials >= preserve_fail_rate
```

and the same signature dominates. Record the raw counts. A Wilson interval may be reported when convenient, but the skill must not require a statistics package.

## Native-first execution

Implement this procedure using what the project already has:

- Unity: C# test/harness code, coroutines/frames, project state hooks, Unity CLI.
- Unreal Engine: C++/Automation/Functional tests, latent commands/timers, engine logs.
- Godot: GDScript/C# harnesses, `await` timers/frames, headless CLI.
- Custom engines: the project's existing language, test runner, build/run scripts, and clocks.

If the project cannot schedule or measure a requested timing precision, report that capability limit and use a coarser search. Do not install a timing/fuzzing framework just to satisfy this procedure.

## Safety

Minimization may repeatedly execute state mutations. Therefore:

- run destructive purchase/save/network corruption tests only in isolated test environments;
- reset fixtures between candidates;
- use synthetic/test accounts and IDs;
- cap evaluation counts;
- stop on environment instability;
- do not optimize by making a production-side action more destructive.

## What “minimal” means

The result is a practically minimal counterexample under:

- the declared candidate domains,
- the available engine/toolchain,
- the evaluation budget,
- the preservation threshold,
- the observed nondeterminism.

It is not a formal proof of the globally smallest possible reproducer.

A machine-readable result can use `templates/minimization-report.yaml`.
