# Backend — API REST Node.js + Express + MySQL

## Descripción
API REST para gestión de usuarios desarrollada con Node.js y Express,
desplegada en contenedores Docker sobre AWS EC2 para Innovatech Chile.

## Tecnologías
- Node.js 18 + Express
- MySQL 5.7
- Docker (multi-stage build)
- GitHub Actions (CI/CD)
- AWS EC2

## Requisitos locales
- Docker Desktop
- Docker Compose

## Variables de entorno
Copia `.env.example` como `.env` y completa:
```env
PORT=3000
DB_HOST=database
DB_PORT=3306
DB_USER=appuser
DB_PASSWORD=tu_password
DB_ROOT_PASSWORD=tu_root_password
DB_NAME=proyecto_db
```

## Cómo ejecutar localmente
```bash
docker-compose up --build
# API disponible en http://localhost:3000
```

## Endpoints disponibles
- GET    /api/usuarios       → Lista todos los usuarios
- POST   /api/usuarios       → Crea un usuario
- PUT    /api/usuarios/:id   → Actualiza un usuario
- DELETE /api/usuarios/:id   → Elimina un usuario

## Pipeline CI/CD
- Trigger: push a rama `deploy`
- Build imagen Docker → Push a Docker Hub → Deploy en EC2

## Decisiones técnicas
- **Multi-stage build**: reduce el tamaño de la imagen final
- **Usuario no root**: seguridad de mínimo privilegio
- **Named volume**: la data de MySQL persiste entre reinicios
- **Rama deploy**: separa desarrollo de producción
- **MySQL 5.7**: compatible con t3.micro de AWS Academy