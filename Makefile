setup:
	echo "Configurando el entorno..."

compose-up:
	echo "Iniciando servicios con Docker Compose..."

compose-down:
	echo "Deteniendo servicios con Docker Compose..."

migrate-up:
	echo "Aplicando migraciones de base de datos..."

migrate-down:
	echo "Revirtiendo migraciones de base de datos..."

migrate-reset:
	echo "Reiniciando migraciones de base de datos..."

lint:
	echo "Ejecutando linter..."

test:
	echo "Ejecutando pruebas..."

run-api:
	echo "Iniciando la API..."

run-worker:
	echo "Iniciando el worker..."

build-api:
	echo "Construyendo la imagen de la API..."

build-worker:
	echo "Construyendo la imagen del worker..."
