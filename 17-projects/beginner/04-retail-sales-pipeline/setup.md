# Setup

## Prerequisites

- Python 3.10 or newer
- Docker and Docker Compose

## 1. Start PostgreSQL

From this project folder:

```bash
docker compose up -d
```

## 2. Create Environment File

Copy `.env.example` to `.env` and adjust values if needed.

## 3. Install Python Dependencies

```bash
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
```

On macOS or Linux:

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## 4. Run The Pipeline

Run commands from this project folder so relative paths resolve clearly:

```bash
python src/main.py
```

## 5. Run Tests

```bash
pytest
```

## Environment Variables

See `.env.example` for required values.

The pipeline loads `.env` from this project folder. Do not commit a real `.env` file with private credentials.
