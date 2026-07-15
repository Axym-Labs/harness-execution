# Harness Execution Skills

Execution-oriented skills for the Harness, kept outside the core
configuration repository so execution policy can evolve as a coherent
extension.

## Skills

| Source Skill | Visible Runtime Name | Purpose |
| --- | --- | --- |
| `execution` | `exec-execution` | Primary implementation, project directives, task ordering, validation, continuation, and milestone workflow. |
| `entrypoint` | `exec-entrypoint` | Enter the suite: select lifecycle, capabilities, and escalation policy. |
| `supervising` | `exec-supervising` | Establish ownership, reporting routes, and independent acceptance. |
| `autoresearch-loop` | `exec-autoresearch-loop` | Explore scientific premise-testable ideas or blind downstream-search candidates reproducibly. |
| `initiation` | `exec-initiation` | Establish lean project-local specification and scaffolding. |
| `wrapup` | `exec-wrapup` | Clean, validate, document, package artifacts, and recommend publication paths. |
| `publish-work` | `exec-publish-work` | Placeholder for publication and visibility work on completed projects. |
| `web-design-guidelines` | `exec-web-design-guidelines` | Review UI code against web interface guidelines. |

`single-step-execution` is intentionally omitted: narrow work is covered
directly by `execution` plus `supervising`, and the
former skill contained no domain-specific guidance.

Each coherent project objective uses a selected task-arc directory with
required `spec.md` and `progress.md`; `initiation` owns the placement rule.
Delegated workers currently report through one worker-owned `worker-report.md` file; Harness
verifies it before recording accepted progress. A live OpenClaw
`sessions_send` round trip on May 26, 2026 skipped
delivery, so session-message reporting remains conditional on a later
successful runtime test.

## Integration

The `harness-primary` repository generates full-content namespaced runtime copies
from this sibling checkout and loads those through OpenClaw's
`skills.load.extraDirs` setting. This repository stores no credentials or
project-specific output.
