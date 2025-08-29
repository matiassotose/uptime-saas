# uptime-saas

Monitoreo simple de APIs con alertas en tiempo real.\
Proyecto de aprendizaje en **Go (chi)** con enfoque SaaS.

------------------------------------------------------------------------

## 🚀 Stack

-   **Go 1.25**\
-   **chi** (router HTTP)\
-   **PostgreSQL 16** (persistencia)\
-   **Redis 7** (colas, cache, rate limiting)\
-   **MailDev** (testing de correos)\
-   **golang-migrate** (migraciones de base de datos)\
-   **Docker Compose** (entorno local)

------------------------------------------------------------------------

## 📂 Estructura

    cmd/           # binarios principales (api, worker)
    internal/      # lógica interna (auth, checks, etc.)
    pkg/           # librerías reutilizables
    migrations/    # archivos de migraciones .sql
    docker-compose.yaml
    .env.example   # variables de entorno (ejemplo)
    Makefile       # tareas de desarrollo
    README.md

------------------------------------------------------------------------

## ⚙️ Entorno de desarrollo

### 1. Variables de entorno

Copia el archivo de ejemplo y ajusta si es necesario:

``` bash
cp .env.example .env
```

### 2. Levantar servicios

``` bash
make compose-up
```

Esto arranca: - Postgres en `localhost:5432`\
- Redis en `localhost:6379`\
- MailDev (UI en <http://localhost:1080>)

### 3. Migraciones

``` bash
make migrate-up
```

### 4. Apagar servicios

``` bash
make compose-down
```

------------------------------------------------------------------------

## 🛠️ Tareas disponibles

Usa `make <target>`:

-   `setup` → configura entorno local\
-   `compose-up` / `compose-down` → levanta o baja servicios Docker\
-   `migrate-up` / `migrate-down` / `migrate-reset` → gestiona
    migraciones\
-   `lint` → corre linters\
-   `test` → ejecuta tests\
-   `run-api` / `run-worker` → inicia binarios en local (cuando
    existan)\
-   `build-api` / `build-worker` → compila binarios (cuando existan)

------------------------------------------------------------------------

## 🧭 Roadmap (MVP)

1.  Autenticación básica (signup/login con JWT).\
2.  CRUD de checks (crear, listar, pausar).\
3.  Ejecutor de checks en background (worker).\
4.  Resultados y alertas (email/Slack).\
5.  Dashboard simple.

------------------------------------------------------------------------

## 📜 Licencia

MIT -- libre para aprender y reutilizar.