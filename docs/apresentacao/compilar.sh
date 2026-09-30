#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

MAIN_TEX="slides_apresentacao.tex"
PDF_OUT="slides_apresentacao.pdf"

echo "=== Compilando slides de apresentação (Beamer) com Tectonic ==="
tectonic "$MAIN_TEX"

if [ -f "$PDF_OUT" ]; then
    echo "=== Sucesso! Slides gerados em: $PDF_OUT ==="
else
    echo "Erro: PDF não foi gerado."
    exit 1
fi
