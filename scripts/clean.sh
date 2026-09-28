#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

GREEN="\033[0;32m"
BLUE="\033[0;34m"
RESET="\033[0m"

echo -e "${BLUE}==>${RESET} Limpando artefatos temporários de simulação..."

rm -rf "${ROOT_DIR}/build"
find "${ROOT_DIR}" -maxdepth 2 -type f \( -name "*.vvp" -o -name "*.vcd" -o -name "a.out" -o -name "dump.vcd" \) -exec rm -f {} +

echo -e "${GREEN}[OK]${RESET} Ambiente limpo com sucesso."
