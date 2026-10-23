# Set bash as the interpreter shell
set shell := ["/bin/bash", "-c"]

# Set default recipe to display help
default: help

# Optional service filter passed as a variable (e.g., just logs s=backend or just logs backend)
s := ""

# List targets and descriptions
[no-cd]
help:
    @just --list

# Generate .env + judge0.conf with random secrets (never overwrites)
init:
    @./scripts/init-env.sh

# Build and start the whole stack in the background
up:
    docker compose up -d --build
    @echo ""
    @echo "Started. Wait ~1-2 min for first build + migrations, then: just check"

# Stop everything (data volumes are kept)
down:
    docker compose down

# Restart all services, or one: just restart s=backend
restart service=s:
    docker compose restart {{service}}

# Status + health of every service
ps:
    docker compose ps -a

# Follow logs of everything, or one service: just logs backend
logs service=s:
    docker compose logs -f --tail=100 --timestamps {{service}}

# Errors from the last hour across all services
errors:
    @docker compose logs --no-color --since 1h | grep -Ei 'error|fatal|exception|panic|unhealthy' || echo "no errors in the last hour"

# Live CPU / memory per container
stats:
    docker stats

# Rebuild without cache and restart (all, or: just rebuild frontend)
rebuild service=s:
    docker compose build --no-cache {{service}}
    docker compose up -d {{service}}

# Re-run migrations + idempotent seed (also runs automatically on `up`)
migrate:
    docker compose run --rm migrate

# Create/promote an admin: just admin email=a@b.com pass='Str0ng!Pass' name='Admin'
admin email pass name="Admin":
    docker compose exec backend node dist/db/createAdmin.js "{{email}}" "{{pass}}" "{{name}}"

# Open a psql shell in the app database
psql:
    docker compose exec postgres sh -c 'psql -U $$POSTGRES_USER -d$$POSTGRES_DB'

# Dump the app database to ./backup-<timestamp>.sql
backup:
    #!/usr/bin/env bash
    filename="backup-$(date +\%Y\%m\%d-\%H\%M\%S).sql" docker compose exec -T postgres sh -c 'pg_dump -U $$POSTGRES_USER$$POSTGRES_DB' > "$filename"
    ls -1t backup-*.sql | head -1

# DANGER: stop and delete ALL data (databases, uploads)
clean:
    #!/usr/bin/env bash
    read -p "This deletes every volume (app DB, Judge0 DB, resume uploads). Type 'yes': " a
    [ "$a" = "yes" ] || { echo "aborted"; exit 1; }
    docker compose down -v --remove-orphans