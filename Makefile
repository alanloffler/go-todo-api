
.PHONY: help migrate-up migrate-down migrate-version migrate-force db-reset run test build air

help:
	@echo ""
	@echo "Comandos disponibles:"
	@echo "  make air               Ejecuta la API con air"
	@echo "  make migrate-up        Ejecuta migraciones (up)"
	@echo "  make migrate-down      Revierte última migración"
	@echo "  make migrate-version   Muestra versión actual"
	@echo "  make migrate-force     Fuerza versión (uso: make migrate-force V=1)"
	@echo "  make db-reset          Reset completo de DB (LOCAL ONLY)"
	@echo "  make run               Ejecuta la API"
	@echo "  make test              Ejecuta tests"
	@echo "  make build             Compila el binario"
	@echo ""

migrate-up:
	./scripts/migrate.sh up

migrate-down:
	./scripts/migrate.sh down

migrate-version:
	./scripts/migrate.sh version

migrate-force:
	@if [ -z "$(V)" ]; then echo "❌ Debes pasar V=<version>"; exit 1; fi
	./scripts/migrate.sh force $(V)

db-reset:
	@echo "⚠️  Reset LOCAL de la base de datos"
	./scripts/migrate.sh force 1 || true
	./scripts/migrate.sh up

run:
	go run ./cmd/api

test:
	go test ./...

build:
	go build -o bin/api ./cmd/api

air:
	air
