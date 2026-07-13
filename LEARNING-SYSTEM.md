# Learning and Evidence System

This repository is not a reading checklist. It is a system for turning study into demonstrated capability.

## The Outcome

A learner is ready for professional work when they can repeatedly:

- translate an unclear business problem into a data product;
- build a correct and reproducible path from source to decision;
- detect and recover from failure;
- explain tradeoffs to technical and non-technical people; and
- show evidence that the result improved speed, quality, cost, risk, or decisions.

Knowing a definition is useful. Producing trusted evidence is mastery.

## The Weekly Operating Rhythm

Use a six-to-eight-hour week if you are studying part-time.

| Activity | Time | Required evidence |
| --- | ---: | --- |
| Learn one concept | 60–90 min | Notes in your own words plus one counterexample |
| Deliberate practice | 90 min | SQL, code, model, or design exercise |
| Build a vertical slice | 2–3 hr | Source → transformation → validated output |
| Break and recover | 45–60 min | Failure injected, diagnosis recorded, rerun proven |
| Business review | 30–45 min | Decision, user, metric, limitation, and next experiment |
| Retrieval and explanation | 30 min | Five closed-book questions plus a five-minute explanation |

## Evidence Gates

Do not advance because a tutorial is finished. Advance when the gate is passed.

| Gate | You must demonstrate |
| --- | --- |
| 1 — Understand | Explain the concept without notes and identify when not to use it |
| 2 — Build | Produce a working, reproducible implementation |
| 3 — Verify | Test expected behavior, bad inputs, and business invariants |
| 4 — Operate | Diagnose a failed run, recover, and document the procedure |
| 5 — Decide | Explain tradeoffs in reliability, latency, complexity, security, and cost |
| 6 — Impact | Connect the output to a user decision and measure or estimate value honestly |

Passing Gates 1–2 means exposure. Gates 1–4 indicate practical capability. Gates 1–6 create portfolio-grade evidence.

## Required Project Evidence

Every serious project should contain:

1. A one-paragraph problem statement naming the user and decision.
2. Baseline: how the work happens today and what it costs in time, errors, delay, or risk.
3. Source contract: ownership, grain, schema, cadence, quality expectations, and sensitive fields.
4. Architecture and data model with reasons for major choices.
5. Reproducible setup and a single documented run command.
6. Tests for technical rules and business invariants.
7. Operational evidence: logs, freshness, row counts, failure behavior, and a runbook.
8. Security, privacy, cost, and retention notes proportional to the project.
9. Before/after impact or a clearly labelled hypothesis when real users are unavailable.
10. A short demo and retrospective: what failed, what changed, and what you would build next.

## Three Passes Through the Repository

### Pass 1 — Reliable foundations

Focus on SQL, PostgreSQL, Python, files, APIs, modeling, Git, tests, and one local Docker-based pipeline. Avoid advanced platforms until you can rerun and debug the simple system.

Exit evidence: one end-to-end batch project that is reproducible, idempotent, tested, and documented.

### Pass 2 — Production and analytics

Add dimensional modeling, dbt-style transformations, orchestration, quality checks, observability, CI, deployment, security, and cost awareness.

Exit evidence: one warehouse or operational data product with an owner, service expectations, alerts, and a runbook.

### Pass 3 — Scale and AI readiness

Study cloud, distributed processing, streaming, retrieval data, semantic interfaces, evaluation datasets, and governance only where the use case needs them.

Exit evidence: one justified advanced design or implementation that compares a simpler alternative and measures the relevant tradeoff.

## Retrieval Questions for Any Topic

Answer these without notes:

1. What problem does this concept solve?
2. What assumptions must be true?
3. What are the failure modes?
4. What is the simplest alternative?
5. How would I test and observe it?
6. What does it cost to build and operate?
7. What business decision becomes better or faster?
8. When should I refuse to use it?

## Definition of Done

A project is not complete because the happy path ran once. It is complete enough to share when another learner can reproduce it, bad data is handled intentionally, key outputs are verified, failure recovery is documented, limitations are honest, and the business value is understandable.

Use the [project checklist](18-templates/project-checklist-template.md) for engineering completeness and the [business impact scorecard](18-templates/business-impact-scorecard.md) for judgment and evidence.
