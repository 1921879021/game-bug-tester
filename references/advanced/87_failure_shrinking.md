# Failure Shrinking for Race Tests

V3.3 borrows the **counterexample shrinking** idea from property-based testing and the **failure-inducing input minimization** idea from Delta Debugging.

The implementation is intentionally narrow: it shrinks the **relative timing parameter** for an already-defined race case. It does not claim to be a general-purpose Delta Debugger.

## Shrink objectives

- Narrow PASS/FAIL boundary uncertainty.
- Prefer a failing offset with smaller absolute magnitude when it remains the same failure signature.
- Separately keep a stable in-window reproduction point with a measured reproduction rate.

Why two outputs? A point closest to the boundary may be the simplest counterexample but can be flaky. A point deeper inside the window is usually better for developer reproduction and regression tests.

## Statistical evidence

The report includes `failures / valid_trials`, failure rate and a Wilson 95% interval. This prevents a single lucky failure from being presented as a stable race window.
