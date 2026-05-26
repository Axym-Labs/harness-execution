---
name: metric-multi-step-execution
description: Metric-driven experiment loop with controlled keep or discard decisions.
---

# Metric Multi-Step Execution

## Purpose

Run controlled optimization experiments through a delegated coding worker while
Claw evaluates evidence and preserves reproducibility.

## Setup

Create `.claw-autoresearch.md` with the target file, experiment command,
metric name/parser/direction, time budget, and read-only files. Before any
experiment, record a clean baseline and use a dedicated experiment branch or
worktree so existing user changes cannot be discarded.
Apply `supervising-delegated-work` when dispatching the experiment worker.

## Loop

1. Define one change and its expected metric effect.
2. Dispatch the experiment worker under the supervision contract. The worker
   makes that change, runs the specified experiment, and records the measured
   result in the worker-owned `docs/worker-report.md` handoff unless a tested
   bidirectional session route has been configured.
3. Arrange the configured completion route and return from an interactive
   initiating turn while the experiment runs.
4. When the result arrives, inspect it, compare it with the baseline, log the
   decision in `.claw/experiments/results.tsv`, and record accepted durable
   progress in `docs/progress.md` if useful.
5. Keep an improved change by committing it. Discard a non-improving change
   only inside the dedicated clean experiment branch/worktree and only after
   confirming there are no unrelated modifications.
6. Repeat with one controlled change at a time until the budget is exhausted
   or progress no longer warrants further runs.

## Rules

1. One controlled intervention per experiment.
2. Record baseline, metric, outcome, and keep/discard decision for every run.
3. Respect configured read-only files and time budgets.
4. Never destroy existing user work when discarding an experiment.
5. Report meaningful results, crashes, and diminishing returns.
