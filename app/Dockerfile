# -----------------------------------------------------------------------------
# STAGE 1: Builder (Compilación e instalación de dependencias)
# -----------------------------------------------------------------------------
FROM python:3.11-slim AS builder

WORKDIR /build

# Instalación de herramientas de compilación mínimas
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc python3-dev && \
    rm -rf /var/lib/apt/lists/*

# Copiar solo el archivo de requerimientos para aprovechar la caché de Docker
COPY requirements.txt .

# Crear wheels o instalar dependencias en una carpeta aislada
RUN pip install --no-cache-dir --user -r requirements.txt

# -----------------------------------------------------------------------------
# STAGE 2: Runtime (Entorno de ejecución seguro)
# -----------------------------------------------------------------------------
FROM python:3.11-slim AS runner

# Definición de variables de entorno seguras
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PATH=/home/appuser/.local/bin:$PATH \
    PORT=8080

WORKDIR /app

# DevSecOps Best Practice: Crear usuario sin privilegios de root (UID 1001)
RUN groupadd -g 1001 appgroup && \
    useradd -u 1001 -g appgroup -s /bin/bash -m appuser

# Copiar las dependencias instaladas en la fase builder al usuario no-root
COPY --from=builder /root/.local /home/appuser/.local

# Copiar el código fuente con permisos asignados al usuario no-root
COPY --chown=appuser:appgroup main.py .

# Asignar la propiedad del directorio de trabajo
RUN chown -R appuser:appgroup /app

# Cambiar al usuario no-root (A partir de aquí NADA se ejecuta como root)
USER 1001

# Puerto expuesto en el contenedor
EXPOSE 8080

# Comprobación de salud nativa de Docker
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8080/health')" || exit 1

# Comando de arranque de la aplicación
CMD ["python", "main.py"]