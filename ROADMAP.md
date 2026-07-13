# Roadmap

This roadmap is a staged path from beginner to professional Data Engineering capability. It is designed to be practical, project-driven, and focused on business impact.

Use this roadmap together with the [Learning and Evidence System](LEARNING-SYSTEM.md). Stages describe what to study; evidence gates determine whether you can apply it. In the AI age, follow the capability model in [AI-Era Data Engineering](AI-ERA-DATA-ENGINEERING.md).

The stages are ordered intentionally. Later tools and architectures make more sense when the fundamentals are already clear.

## Stage 0: Orientation and Environment

### Purpose

Understand what Data Engineering is, how it differs from analytics and software engineering, and how to set up a reliable learning workspace.

### Relevant Sections

- [00-introduction/](00-introduction/)
- [01-fundamentals/](01-fundamentals/)
- [18-templates/](18-templates/)

### Learn

- What Data Engineers do
- Common data roles and team responsibilities
- How data moves from source systems to business decisions
- Local development basics
- Command-line navigation
- Git and GitHub basics
- Markdown documentation
- Project folder structure
- Reproducible setup habits

### Practice

- Create a local development environment
- Use Git to track changes
- Write a simple technical README
- Organize a small data project with folders for data, scripts, notebooks, docs, and outputs

### Milestone

You can explain the role of Data Engineering and create a clean, reproducible workspace for a small project.

## Stage 1: Data Foundations

### Purpose

Learn how real business data is represented, stored, moved, and misunderstood.

### Relevant Sections

- [01-fundamentals/](01-fundamentals/)
- [03-python-for-data-engineering/files-and-formats.md](03-python-for-data-engineering/files-and-formats.md)
- [resources/datasets.md](resources/datasets.md)

### Learn

- Structured, semi-structured, and unstructured data
- CSV, JSON, Parquet, Excel, and plain text
- Rows, columns, records, fields, keys, and schemas
- Data types and type conversion
- Missing values, duplicates, invalid values, and inconsistent formats
- Business entities such as customers, orders, products, suppliers, invoices, and inventory
- Basic descriptive statistics
- Data profiling
- Source-system thinking

### Practice

- Profile raw CSV and Excel files
- Identify data quality issues
- Write a data dictionary
- Convert messy data into a cleaner tabular format
- Explain what each field means in business terms

### Milestone

You can inspect a raw dataset, describe its structure, identify quality issues, and explain what business process likely produced it.

## Stage 2: SQL and Databases

### Purpose

Develop strong SQL skill and understand relational data systems.

### Relevant Sections

- [02-sql-and-databases/](02-sql-and-databases/)
- [04-data-modeling/](04-data-modeling/)
- [17-projects/beginner/03-sql-sales-analysis/](17-projects/beginner/03-sql-sales-analysis/)

### Learn

- Tables, primary keys, foreign keys, and constraints
- SELECT, WHERE, ORDER BY, GROUP BY, HAVING
- Joins and set operations
- Common table expressions
- Window functions
- Date and time handling
- Transactions and basic ACID concepts
- Indexing basics
- Normalization and denormalization
- Basic query performance thinking
- Relational modeling for business entities

### Practice

- Load CSV data into a relational database
- Query sales, customer, inventory, and finance datasets
- Build summary tables
- Model orders, order items, customers, products, and payments
- Write SQL that answers real business questions

### Milestone

You can design a small relational schema, load data into it, and write reliable SQL queries for analysis and validation.

## Stage 3: Python for Data Engineering

### Purpose

Use Python to automate data movement, transformation, validation, and integration.

### Relevant Sections

- [03-python-for-data-engineering/](03-python-for-data-engineering/)
- [05-etl-elt-pipelines/](05-etl-elt-pipelines/)
- [17-projects/beginner/04-retail-sales-pipeline/](17-projects/beginner/04-retail-sales-pipeline/)

### Learn

- Python project structure
- Virtual environments and dependency management
- Reading and writing files
- Working with CSV, JSON, and APIs
- Logging and error handling
- Functions and modules
- Configuration files and environment variables
- Data validation patterns
- Basic testing
- Working with databases from Python

### Practice

- Build a script that ingests files into a database
- Pull data from a public API
- Validate required fields and data types
- Log pipeline execution results
- Write tests for transformation logic

### Milestone

You can build a small repeatable data pipeline with Python that reads data, validates it, transforms it, and writes it to a database or file.

