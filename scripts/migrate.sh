#!/usr/bin/env bash
set -e
set -o allexport
source .env
set +o allexport
migrate -path migrations -database "$DATABASE_URL" "$@"

# At root project directory:
# chmod +x scripts/migrate.sh
