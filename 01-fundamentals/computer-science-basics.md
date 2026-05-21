# Computer Science Basics

## 1. What It Is

Computer science basics are the core ideas that explain how software, data, and systems work. For Data Engineering, the most useful basics include files, memory, storage, processes, data types, algorithms, complexity, operating systems, and how programs read, transform, and write data.

You do not need a full computer science degree to start Data Engineering, but you do need enough foundation to understand why systems behave the way they do.

## 2. Why It Matters for Data Engineering

Data pipelines are software systems. They read files, connect to networks, process records, write outputs, use memory, fail when resources are limited, and depend on operating systems.

Computer science basics help you:

- Understand why a script is slow.
- Avoid loading files that are too large for memory.
- Choose better data structures.
- Debug file, permission, and process issues.
- Understand how databases and distributed systems work at a high level.
- Think clearly about tradeoffs.

## 3. When You Use It

You use computer science basics when:

- Processing large CSV files.
- Deciding whether to use a list, dictionary, table, or database.
- Debugging memory errors.
- Reading logs from failed jobs.
- Understanding why a query or transformation is slow.
- Designing repeatable scripts.
- Working with containers, servers, and cloud jobs.

## 4. Real-World Example

An inventory team exports a 5 GB CSV file every night. A beginner Python script tries to load the whole file into memory and crashes.

A Data Engineer with basic computer science understanding would recognize that the file is too large for memory-based processing. They might process the file in chunks, load it into a database, use a more efficient format such as Parquet, or run the job on a machine with more memory.

The issue is not only a Python issue. It is a systems issue involving storage, memory, file format, and processing strategy.

## 5. Basic Commands or Examples

Example concepts:

```text
File: data stored on disk
Process: a running program
Memory: temporary working space used by running programs
Storage: persistent disk or object storage
Input: data read by a program
Output: data written by a program
```

Simple Python example of processing records one at a time:

```python
with open("orders.csv", "r", encoding="utf-8") as file:
    for line in file:
        process(line)
```

This pattern can be more memory-friendly than loading the entire file at once.

Common data structure examples:

```python
product_ids = ["P001", "P002", "P003"]

product_prices = {
    "P001": 12.99,
    "P002": 8.50,
    "P003": 19.00,
}
```

## 6. Common Mistakes

- Loading large files fully into memory without checking size.
- Ignoring file paths and assuming scripts run from one specific directory.
- Treating all data as text instead of using correct data types.
- Writing code that works only for one small sample file.
- Not understanding why duplicate keys overwrite values in dictionaries.
- Ignoring time complexity when processing many records.
- Confusing storage with memory.

## 7. Practice Task

Take a CSV file from a business domain such as sales, inventory, or customers.

Answer:

1. How large is the file?
2. How many rows does it contain?
3. Which columns should be numbers, dates, strings, or booleans?
4. Could the file be processed in memory?
5. What could go wrong if the file becomes 100 times larger?

Then write a short note explaining what processing strategy you would use.

## 8. Related Project

- `17-projects/`: A messy CSV cleaning project should apply these basics before introducing heavier tools.
- `03-python-for-data-engineering/`: Python pipeline projects depend on understanding files, memory, and program structure.