## Stage 4: Pipelines and Orchestration

### Purpose

Move from one-off scripts to repeatable workflows.

### Relevant Sections

- [05-etl-elt-pipelines/](05-etl-elt-pipelines/)
- [08-orchestration/](08-orchestration/)
- [14-production-engineering/](14-production-engineering/)
- [17-projects/intermediate/05-airflow-scheduled-pipeline/](17-projects/intermediate/05-airflow-scheduled-pipeline/)

### Learn

- Pipeline stages: extract, load, transform, validate, publish
- Batch processing patterns
- Scheduling
- Dependencies between tasks
- Idempotency
- Retries and failure handling
- Backfills
- Incremental loads
- Pipeline configuration
- Operational documentation

### Practice

- Break a pipeline into clear tasks
- Schedule a daily batch workflow
- Add retry and failure behavior
- Create a backfill plan
- Make pipeline outputs reproducible

### Milestone

You can design and run a multi-step pipeline that can be scheduled, rerun, debugged, and explained.

## Stage 5: Warehousing and Analytics Engineering

### Purpose

Create trusted, analytics-ready datasets from raw and staged data.

### Relevant Sections

- [04-data-modeling/](04-data-modeling/)
- [06-data-warehousing/](06-data-warehousing/)
- [09-dbt-and-analytics-engineering/](09-dbt-and-analytics-engineering/)
- [17-projects/intermediate/02-retail-sales-warehouse/](17-projects/intermediate/02-retail-sales-warehouse/)

### Learn

- Data warehouse concepts
- Raw, staging, intermediate, and mart layers
- Dimensional modeling
- Facts and dimensions
- Slowly changing dimensions
- Surrogate keys
- Metrics definitions
- Semantic consistency
- Transformation testing
- Documentation for analytics users

### Practice

- Build a small warehouse for retail or operations data
- Create fact and dimension tables
- Define metrics such as revenue, gross margin, repeat purchase rate, stockout rate, and lead time
- Add tests for uniqueness, relationships, accepted values, and not-null fields
- Document models and metrics

### Milestone

You can turn raw operational data into documented analytics tables that business users can trust.

## Stage 6: Data Quality, Observability, and Governance

### Purpose

Build trust into the data system instead of treating quality as an afterthought.

### Relevant Sections

- [12-data-quality-testing-observability/](12-data-quality-testing-observability/)
- [14-production-engineering/](14-production-engineering/)
- [18-templates/data-quality-template/](18-templates/data-quality-template/)

### Learn

- Data quality dimensions: accuracy, completeness, consistency, uniqueness, validity, timeliness
- Data contracts
- Schema drift
- Freshness checks
- Volume checks
- Anomaly detection basics
- Lineage
- Access control
- Privacy and sensitive data handling
- Incident response
- Runbooks

### Practice

- Add validation checks to a pipeline
- Define quality rules for business-critical tables
- Create alerts for freshness or volume failures
- Document data ownership and assumptions
- Write a runbook for common failures

### Milestone

You can explain whether a dataset is trustworthy, how it is validated, who owns it, and what to do when it breaks.

## Stage 7: Cloud and Modern Data Platforms

### Purpose

Understand how data systems run beyond a laptop.

### Relevant Sections

- [13-cloud-data-engineering/](13-cloud-data-engineering/)
- [07-data-lake-and-lakehouse/](07-data-lake-and-lakehouse/)
- [17-projects/advanced/04-cloud-warehouse-pipeline/](17-projects/advanced/04-cloud-warehouse-pipeline/)

### Learn

- Cloud storage concepts
- Object storage
- Managed databases
- Data warehouses and lakehouse concepts
- Compute and job execution
- Secrets management
- Infrastructure as code basics
- Deployment patterns
- Cost awareness
- Environment separation: development, staging, production

### Practice

- Deploy a small pipeline to a cloud environment
- Store raw files in object storage
- Load data into a cloud warehouse
- Use managed secrets
- Estimate basic costs
- Document deployment steps

### Milestone

You can describe and deploy a simple cloud-based data pipeline with reasonable security, cost, and operational awareness.

## Stage 8: Streaming and Real-Time Systems

### Purpose

Understand event-driven data and systems that process data continuously.

### Relevant Sections

- [11-streaming-data/](11-streaming-data/)
- [10-big-data-processing/](10-big-data-processing/)
- [17-projects/advanced/03-kafka-streaming-sales-events/](17-projects/advanced/03-kafka-streaming-sales-events/)

