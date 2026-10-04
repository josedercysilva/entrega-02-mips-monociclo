#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

GREEN="\033[0;32m"
BLUE="\033[0;34m"
RESET="\033[0m"

echo -e "${BLUE}==>${RESET} Limpando artefatos temporários de simulação..."

rm -rf "${ROOT_DIR}/build"
find "${ROOT_DIR}" -maxdepth 2 -type f \( -name "*.vvp" -o -name "*.vcd" -o -name "a.out" -o -name "dump.vcd" \) -exec rm -f {} +

echo -e "${BLUE}==>${RESET} Limpando diretórios e lixos do Intel Quartus Prime..."
rm -rf "${ROOT_DIR}/quartus/db" "${ROOT_DIR}/quartus/incremental_db" "${ROOT_DIR}/quartus/output_files"
find "${ROOT_DIR}/quartus" -type f \( -name "*.qws" -o -name "*.rpt" -o -name "*.smsg" -o -name "*.summary" -o -name "*.jdi" -o -name "*.pin" -o -name "*.sld" \) -exec rm -f {} + 2>/dev/null || true

echo -e "${GREEN}[OK]${RESET} Ambiente limpo com sucesso."
