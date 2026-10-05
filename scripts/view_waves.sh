#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="${ROOT_DIR}/build"

RED="\033[0;31m"
BLUE="\033[0;34m"
RESET="\033[0m"

TARGET="${1:-}"

if [[ -n "${TARGET}" ]]; then
    VCD_FILE="${BUILD_DIR}/${TARGET}.vcd"
    if [[ ! -f "${VCD_FILE}" ]]; then
        VCD_FILE="${ROOT_DIR}/${TARGET}.vcd"
    fi
else
    VCD_FILE="$(find "${BUILD_DIR}" "${ROOT_DIR}" -maxdepth 1 -name "*.vcd" -printf '%T@ %p\n' 2>/dev/null | sort -nr | head -n 1 | awk '{print $2}' || true)"
fi

if [[ -z "${VCD_FILE:-}" || ! -f "${VCD_FILE}" ]]; then
    echo -e "${RED}[ERRO]${RESET} Nenhum arquivo .vcd encontrado."
    echo "Execute primeiro: ./scripts/run_simulation.sh <alvo>"
    exit 1
fi

echo -e "${BLUE}==>${RESET} Abrindo GTKWave com: ${VCD_FILE}"
gtkwave "${VCD_FILE}" > /dev/null 2>&1 &
