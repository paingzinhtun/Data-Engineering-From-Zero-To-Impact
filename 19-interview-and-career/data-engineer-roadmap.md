# Data Engineer Roadmap

This roadmap connects learning topics to career readiness. It is not only a list of tools. A strong data engineer can explain business problems, design reliable pipelines, model data well, validate outputs, and operate systems in production.

## 1. Beginner To Junior Path

Goal: become able to build small reliable pipelines and explain them clearly.

Core skills:

- SQL basics: filtering, grouping, joins, window functions
- Python basics: files, functions, pandas, APIs, logging
- Databases: tables, keys, indexes, transactions
- Data formats: CSV, JSON, Parquet
- Git and GitHub
- Command line basics
- Docker basics
- Simple ETL and ELT patterns
- Basic data quality checks

Expected projects:

- CSV to PostgreSQL loader
- API to CSV extractor
- SQL sales analysis project
- Beginner retail sales pipeline

Career signal:

- You can take messy source data, clean it, load it, validate it, and explain the business value.

## 2. Junior To Mid-Level Path

Goal: become able to own a production-style pipeline or analytics workflow with supervision.

Core skills:

- Advanced SQL and query optimization
- Dimensional modeling
- Incremental loading
- Idempotency
- Airflow or another orchestrator
- dbt models, tests, docs, and sources
- Warehouse design
- Cloud storage and managed warehouse basics
- More serious data quality and monitoring
- Basic CI/CD and deployment habits

Expected projects:

- API to PostgreSQL ETL
- Retail sales warehouse
- Inventory reorder pipeline
- dbt retail transformations
- Airflow scheduled pipeline

Career signal:

- You can design a pipeline that runs repeatedly, handles failures, produces trusted tables, and supports business reporting.

## 3. Mid-Level To Senior Path

Goal: become able to design systems, make tradeoffs, mentor others, and connect data work to business impact.

Core skills:

- Data platform architecture
- Lakehouse and warehouse tradeoffs
- Spark batch processing
- Streaming concepts and Kafka
- Cost optimization
- Security and governance
- Observability
- Data contracts and ownership
- AI-ready data access patterns
- System design communication

Expected projects:

- Lakehouse Bronze/Silver/Gold architecture
- PySpark batch processing
- Kafka sales event streaming
- Cloud warehouse pipeline
- AI-ready data platform
- Capstone project with business impact

Career signal:

- You can choose the right architecture for the problem, explain tradeoffs, and build systems that others can trust and operate.

## 4. Technical Skill Expectations By Level

| Skill Area | Junior | Mid-Level | Senior |
| --- | --- | --- | --- |
| SQL | Writes joins, aggregations, windows | Optimizes queries and models marts | Defines standards and reviews complex logic |
| Python | Builds scripts and simple ETL | Builds testable, configurable pipelines | Designs reusable frameworks and patterns |
| Modeling | Understands facts and dimensions | Designs warehouse models | Owns enterprise modeling tradeoffs |
| Orchestration | Runs scheduled DAGs | Designs retries, backfills, dependencies | Defines orchestration strategy |
| Quality | Adds basic checks | Builds quality gates and alerts | Creates quality strategy and ownership model |
| Cloud | Uses managed services | Deploys and operates pipelines | Controls cost, security, and platform architecture |
| Communication | Explains project steps | Explains tradeoffs and business value | Influences architecture and business decisions |

## 5. Recommended Learning Order

1. SQL and databases
2. Python for data engineering
3. Data modeling
4. ETL/ELT pipelines
5. Data warehousing
6. Data quality
7. Orchestration
8. dbt
9. Cloud basics
10. Production engineering
11. Spark and big data
12. Streaming
13. AI-ready data engineering

## 6. Portfolio Milestones

Minimum portfolio for junior roles:

- One SQL analysis project
- One Python ETL project
- One PostgreSQL project
- Clear README files
- Business problem and expected output documented

Stronger portfolio for mid-level roles:

- One warehouse project
- One orchestration project
- One dbt project
- Data quality checks
- Setup instructions
- Diagrams and data model documentation

Senior-level portfolio signals:

- Architecture tradeoffs
- Cost and security discussion
- Production readiness notes
- Observability and backfill strategy
- Business impact narrative
- Capstone project with end-to-end design

## 7. What To Avoid

- Learning only tools without understanding fundamentals
- Building projects with no business problem
- Showing dashboards without explaining the data model
- Ignoring data quality
- Hardcoding credentials
- Treating Spark, Kafka, or cloud services as mandatory for small problems
- Describing projects only as tasks instead of business outcomes
