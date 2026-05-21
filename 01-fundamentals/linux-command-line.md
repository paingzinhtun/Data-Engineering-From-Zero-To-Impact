# Linux Command Line

## 1. What It Is

The Linux command line is a text-based way to interact with files, folders, programs, servers, and data tools. Instead of clicking through folders, you type commands to inspect files, move around directories, run scripts, search logs, and automate work.

Even if you use Windows or macOS, many Data Engineering tools, cloud servers, containers, and production environments use Linux-style commands.

## 2. Why It Matters for Data Engineering

Data Engineers often work with remote servers, containers, cloud environments, logs, scripts, and large folders of files. The command line is one of the fastest ways to inspect and manage that work.

It helps you:

- Navigate project folders.
- Inspect raw data files.
- Search logs for errors.
- Run Python scripts and SQL clients.
- Move, copy, and organize data files.
- Work inside Docker containers and cloud machines.
- Automate repeatable tasks.

## 3. When You Use It

You use the command line when:

- Checking whether a file exists.
- Looking at the first rows of a CSV.
- Finding error messages in logs.
- Creating a project folder.
- Running a pipeline script.
- Copying files between folders.
- Changing file permissions.
- Working on a cloud virtual machine.

## 4. Real-World Example

An ecommerce pipeline fails overnight. The dashboard is empty in the morning.

A Data Engineer connects to the server and uses command-line tools to:

- Check the current folder.
- List output files.
- Inspect the latest log.
- Search for the word `ERROR`.
- Check whether the raw order file arrived.
- Rerun the failed script after fixing the issue.

This kind of debugging is difficult without basic command-line confidence.

## 5. Basic Commands or Examples

Print the current directory:

```bash
pwd
```

List files:

```bash
ls
ls -la
```

Change directory:

```bash
cd data
cd ..
```

Create a directory:

```bash
mkdir raw_data
```

Create an empty file:

```bash
touch notes.txt
```

Print a file:

```bash
cat orders.csv
```

Search inside files:

```bash
grep "ERROR" pipeline.log
grep "customer_id" *.csv
```

Show the first lines:

```bash
head orders.csv
head -n 20 orders.csv
```

Show the last lines:

```bash
tail pipeline.log
tail -n 50 pipeline.log
```

Copy files:

```bash
cp orders.csv backup_orders.csv
cp orders.csv data/raw/orders.csv
```

Move or rename files:

```bash
mv old_name.csv new_name.csv
mv orders.csv data/raw/
```

Remove files:

```bash
rm temporary_file.csv
```

Use `rm` carefully. Deleted files may not be recoverable.

Change permissions:

```bash
chmod +x run_pipeline.sh
```

Find files:

```bash
find . -name "*.csv"
find . -name "*.log"
```

## 6. Common Mistakes

- Running commands from the wrong directory.
- Deleting files with `rm` before confirming the path.
- Confusing relative paths and absolute paths.
- Opening very large files with commands that print everything.
- Forgetting that Linux paths are case-sensitive.
- Changing permissions without understanding why.
- Ignoring command output and error messages.

## 7. Practice Task

Create a small folder structure for a data project:

```text
practice-project/
  data/
    raw/
    processed/
  logs/
  scripts/
```

Then practice:

1. Navigate into each folder.
2. Create a sample `orders.csv` file.
3. Print the file.
4. Show only the first few lines.
5. Search for a product ID.
6. Copy the file to a backup location.
7. Rename the backup file.
8. Find all `.csv` files in the project.

## 8. Related Project

- `17-projects/`: Every project should use command-line basics for setup, file inspection, and running scripts.
- `05-etl-elt-pipelines/`: Pipeline debugging often starts with command-line inspection.
