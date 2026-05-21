# Distributed Computing

## 1. What It Is

Distributed computing means splitting work across multiple machines or workers instead of running everything on one computer.

In Data Engineering, distributed computing is used when data is too large, too slow, or too expensive to process on a single machine or single database query.

## 2. Why It Matters

Some datasets cannot be handled efficiently with local Python, pandas, or a small database. Distributed systems let teams process large files, historical event logs, high-volume transactions, and multi-year analytics datasets.

Distributed computing matters because it can:

- Process larger datasets.
- Parallelize work.
- Improve throughput.
- Support large batch jobs.
- Handle complex transformations at scale.
- Work with data lakes and columnar files such as Parquet.

It also adds complexity, so it should be used intentionally.

## 3. When to Use It

Use distributed computing when:

- Data is larger than one machine can process comfortably.
- Processing takes too long locally.
- Data is already stored in a lake or large distributed storage system.
- Work can be split into parallel tasks.
- Batch jobs need to process millions or billions of rows.

It is overkill when:

- Data fits easily in memory.
- A SQL database can answer the query quickly.
- The job is small and simple.
- Team members cannot operate the extra infrastructure.
- The main problem is poor modeling, not scale.

## 4. Real Business Example

A retail chain has five years of sales data from hundreds of stores. Each day produces large sales files, inventory logs, and customer activity records.

Processing this data with pandas on one laptop becomes slow and unreliable.

A distributed processing engine can split the files across workers, aggregate daily product sales, calculate customer summaries, and produce category performance outputs.

## 5. Technical Example

Single-machine processing:

```text
one computer reads all files
one process transforms all rows
one output is written
```

Distributed processing:

```text
many workers read different partitions
each worker transforms part of the data
results are combined when needed
outputs are written in parallel
```

Example distributed flow:

```text
large sales files
  -> read in parallel
  -> filter invalid rows
  -> group by sale_date and product_id
  -> write daily product sales as Parquet
```

## 6. Production Considerations

- Understand data size before choosing distributed tools.
- Use efficient file formats such as Parquet.
- Avoid many tiny files.
- Partition data by useful columns such as date.
- Monitor job duration, memory, and shuffle size.
- Design joins carefully.
- Keep transformations explainable.
- Control cluster and compute costs.

## 7. Common Mistakes

- Using Spark for small CSV files that pandas can handle.
- Assuming distributed processing automatically makes bad logic fast.
- Ignoring file size and partition layout.
- Creating too many small files.
- Joining huge datasets without planning.
- Caching data without understanding memory use.
- Not measuring performance before optimizing.

## 8. Practice Task

Take a retail sales dataset and answer:

1. How many rows are expected daily?
2. How large is one month of data?
3. Can it fit comfortably in local memory?
4. Could a database query handle it?
5. What would make distributed processing useful?
6. What would make Spark overkill?
7. How would you partition the files?

## 9. Related Project

- `10-big-data-processing/pyspark-project/`: Large Retail Batch Processing Project.
- `07-data-lake-and-lakehouse/`: Distributed systems often process data lake files.
- `05-etl-elt-pipelines/batch-processing.md`: Large batch processing often uses distributed compute.
