# Claw Execution Skills

Execution-oriented skills for the Kimi-Claw harness, kept outside the core
configuration repository so execution policy can evolve as a coherent
extension.

## Skills

| Skill | Purpose |
| --- | --- |
| `execution-guidance` | Select lifecycle, execution pattern, interaction modifiers, and escalation policy. |
| `supervising-delegated-work` | Establish ownership, reporting routes, and independent acceptance. |
| `multi-step-execution` | Manage milestone-based delegated implementation. |
| `metric-multi-step-execution` | Run controlled metric-driven optimization loops. |
| `project-initiation` | Establish lean project-local specification and scaffolding. |
| `project-iteration` | Resume and improve existing project work. |
| `project-wrapup` | Clean, validate, document, package artifacts, and recommend publication paths. |

`single-step-execution` is intentionally omitted: narrow work is covered
directly by `execution-guidance` plus `supervising-delegated-work`, and the
former skill contained no domain-specific guidance.

Delegated workers currently report through one worker-owned
`docs/worker-report.md` file; Claw verifies it before recording accepted
progress. A live OpenClaw `sessions_send` round trip on May 26, 2026 skipped
delivery, so session-message reporting remains conditional on a later
successful runtime test.

## Integration

The `kimi-claw` repository loads `skills/` from this sibling checkout through
OpenClaw's `skills.load.extraDirs` setting. This repository stores no
credentials or project-specific output.
