# Complete-deployment

A small Node.js service used as the foundation for an end-to-end DevOps
automation project. The application is intentionally simple. The goal of the
project is the platform around it: containers, CI/CD, infrastructure as code,
Kubernetes, GitOps, observability, and reliability engineering.

## Application

A Node.js HTTP service with two GET endpoints:

| Endpoint | Purpose |
|---|---|
| `GET <HEALTH_PATH>` | Health check |
| `GET <INFO_PATH>` | Server information and technology stack |

## Prerequisites

- Docker
- Docker Compose
- Make
- Node.js (only needed to run without Docker)

## Run locally

With Docker Compose:

```bash
docker compose up --build
```

With Make:

```bash
make <TARGET>
```

Verify it works:

```bash
curl -i http://localhost:<PORT><HEALTH_PATH>
```

## Repository layout

```
.
├── index.js             # Application entry point
├── package.json         # Dependencies and scripts
├── package-lock.json    # Locked dependency versions
├── Dockerfile           # Container image definition
├── docker-compose.yml   # Local development environment
├── Makefile             # Common development commands
├── .dockerignore        # Files excluded from the image build
└── .gitignore           # Files excluded from version control
```

## Project status

Only items marked **Done** have been implemented and tested.

| Phase | Area | Status |
|---|---|---|
| 1 | Node.js + Docker | Done |
| 2 | Docker Compose + Makefile | Done |
| 3 | Git + GitHub | In progress |
| 4 | Jenkins CI pipeline | Planned |
| 5 | SonarQube + Trivy | Planned |
| 6 | Terraform (AWS) | Planned |
| 7 | Ansible | Planned |
| 8 to 20 | K3s, Helm, Argo CD, load balancing, monitoring, backup, load testing, SRE | Planned |

## Security notes

- No credentials are stored in this repository.
- `.env` files are excluded from Git and from Docker images.
