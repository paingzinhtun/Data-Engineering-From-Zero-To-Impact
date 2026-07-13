# Business Impact Scorecard

Score each dimension from 0 to 4. Include a link or short note describing the evidence. Do not award points for claims without evidence.

| Dimension | 0 | 1 | 2 | 3 | 4 | Score | Evidence |
| --- | --- | --- | --- | --- | --- | ---: | --- |
| Problem and user | No problem | Generic problem | User named | Decision and pain clear | Validated with user/process evidence |  |  |
| Baseline | None | Assumption | Rough estimate | Measured baseline | Repeated/validated baseline |  |  |
| Data understanding | Unknown | Columns listed | Grain and keys | Ownership and semantics | Contract, lineage, limitations |  |  |
| Engineering quality | Demo only | Happy path | Reproducible | Tested and idempotent | CI, security, maintainable design |  |  |
| Reliability | None | Manual check | Core validation | Monitoring and alerts | SLO, runbook, recovery tested |  |  |
| Business output | No output | Technical table | KPI/report | Decision workflow supported | Action and feedback captured |  |  |
| Impact evidence | None | Claimed | Estimated | Before/after measured | Sustained value and tradeoffs measured |  |  |
| Judgment | No rationale | Tool-led | Basic rationale | Alternatives and costs compared | Decision revisited using evidence |  |  |
| Communication | Unclear | Partial README | Reproducible README | Architecture and demo | Executive and technical narratives |  |  |
| AI/data responsibility | Ignored | Mentioned | Risks listed | Controls and evaluation | Ongoing monitoring and governance |  |  |

## Interpretation

- **0–12 — Exercise:** useful practice, not yet portfolio evidence.
- **13–22 — Working prototype:** demonstrates building ability; strengthen verification and user value.
- **23–31 — Portfolio project:** credible end-to-end evidence with clear limitations.
- **32–36 — Production-minded:** strong technical and operational thinking.
- **37–40 — Impact case study:** unusually complete evidence across users, engineering, operations, and value.

A high total cannot compensate for zero in problem clarity, engineering quality, reliability, or impact evidence.

## Impact Measures

Choose one primary measure and no more than three supporting measures:

- time saved per reporting cycle;
- error or reconciliation rate;
- data freshness or decision latency;
- pipeline success and recovery time;
- stockout, waste, fraud, or compliance risk;
- revenue, margin, conversion, or retention influenced;
- cloud or operational cost per useful output; or
- user adoption and action rate.

If real-world measurement is unavailable, label the result **hypothesis**, show the calculation, state assumptions, and propose a validation experiment.
