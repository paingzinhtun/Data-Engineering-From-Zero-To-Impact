# Secrets Management

## 1. What It Is

Secrets management is the practice of securely storing, accessing, rotating, and auditing sensitive values such as passwords, API keys, tokens, certificates, and private keys.

Secrets should not be stored directly in source code, documentation, or committed configuration files.

## 2. Why It Matters

Data pipelines often connect to databases, APIs, warehouses, cloud storage, and SaaS tools. Exposed credentials can lead to data leaks, account compromise, or production damage.

Secrets management helps protect:

- Customer data.
- Financial data.
- API integrations.
- Warehouse credentials.
- Cloud resources.
- Production systems.

## 3. When to Use It

Use secrets management whenever a project needs:

- Database passwords.
- API tokens.
- Cloud credentials.
- SSH keys.
- Encryption keys.
- Service account credentials.

Even learning projects should avoid committing fake-looking but reusable secrets.

## 4. Real Business Example

A retail pipeline pulls ecommerce orders from an API and loads them into a warehouse.

The API token and warehouse password should be stored in a secret manager or secure CI/CD variable, not inside the Python script or README.

The pipeline should read the secret at runtime.

## 5. Technical Example

Bad pattern:

```python
API_TOKEN = "real-token-value"
```

Better pattern:

```python
import os


api_token = os.getenv("ECOMMERCE_API_TOKEN")
if not api_token:
    raise EnvironmentError("Missing ECOMMERCE_API_TOKEN")
```

Production pattern:

```text
secret manager stores token
  -> runtime injects token as environment variable or mounted secret
  -> pipeline reads token
  -> token value is never committed
```

## 6. Production Considerations

- Use managed secrets services where possible.
- Grant secret access only to required identities.
- Rotate secrets periodically.
- Audit secret access.
- Avoid logging secret values.
- Keep `.env` files out of Git.
- Use separate secrets for development and production.
- Revoke secrets immediately if exposed.

## 7. Common Mistakes

- Committing API keys.
- Sharing one database password across all users and jobs.
- Logging connection strings with passwords.
- Storing secrets in plain text config files.
- Giving every service access to every secret.
- Not rotating long-lived credentials.
- Not knowing which pipelines use a secret.

## 8. Practice Task

Review a pipeline project and identify:

1. Required secrets.
2. Where each secret should be stored.
3. Which service needs access.
4. How the secret is injected.
5. How rotation would work.
6. How exposure would be handled.
7. What should be added to `.gitignore`.

## 9. Related Project

- `13-cloud-data-engineering/iam-and-security.md`: Cloud IAM and secret access should work together.
- `14-production-engineering/environment-variables.md`: Environment variables can carry injected secret values.
- `CONTRIBUTING.md`: Contributions must not include secrets or private credentials.
