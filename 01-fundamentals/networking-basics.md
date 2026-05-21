# Networking Basics

## 1. What It Is

Networking is how computers communicate with each other. For Data Engineering, networking basics include IP addresses, domains, ports, protocols, DNS, requests, responses, firewalls, and secure connections.

You do not need to become a network engineer, but you should understand enough to debug connection issues between scripts, APIs, databases, cloud services, and containers.

## 2. Why It Matters for Data Engineering

Data pipelines often connect to systems over a network:

- APIs
- Databases
- Cloud storage
- Data warehouses
- Message queues
- Dashboards
- Remote servers

When something fails, the problem may not be your SQL or Python code. It could be a wrong host, blocked port, expired certificate, DNS issue, firewall rule, or missing network permission.

## 3. When You Use It

You use networking basics when:

- Connecting a Python script to an API.
- Connecting to a database from your laptop.
- Running services in Docker.
- Mapping local ports to containers.
- Debugging timeout errors.
- Configuring cloud access.
- Understanding why a pipeline works locally but fails in production.

## 4. Real-World Example

A retail company has a pipeline that loads sales data into a cloud database. The pipeline works from the office but fails from a new server with a timeout.

Possible causes include:

- The database port is blocked.
- The server IP is not allowed by the database firewall.
- The database hostname cannot be resolved.
- Credentials are correct, but network access is denied.
- The database requires SSL.

A Data Engineer with networking basics can ask better questions and debug faster.

## 5. Basic Commands or Examples

Common networking concepts:

```text
IP address: numeric address of a machine
Domain name: human-readable name such as api.example.com
DNS: system that translates domain names to IP addresses
Port: numbered entry point for a service
HTTP: protocol commonly used by web APIs
HTTPS: encrypted HTTP
```

Example host and port:

```text
database.example.com:5432
```

In this example, `database.example.com` is the host and `5432` is the port.

Common service ports:

```text
80    HTTP
443   HTTPS
5432  PostgreSQL
3306  MySQL
6379  Redis
```

Example URL structure:

```text
https://api.example.com/orders?page=2&limit=100
```

Parts:

```text
https: protocol
api.example.com: domain
/orders: path
page=2&limit=100: query parameters
```

## 6. Common Mistakes

- Confusing a database name with a host name.
- Forgetting to include the correct port.
- Assuming local connections and production connections behave the same.
- Ignoring firewall and allowlist settings.
- Using `localhost` inside a container without understanding what it points to.
- Treating timeout errors as always being code errors.
- Sending sensitive data over unencrypted connections.

## 7. Practice Task

Choose a public API URL and identify:

1. Protocol
2. Domain
3. Path
4. Query parameters
5. Whether it uses HTTPS

Then describe how a data pipeline might use that API and what could go wrong if the network connection fails.

## 8. Related Project

- `03-python-for-data-engineering/`: API ingestion and database connection projects require networking basics.
- `13-cloud-data-engineering/`: Cloud data systems require understanding access, ports, and secure connections.
- `15-ai-ready-data-engineering/`: AI services and retrieval systems often depend on networked APIs.
