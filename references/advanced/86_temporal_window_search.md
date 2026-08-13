# Adaptive Temporal Race-Window Search

## Problem

A fixed matrix such as `-15 / 0 / +15 ms` can prove a known race, but it may miss a defect whose failure window is only a few milliseconds wide.

V3.3 treats relative branch offset as a searchable input:

1. coarse scan the declared range;
2. repeat each point to estimate failure probability;
3. find neighboring PASS/FAIL observations;
4. bisect those boundaries;
5. confirm a stable point inside the failure window;
6. emit a replayable minimal counterexample.

## Timing evidence

The requested offset is not assumed to equal the actual thread start offset. Each `race_action` records actual monotonic timestamps, derives the signed relative start offset and reports `offset_error_ms`.

A trial with timing error larger than `timing_tolerance_ms` is excluded from product statistics. This is a test-quality failure, not a product failure.

## Non-contiguous windows

Race defects may have multiple windows. For example, one interleaving can break at `+8 ms`, another at `+70 ms`. The report therefore keeps a list of candidate windows rather than forcing one interval.
