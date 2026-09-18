#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

MAIN_TEX="relatorio_segunda_entrega.tex"
PDF_OUT="relatorio_segunda_entrega.pdf"

echo "=== Compilando relatório da Entrega 2 (IEEE) com Tectonic ==="
tectonic "$MAIN_TEX"

if [ -f "$PDF_OUT" ]; then
    echo "=== Sucesso! Arquivo gerado: $PDF_OUT ==="
else
    echo "Erro: PDF não foi gerado."
    exit 1
fi
