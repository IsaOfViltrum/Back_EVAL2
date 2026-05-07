# ══════════════════════════════════════════
# STAGE 1: Builder
# Instala dependencias de producción
# ══════════════════════════════════════════
FROM node:18-alpine AS builder

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia solo package.json primero
# Esto permite que Docker cachee esta capa
# y no reinstale si el código no cambió
COPY package*.json ./

# Instala SOLO dependencias de producción
RUN npm ci --omit=dev

# ══════════════════════════════════════════
# STAGE 2: Runtime
# Imagen final liviana y segura
# ══════════════════════════════════════════
FROM node:18-alpine AS runtime

# Crea un grupo y usuario sin privilegios root
# Esto es el "mínimo privilegio" que pide la evaluación
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Directorio de trabajo
WORKDIR /app

# Copia las dependencias instaladas en el stage anterior
COPY --from=builder /app/node_modules ./node_modules

# Copia el código fuente del backend
COPY server.js ./
COPY package*.json ./

# Da permisos al usuario no root sobre la carpeta
RUN chown -R appuser:appgroup /app

# Cambia al usuario sin privilegios
USER appuser

# Puerto que usa Express (según el README del repo)
EXPOSE 3000

# Comando para iniciar el servidor
CMD ["node", "server.js"]