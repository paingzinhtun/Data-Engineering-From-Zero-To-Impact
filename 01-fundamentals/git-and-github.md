# Git And GitHub

## 1. What It Is

Git is a version control system. It tracks changes to files over time so you can review history, collaborate with others, create branches, and recover previous versions.

GitHub is a platform for hosting Git repositories online. It is commonly used for open-source projects, team collaboration, issues, pull requests, documentation, and portfolio projects.

Git tracks your work locally. GitHub helps you share and collaborate on that work remotely.

## 2. Why It Matters for Data Engineering

Data Engineering work includes code, SQL, documentation, configuration, tests, and project structure. These assets need version control.

Git and GitHub help Data Engineers:

- Track pipeline and model changes.
- Review SQL and Python changes before production.
- Collaborate with analysts and engineers.
- Document project history.
- Maintain portfolio projects.
- Work with branches safely.
- Support CI/CD and automated checks.

Professional data work should not live only in local folders or untracked notebooks.

## 3. When You Use It

You use Git and GitHub when:

- Starting a new data project.
- Saving progress on pipeline code.
- Reviewing changes before merging.
- Collaborating with others.
- Publishing portfolio work.
- Rolling back a broken change.
- Opening issues for improvements.
- Managing documentation updates.

## 4. Real-World Example

A Data Engineer changes the SQL logic for monthly revenue. The change accidentally counts refunded orders as revenue.

With Git, the team can:

- See exactly what changed.
- Review the old logic.
- Create a fix on a branch.
- Discuss the change in a pull request.
- Add tests to prevent the issue from happening again.
- Merge the fix after review.

Without version control, the team may not know when the problem started or which change caused it.

## 5. Basic Commands or Examples

Create a new Git repository:

```bash
git init
```

Clone an existing repository:

```bash
git clone https://github.com/example/data-project.git
```

Check current status:

```bash
git status
```

Stage changes:

```bash
git add README.md
git add .
```

Commit staged changes:

```bash
git commit -m "Add initial pipeline documentation"
```

List branches:

```bash
git branch
```

Create and switch to a branch:

```bash
git checkout -b add-inventory-pipeline
```

Switch branches:

```bash
git checkout main
```

Merge a branch:

```bash
git merge add-inventory-pipeline
```

Pull latest changes:

```bash
git pull
```

Push local commits:

```bash
git push
```

Push a new branch:

```bash
git push -u origin add-inventory-pipeline
```

## 6. Common Mistakes

- Committing secrets, passwords, tokens, or private data.
- Using vague commit messages such as `update` or `fix`.
- Working directly on `main` for risky changes.
- Forgetting to pull before starting work.
- Committing large raw datasets that should not be in Git.
- Ignoring `.gitignore`.
- Mixing unrelated changes in one commit.
- Not reading `git status` before committing.

## 7. Practice Task

Create a small Git repository for a sample inventory data project.

Practice:

1. Run `git init`.
2. Create a `README.md`.
3. Add a short project description.
4. Run `git status`.
5. Stage and commit the README.
6. Create a new branch called `add-data-dictionary`.
7. Add a simple data dictionary file.
8. Commit the change.
9. Switch back to `main`.
10. Merge the branch.

If you use GitHub, push the repository and view the commit history online.

## 8. Related Project

- `17-projects/`: Every portfolio project should be version controlled.
- `18-templates/`: Future project templates should include `.gitignore`, README, and contribution structure.
- `19-interview-and-career/`: GitHub projects can become portfolio evidence.
