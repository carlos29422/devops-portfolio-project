#!/usr/bin/env bash
# ==============================================================================
# Script: setup.sh
# Descripción: Valida la presencia de dependencias CLI requeridas en el sistema.
# Estándar DevSecOps: Manejo explícito de errores y códigos de salida.
# ==============================================================================

set -euo pipefail

# Colores para salida formateada en terminal
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "=================================================="
echo -e "   VERIFICACIÓN DE HERRAMIENTAS DEVOPS LOCAL"
echo -e "==================================================\n"

REQUIRED_TOOLS=("git" "docker" "python3" "curl")
INFRA_TOOLS=("terraform" "kubectl" "helm" "gcloud")

MISSING_REQUIRED=0

check_tool() {
    local tool=$1
    local is_required=$2

    if command -v "$tool" &> /dev/null; then
        local version_info
        version_info=$("$tool" --version 2>&1 | head -n 1)
        echo -e "[ ${GREEN}OK${NC} ] $tool está instalado -> $version_info"
    else
        if [ "$is_required" = "true" ]; then
            echo -e "[ ${RED}ERROR${NC} ] $tool NO está instalado (Requerido para el flujo actual)."
            MISSING_REQUIRED=$((MISSING_REQUIRED + 1))
        else
            echo -e "[ ${YELLOW}WARN${NC} ] $tool no encontrado (Se utilizará en fases posteriores)."
        fi
    fi
}

echo "--- Herramientas Base ---"
for tool in "${REQUIRED_TOOLS[@]}"; do
    check_tool "$tool" "true"
done

echo -e "\n--- Herramientas de Cloud e Infraestructura ---"
for tool in "${INFRA_TOOLS[@]}"; do
    check_tool "$tool" "false"
done

echo -e "\n--------------------------------------------------"
if [ $MISSING_REQUIRED -eq 0 ]; then
    echo -e "${GREEN}Verificación completada: Todas las herramientas base están listas.${NC}"
    exit 0
else
    echo -e "${RED}Atención: Faltan $MISSING_REQUIRED herramientas base en el sistema.${NC}"
    exit 1
fi