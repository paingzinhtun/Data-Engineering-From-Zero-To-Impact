# AI Agent Instructions

This file provides operating instructions for AI coding agents working in this repository.

The repository mission is to become a practical one-stop roadmap, knowledge base, project lab, and portfolio system for learning modern Data Engineering from beginner to professional level.

Agents should preserve that mission in every change.

## Core Principles

1. Fundamentals before tools.
2. Business problems before random tutorials.
3. Production thinking from the beginning.
4. Projects before theory-only learning.
5. Data quality, reliability, and trust.
6. AI-ready Data Engineering for the modern age.
7. Real-world business impact, especially for SMEs, retail, inventory, customer analytics, and business operations.

## Expected Agent Behavior

When editing this repository:

- Read the existing documentation before changing structure or terminology.
- Keep content practical, specific, and useful.
- Prefer examples based on real business workflows.
- Avoid shallow lists of tools without explaining why they matter.
- Avoid hype-driven language.
- Avoid creating large sections that are only inspirational and not actionable.
- Keep beginner content clear without making it simplistic.
- Keep advanced content grounded in implementation, tradeoffs, reliability, and business value.
- Preserve consistent Markdown style.
- Link related documents when useful.
- Update the changelog when making meaningful content or structure changes.

## Documentation Standards

Documentation should answer the practical questions a learner or maintainer would ask:

- What problem does this solve?
- Who is it for?
- What should the learner know before starting?
- What will the learner build?
- What concepts are being taught?
- What tools are used, and why?
- What assumptions are being made?
- How can the work be validated?
- What does professional-quality work look like?
- How does this connect to business impact?

Do not add content that only says what a topic is. Explain how it is used, where it fails, and how it appears in real data work.

## Project Content Guidelines

Project labs should include:

- A business scenario
- Learning objectives
- Source data description
- Expected architecture
- Setup instructions
- Step-by-step implementation guidance
- Validation checks
- Expected outputs
- Documentation requirements
- Extension ideas
- Portfolio talking points

Prefer project domains such as:

- Retail sales
- Inventory management
- Customer analytics
- Supplier performance
- Finance operations
- Small business reporting
- Marketing analytics
- Support operations
- AI-ready knowledge bases
- Business process automation

Avoid projects that are technically flashy but disconnected from business use.

## Technical Standards

When adding code in future changes:

- Keep setup reproducible.
- Use clear folder names.
- Provide explicit run commands.
- Separate raw data, processed data, source code, tests, and documentation.
- Do not commit secrets, tokens, credentials, private keys, or personal data.
- Use sample or synthetic data unless real data is explicitly licensed and safe to share.
- Include validation for important transformations.
- Include logging for pipeline execution where appropriate.
- Prefer simple, understandable implementations before introducing heavier frameworks.
- Add tests when logic affects data correctness.

## Data Standards

Data examples should be treated as teaching material and as engineering artifacts.

For datasets:

- Explain the source or generation method.
- Include a data dictionary when practical.
- Define primary keys and relationships.
- Identify known quality issues.
- Include expected row-level or aggregate checks.
- Avoid sensitive personal data.
- Prefer realistic business fields over generic examples.

For transformations:

- State assumptions clearly.
- Preserve raw data where possible.
- Make cleaning rules explicit.
- Validate important joins and aggregations.
- Document metric definitions.

## Writing Style

Use clear, practical, professional English.

Preferred style:

- Direct
- Specific
- Actionable
- Beginner-friendly but not vague
- Business-aware
- Production-minded

Avoid:

- Buzzword-heavy writing
- Overpromising career outcomes
- Tool worship
- Generic motivational filler
- Unexplained acronyms
- Long paragraphs without structure
- Content copied from vendor documentation

## Repository Structure Guidance

Only create new folders or files when they serve a clear learning or maintenance purpose.

Likely future top-level areas may include:

- `projects/` for hands-on project labs
- `concepts/` for focused explanations of core ideas
- `templates/` for reusable project, README, data dictionary, and case study templates
- `datasets/` for safe sample or synthetic datasets
- `exercises/` for practice tasks
- `docs/` for extended guides

Do not introduce a complex structure prematurely. The repository should remain easy for beginners to navigate.

## Review Checklist For Agents

Before finishing a change, verify:

- The change supports the repository mission.
- The content is useful without requiring hidden context.
- The level is appropriate for the intended learner.
- Business relevance is clear.
- Any added project has validation and documentation guidance.
- Markdown headings and links are consistent.
- No secrets or private data were added.
- The changelog was updated for meaningful changes.

## Handling Ambiguity

If a request is unclear, make a conservative choice that fits the repository philosophy. Prefer smaller, well-structured additions over broad, shallow content.

If a request would make the repository less practical, less accurate, or less trustworthy, explain the concern and propose a better alternative.

## Long-Term Direction

This repository should grow into a learning system, not a random collection of notes.

Future additions should help learners:

- Understand concepts
- Build projects
- Validate data
- Operate pipelines
- Explain tradeoffs
- Prepare for professional roles
- Demonstrate business impact

Every contribution should make the path clearer, more practical, or more credible.
