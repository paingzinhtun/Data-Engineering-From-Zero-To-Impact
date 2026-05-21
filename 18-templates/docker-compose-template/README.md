# Docker Compose Template

Use this template to define local services for a data engineering project, such as PostgreSQL, Airflow, MinIO, Kafka, or a lightweight application.

## 1. Purpose

Docker Compose helps learners run repeatable local infrastructure without manually installing every service.

Use it for:

- Local PostgreSQL warehouse
- Airflow development
- Kafka or Redpanda experiments
- MinIO object storage
- pgAdmin or Adminer
- Project-specific API services

## 2. Minimal PostgreSQL Example

```yaml
services:
  postgres:
    image: postgres:16
    container_name: project_postgres
    environment:
      POSTGRES_DB: ${POSTGRES_DB}
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  postgres_data:
```

## 3. Environment File

Do not hardcode credentials in `docker-compose.yml`.

```text
POSTGRES_DB=project_db
POSTGRES_USER=project_user
POSTGRES_PASSWORD=change_me
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
```

## 4. Common Commands

```bash
docker compose up -d
docker compose ps
docker compose logs
docker compose logs postgres
docker compose down
docker compose down -v
```

Use `docker compose down -v` carefully because it removes named volumes and local database data.

## 5. Service Design Checklist

- Services have clear names.
- Credentials come from environment variables.
- Persistent data uses named volumes.
- Required ports are documented.
- Health checks exist for databases.
- Startup order is handled with health checks where useful.
- Local-only services are not confused with production.

## 6. Production Notes

Docker Compose is excellent for local development and demos. It is usually not the final production deployment method for serious data platforms.

For production, consider managed databases, managed container platforms, secret managers, central logging, backups, and disaster recovery.

## 7. Common Mistakes

- Committing real secrets.
- Using `latest` image tags without control.
- Forgetting volumes and losing database data.
- Exposing unnecessary ports.
- Assuming local Compose behavior equals production reliability.
- Not documenting how to reset local state.
