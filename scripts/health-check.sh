#!/usr/bin/env bash
# ==============================================================================
# Script: health-check.sh
# Descripción: Comprueba la disponibilidad de un endpoint HTTP mediante curl.
# Uso: ./health-check.sh [URL] [MAX_REINTENTOS] [ESPERA_SEGUNDOS]
# Ejemplo: ./health-check.sh http://localhost:8080/health 5 2
# ==============================================================================

set -euo pipefail

TARGET_URL="${1:-http://localhost:8080/health}"
MAX_RETRIES="${2:-5}"
SLEEP_INTERVAL="${3:-3}"

# Colores para salida en terminal
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "=================================================="
echo -e "       EVALUACIÓN DE SALUD DE SERVICIO (CI/CD)"
echo -e "=================================================="
echo -e "URL de prueba:     $TARGET_URL"
echo -e "Reintentos máx:    $MAX_RETRIES"
echo -e "Espera entre retry: ${SLEEP_INTERVAL}s\n"

for ((i=1; i<=MAX_RETRIES; i++)); do
    echo -n "Intento $i/$MAX_RETRIES: "
    
    # Obtener el código de respuesta HTTP silenciando la salida de descarga
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$TARGET_URL" || true)

    if [ "$HTTP_STATUS" -eq 200 ]; then
        echo -e "[ ${GREEN}SUCCESS${NC} ] El servicio responde correctamente (HTTP Status 200)."
        exit 0
    fi

    echo -e "[ ${YELLOW}WAITING${NC} ] Código HTTP recibido: $HTTP_STATUS. Reintentando en ${SLEEP_INTERVAL}s..."
    sleep "$SLEEP_INTERVAL"
done

echo -e "\n[ ${RED}FAILED${NC} ] El servicio no respondió con estado HTTP 200 tras $MAX_RETRIES intentos."
exit 1