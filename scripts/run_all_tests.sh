#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SIM_SCRIPT="${ROOT_DIR}/scripts/run_simulation.sh"

GREEN="\033[0;32m"
RED="\033[0;31m"
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
BOLD="\033[1m"
RESET="\033[0m"

MODULES=("alu" "datapath_aux" "reg_file" "control_unit" "instr_mem" "data_mem" "top")
PASSED=0
FAILED=0
declare -a FAILED_MODULES=()

echo -e "${BOLD}${BLUE}====================================================${RESET}"
echo -e "${BOLD}${BLUE}   Bateria Completa de Regressão - MIPS Monociclo   ${RESET}"
echo -e "${BOLD}${BLUE}====================================================${RESET}"

for mod in "${MODULES[@]}"; do
    echo -e "\n${BOLD}==> Testando: ${mod}${RESET}"
    if "${SIM_SCRIPT}" "${mod}"; then
        echo -e "${GREEN}[APROVADO]${RESET} ${mod}"
        PASSED=$((PASSED + 1))
    else
        echo -e "${RED}[REPROVADO]${RESET} ${mod}"
        FAILED=$((FAILED + 1))
        FAILED_MODULES+=("${mod}")
    fi
done

echo -e "\n${BOLD}${BLUE}====================================================${RESET}"
echo -e "${BOLD}Resumo da Execução:${RESET}"
echo -e "  Aprovados: ${GREEN}${PASSED}${RESET}"
echo -e "  Falhas:    ${RED}${FAILED}${RESET}"
echo -e "${BOLD}${BLUE}====================================================${RESET}"

if [[ ${FAILED} -gt 0 ]]; then
    echo -e "${RED}[FALHA GERAL] Módulos com erro: ${FAILED_MODULES[*]}${RESET}"
    exit 1
else
    echo -e "${GREEN}[SUCESSO TOTAL] Todos os módulos foram validados com êxito!${RESET}"
    exit 0
fi