### Learn

- Events and messages
- Producers and consumers
- Queues and streams
- Ordering and delivery guarantees
- Latency and throughput
- Windowing concepts
- Idempotent processing
- Dead-letter queues
- Real-time analytics use cases
- Operational monitoring for streams

### Practice

- Simulate event data such as orders, clicks, payments, or inventory changes
- Process events into a database or analytics table
- Handle duplicate events
- Track processing lag
- Compare batch and streaming designs for the same business problem

### Milestone

You can explain when streaming is useful, build a basic event pipeline, and reason about reliability tradeoffs.

## Stage 9: AI-Ready Data Engineering

### Purpose

Prepare reliable, governed, well-modeled data for AI systems, machine learning workflows, and retrieval-based applications.

### Relevant Sections

- [15-ai-ready-data-engineering/](15-ai-ready-data-engineering/)
- [12-data-quality-testing-observability/](12-data-quality-testing-observability/)
- [17-projects/advanced/05-ai-ready-data-platform/](17-projects/advanced/05-ai-ready-data-platform/)

### Learn

- Feature preparation basics
- Training, validation, and evaluation datasets
- Metadata and lineage for AI
- Document processing
- Chunking and embeddings concepts
- Vector search concepts
- Retrieval-augmented generation data requirements
- Feedback loops
- Bias, privacy, and sensitive data risks
- Evaluation-oriented dataset design

### Practice

- Prepare a clean dataset for model training or analysis
- Build a product or policy knowledge base for retrieval
- Add metadata and source references
- Validate document chunks
- Create an evaluation dataset for search or assistant quality

### Milestone

You can prepare data that is reliable enough for AI workflows and explain the risks, assumptions, and evaluation strategy.

## Stage 10: Professional Practice and Portfolio

### Purpose

Turn learning into credible professional evidence.

### Relevant Sections

- [17-projects/](17-projects/)
- [18-templates/](18-templates/)
- [19-interview-and-career/](19-interview-and-career/)
- [20-real-world-case-studies/](20-real-world-case-studies/)

### Learn

- Portfolio project structure
- Architecture diagrams
- Case study writing
- Technical tradeoff explanation
- Data interview preparation
- System design for data platforms
- Code review habits
- Open-source contribution basics
- Stakeholder communication
- Measuring business impact

### Practice

- Complete two or three end-to-end portfolio projects
- Write case studies for each project
- Include setup instructions, architecture, data model, quality checks, and known limitations
- Practice explaining your decisions aloud
- Review and improve older projects

### Milestone

You can present your work professionally, explain your design decisions, and connect technical implementation to business value.

## Recommended Project Progression

Start with small projects and improve them over time.

1. Clean and analyze a messy CSV dataset.
2. Load business data into a relational database.
3. Build a Python ingestion pipeline.
4. Add validation and logging.
5. Create warehouse-style fact and dimension tables.
6. Schedule the pipeline.
7. Add quality checks and documentation.
8. Deploy a small version to the cloud.
9. Add a streaming or event-driven component.
10. Prepare part of the data for AI or retrieval use.

## Professional Readiness Checklist

By the end of the roadmap, you should be able to:

- Write strong SQL for analysis and validation
- Build Python scripts for ingestion and transformation
- Design relational and dimensional models
- Explain pipeline architecture
- Handle bad data intentionally
- Add tests and quality checks
- Document datasets and pipelines
- Use Git and structured project workflows
- Understand cloud storage and warehouse basics
- Reason about batch versus streaming
- Prepare data for analytics and AI use cases
- Explain business impact clearly

## Important Topics For Future Expansion

The current roadmap is broad enough for a strong foundation. The next phase should deepen a few professional topics that are currently introduced but not yet full sections:

- Data contracts and schema governance
- Change data capture and database replication
- Data lineage and catalog design
- Privacy, PII handling, and compliance basics
- Infrastructure as code for data platforms
- CI/CD for SQL, dbt, Airflow, and data pipelines
- Semantic layers and governed metric stores
- Incident response runbooks for data failures
- Data product ownership and service-level expectations

These topics should be added through practical examples and projects, not as abstract tool lists.

## Guiding Principle

Do not rush through stages just to collect tools. A professional Data Engineer is trusted because they understand data, systems, tradeoffs, and business consequences.
