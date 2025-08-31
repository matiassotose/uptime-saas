# =========
# Makefile
# =========

# Usa bash para poder 'source .env'
SHELL := /bin/bash

# Helper: carga .env y exporta variables antes de ejecutar un comando
define dotenv
	set -a; \
	[ -f .env ] && source .env; \
	set +a; \
	$(1)
endef

.PHONY: setup compose-up compose-down compose-down-hard \
        migrate-up migrate-down migrate-reset migrate-version migrate-create \
        lint test run-api run-worker build-api build-worker

# -----------------------
# Entorno / Herramientas
# -----------------------
setup:
	@echo "Configurando el entorno..."
	@echo "Asegúrate de tener instalados: migrate, golangci-lint, sqlc"

# -------------
# Docker Compose
# -------------
compose-up:
	@echo "Iniciando servicios con Docker Compose..."
	docker compose up -d

compose-down:
	@echo "Deteniendo servicios con Docker Compose (sin borrar volúmenes)..."
	docker compose down

compose-down-hard:
	@echo "Deteniendo servicios y borrando volúmenes (DEV RESET)..."
	docker compose down -v

# -----------
# Migraciones
# -----------
migrate-up:
	@echo "Aplicando migraciones de base de datos..."
	@$(call dotenv, migrate -path migrations -database "$$DB_DSN_HOST" up)

migrate-down:
	@echo "Revirtiendo última migración..."
	@$(call dotenv, migrate -path migrations -database "$$DB_DSN_HOST" down 1)

migrate-reset:
	@echo "Reiniciando migraciones (DROP + UP) — ¡BORRA TODO! Solo dev."
	@$(call dotenv, migrate -path migrations -database "$$DB_DSN_HOST" drop -f)
	@$(call dotenv, migrate -path migrations -database "$$DB_DSN_HOST" up)

migrate-version:
	@echo "Mostrando versión actual de migraciones..."
	@$(call dotenv, migrate -path migrations -database "$$DB_DSN_HOST" version)

# Usa: make migrate-create name=nombre_de_la_migracion
migrate-create:
	@test -n "$(name)" || (echo "Falta el nombre: make migrate-create name=mi_cambio"; exit 1)
	@echo "Creando nueva migración: $(name)"
	migrate create -ext sql -dir migrations -seq $(name)

# -----
# Calidad
# -----
lint:
	@echo "Ejecutando linter..."
	golangci-lint run ./...

test:
	@echo "Ejecutando pruebas..."
	go test ./...

# ------
# Ejecutar
# ------
run-api:
	@echo "Iniciando la API..."
	go run ./cmd/api

run-worker:
	@echo "Iniciando el worker..."
	go run ./cmd/worker

# -----
# Build
# -----
build-api:
	@echo "Construyendo binario de la API..."
	mkdir -p bin
	go build -o bin/api ./cmd/api

build-worker:
	@echo "Construyendo binario del worker..."
	mkdir -p bin
	go build -o bin/worker ./cmd/worker
