# Portfolio Guide

A data engineering portfolio should prove that you can solve business problems with reliable data systems. It should not be a random collection of tutorials.

## 1. What A Strong Portfolio Shows

A strong portfolio demonstrates:

- Business understanding
- SQL ability
- Python pipeline ability
- Data modeling
- Data quality thinking
- Documentation
- Production awareness
- Clear communication

The best projects answer: What decision does this data help someone make?

## 2. Recommended Portfolio Structure

For each project, include:

- `README.md`
- Business problem
- Architecture
- Data sources
- Data model
- Pipeline steps
- Data quality checks
- Setup instructions
- Expected output
- Future improvements

Use the templates in `18-templates/`.

## 3. Beginner Portfolio

Goal: show fundamentals.

Suggested projects:

- CSV to PostgreSQL
- API to CSV
- SQL sales analysis
- Retail sales pipeline

Must show:

- Clean README files
- Basic SQL
- Basic Python
- Source-to-output flow
- Validation checks
- Business explanation

## 4. Junior To Mid-Level Portfolio

Goal: show ownership of more complete workflows.

Suggested projects:

- API to PostgreSQL ETL
- Retail sales warehouse
- Inventory reorder pipeline
- dbt retail transformations
- Airflow scheduled pipeline

Must show:

- Architecture diagram
- Dimensional model
- Orchestration design
- Quality checks
- Tests
- Production improvements
- Business impact

## 5. Senior-Level Portfolio Signals

Goal: show judgment and system design.

Suggested projects:

- Lakehouse Bronze/Silver/Gold
- PySpark batch processing
- Kafka streaming events
- Cloud warehouse pipeline
- AI-ready data platform
- Capstone project

Must show:

- Tradeoff analysis
- Scalability design
- Cost considerations
- Security and governance
- Monitoring and incident handling
- Clear reasoning about when the design is overkill

## 6. How To Explain Projects With Business Impact

Use this structure:

1. Problem: what business problem existed?
2. Users: who needed the data?
3. Data: what sources were involved?
4. System: what did you build?
5. Quality: how did you make it trustworthy?
6. Output: what did the business receive?
7. Impact: what decision or process improved?
8. Tradeoffs: what would you improve next?

Example:

> I built a retail sales pipeline that ingests POS CSV files, cleans product and customer data, calculates gross sales and gross profit, loads PostgreSQL tables, and runs quality checks. The output helps store managers identify top products and low-stock items without manual spreadsheet work.

## 7. Portfolio README Checklist

- [ ] Clear project title
- [ ] Business problem
- [ ] Architecture diagram or flow
- [ ] Source data description
- [ ] Data model
- [ ] Setup instructions
- [ ] How to run
- [ ] Data quality checks
- [ ] Expected outputs
- [ ] Screenshots or sample outputs when available
- [ ] Future improvements

## 8. Common Portfolio Mistakes

- No business problem
- No setup instructions
- Hardcoded credentials
- No data quality checks
- No expected output
- Too many tools without clear purpose
- Large architecture for a small problem
- README only says what the code does, not why it matters
