# Docker Basics

## 1. What It Is

Docker is a tool for packaging and running applications in isolated environments called containers.

Instead of relying on whatever is installed on your laptop, Docker lets a project define its own runtime environment. This makes it easier to run databases, APIs, pipeline tools, and development services consistently.

Important Docker concepts:

- **Image:** A packaged template for an environment.
- **Container:** A running instance of an image.
- **Dockerfile:** A file that defines how to build an image.
- **docker-compose:** A tool for running multiple containers together.
- **Volume:** A way to persist or share data between your machine and a container.
- **Port mapping:** A way to expose a service inside a container to your machine.

## 2. Why It Matters for Data Engineering

Data Engineering projects often need services such as databases, orchestration tools, APIs, message queues, or local warehouses. Installing all of these directly on your machine can be messy.

Docker helps Data Engineers:

- Run consistent local environments.
- Start databases for practice projects.
- Share setup instructions with other learners.
- Avoid dependency conflicts.
- Test pipelines in isolated services.
- Simulate production-like environments locally.

Docker does not replace learning databases, Python, or pipelines. It helps run the supporting environment reliably.

## 3. When You Use It

You use Docker when:

- Running PostgreSQL locally for SQL practice.
- Starting a local API for ingestion practice.
- Running a pipeline with specific dependencies.
- Sharing a project that should work on different machines.
- Testing services before deploying to cloud infrastructure.
- Running multiple components together with `docker-compose`.

## 4. Real-World Example

A learner builds an inventory pipeline that needs:

- A PostgreSQL database
- A Python ingestion script
- A small admin tool for inspecting tables

Without Docker, each learner must install PostgreSQL manually and configure it differently.

With Docker, the project can include a `docker-compose.yml` file. One command can start the database with the expected username, password, database name, volume, and port mapping.

This makes the project easier to run, review, and reproduce.

## 5. Basic Commands or Examples

Image:

```text
An image is like a packaged blueprint.
Example: postgres:16
```

Container:

```text
A container is a running instance of an image.
Example: a running PostgreSQL database created from postgres:16
```

Dockerfile example:

```dockerfile
FROM python:3.12-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
CMD ["python", "main.py"]
```

`docker-compose.yml` example:

```yaml
services:
  postgres:
    image: postgres:16
    environment:
      POSTGRES_USER: data_user
      POSTGRES_PASSWORD: data_password
      POSTGRES_DB: inventory
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

Common commands:

```bash
docker build -t inventory-pipeline .
docker run inventory-pipeline
docker ps
docker stop <container_id>
docker compose up
docker compose down
```

Volume:

```text
A volume keeps database files even if a container is stopped or recreated.
```

Port mapping:

```text
"5432:5432" maps port 5432 on your machine to port 5432 inside the container.
```

## 6. Common Mistakes

- Thinking Docker is the same as a virtual machine.
- Forgetting to persist database data with a volume.
- Confusing image names and container names.
- Forgetting port mappings and wondering why a service is unreachable.
- Storing secrets directly in Dockerfiles.
- Rebuilding images when only a container restart is needed.
- Using Docker before understanding the service being run.
- Not documenting how to start and stop the environment.

## 7. Practice Task

Create a small Docker-based practice environment for PostgreSQL.

Practice:

1. Write a `docker-compose.yml` file for PostgreSQL.
2. Start the service with `docker compose up`.
3. Confirm the container is running.
4. Connect to the database.
5. Create a simple `products` table.
6. Insert three rows.
7. Stop the service.
8. Start it again and confirm the data is still available.

This teaches containers, ports, and volumes in a Data Engineering context.

## 8. Related Project

- `02-sql-and-databases/`: Use Docker to run local databases for SQL practice.
- `05-etl-elt-pipelines/`: Use Docker to run reproducible pipeline environments.
- `14-production-engineering/`: Containers are part of many production deployment workflows.
