# Docker Compose

## 1. What It Is

Docker Compose is a tool for defining and running multiple containers together using a `docker-compose.yml` file.

In Data Engineering, Docker Compose is useful for local development environments that include services such as PostgreSQL, Airflow, Kafka, object storage emulators, or pipeline containers.

## 2. Why It Matters

Data projects often depend on more than one service. Docker Compose makes those services easier to start, stop, share, and reproduce.

It helps Data Engineers:

- Run local databases.
- Test pipelines against real services.
- Share consistent development environments.
- Avoid manual installation differences.
- Document service dependencies.

## 3. When to Use It

Use Docker Compose when:

- A project needs multiple local services.
- You want reproducible development setup.
- Learners or teammates need the same environment.
- You need a local PostgreSQL, Airflow, or Kafka stack.

Avoid Compose when a single script or simple virtual environment is enough.

## 4. Real Business Example

A retail analytics project needs PostgreSQL for tables and a Python container for loading data.

Docker Compose can start both services together:

- `postgres` stores retail data.
- `pipeline` runs the ingestion script.

This makes setup clearer than asking every contributor to install PostgreSQL manually.

## 5. Technical Example

Example `docker-compose.yml`:

```yaml
services:
  postgres:
    image: postgres:16
    environment:
      POSTGRES_USER: data_user
      POSTGRES_PASSWORD: data_password
      POSTGRES_DB: retail
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  pipeline:
    build: .
    environment:
      POSTGRES_HOST: postgres
      POSTGRES_PORT: "5432"
      POSTGRES_DB: retail
      POSTGRES_USER: data_user
      POSTGRES_PASSWORD: data_password
    depends_on:
      - postgres

volumes:
  postgres_data:
```

Commands:

```bash
docker compose up
docker compose down
docker compose logs
```

## 6. Production Considerations

- Do not commit real secrets in Compose files.
- Use `.env.example` for required variables.
- Use volumes for persistent local databases.
- Document ports and services.
- Keep local Compose separate from production deployment.
- Use health checks for dependent services when useful.
- Avoid assuming `localhost` works inside containers.
- Clean up unused containers and volumes carefully.

## 7. Common Mistakes

- Hardcoding production credentials.
- Forgetting volumes and losing database data.
- Confusing host ports and container ports.
- Using `localhost` inside a container to reach another container.
- Treating local Compose as a full production platform.
- Not documenting startup commands.
- Leaving old volumes with stale test data.

## 8. Practice Task

Create a Docker Compose setup for a retail data project.

Include:

1. PostgreSQL service.
2. Pipeline service.
3. Environment variables.
4. Volume for database persistence.
5. Port mapping.
6. Startup instructions.
7. Shutdown instructions.
8. Notes about secrets.

## 9. Related Project

- `01-fundamentals/docker-basics.md`: Docker concepts before Compose.
- `02-sql-and-databases/postgresql-practice/`: Can be run with a local PostgreSQL service.
- `17-projects/`: Project labs can use Compose for local reproducibility.
