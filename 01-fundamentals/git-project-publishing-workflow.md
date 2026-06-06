# Git Project Publishing Workflow

## Purpose

This note explains the basic Git commands used to publish a beginner portfolio project to GitHub.

It uses the CSV to PostgreSQL project as the example:

```text
17-projects/beginner/01-csv-to-postgres
```

## 1. Clone The GitHub Repository

```powershell
git clone https://github.com/paingzinhtun/Data-Engineering-From-Zero-To-Impact.git
```

What it means:

`git clone` downloads a GitHub repository to your computer.

Use this when you want to work on a repo that already exists on GitHub.

## 2. Go Into The Repository Folder

```powershell
cd Data-Engineering-From-Zero-To-Impact
```

What it means:

`cd` means change directory.

Run Git commands from inside the repository folder so Git knows which project you are working on.

## 3. Check The Current Git Status

```powershell
git status
```

What it means:

`git status` shows what changed in the repository.

It can show:

- new files
- modified files
- deleted files
- files staged for commit
- files not yet staged

Beginner habit:

Run `git status` often. It helps you avoid committing the wrong files.

## 4. Add The Project Files

```powershell
git add 17-projects/beginner/01-csv-to-postgres
```

What it means:

`git add` stages files for the next commit.

Staging means you are telling Git:

```text
Include these changes in my next saved version.
```

Beginner note:

Adding a specific folder is safer than using `git add .` because it reduces the chance of adding unrelated files.

## 5. Check Status Again

```powershell
git status
```

What it means:

This confirms which files are ready to commit.

Before committing, check that only the intended project files are staged.

## 6. Commit The Changes

```powershell
git commit -m "Add beginner CSV to PostgreSQL product catalog project"
```

What it means:

`git commit` saves a snapshot of the staged changes in your local Git history.

The commit message should explain what changed.

Good commit message:

```text
Add beginner CSV to PostgreSQL product catalog project
```

Weak commit message:

```text
update
```

## 7. Push To GitHub

```powershell
git push
```

What it means:

`git push` uploads your local commit to GitHub.

After pushing, the project should appear in the online GitHub repository.

## Complete Workflow

```powershell
git clone https://github.com/paingzinhtun/Data-Engineering-From-Zero-To-Impact.git
cd Data-Engineering-From-Zero-To-Impact
git status
git add 17-projects/beginner/01-csv-to-postgres
git status
git commit -m "Add beginner CSV to PostgreSQL product catalog project"
git push
```

## Easy Way To Remember

```text
clone  = download the repository
status = check what changed
add    = prepare changes for commit
commit = save changes locally
push   = upload changes to GitHub
```

## How This Connects To Data Engineering

Data engineering projects usually include SQL, data files, documentation, scripts, and setup instructions.

Git helps track these files clearly.

For a portfolio project, Git also shows:

- how the project is organized
- what files were created
- when changes were made
- how the project improved over time

This is why Git and GitHub are important even for beginner data engineering projects.
