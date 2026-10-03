#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="${ROOT_DIR}/build"

GREEN="\033[0;32m"
RED="\033[0;31m"
BLUE="\033[0;34m"
RESET="\033[0m"

TARGET="${1:-}"

if [[ -z "${TARGET}" ]]; then
    echo -e "${RED}[ERRO]${RESET} Alvo de simulação não especificado."
    echo "Uso: $0 <alu | reg_file | control_unit | instr_mem | data_mem | top>"
    exit 1
fi

mkdir -p "${BUILD_DIR}"
cd "${ROOT_DIR}"

declare -a SRC_FILES=()
TB_FILE=""
OUT_VVP="${BUILD_DIR}/${TARGET}.vvp"

case "${TARGET}" in
    alu)
        SRC_FILES=("src/datapath/alu.v")
        TB_FILE="tb/tb_alu.v"
        ;;
    datapath_aux)
        SRC_FILES=(
            "src/datapath/pc.v"
            "src/datapath/adder.v"
            "src/datapath/sign_extend.v"
            "src/datapath/mux2to1.v"
            "src/datapath/mux3to1.v"
            "src/datapath/mux4to1.v"
        )
        TB_FILE="tb/tb_datapath_aux.v"
        ;;
    reg_file)
        SRC_FILES=("src/datapath/reg_file.v")
        TB_FILE="tb/tb_reg_file.v"
        ;;
    control_unit)
        SRC_FILES=(
            "src/control/main_control.v"
            "src/control/alu_control.v"
            "src/control/control_unit.v"
        )
        TB_FILE="tb/tb_control_unit.v"
        ;;
    instr_mem)
        SRC_FILES=("src/memory/instr_mem.v")
        TB_FILE="tb/tb_instr_mem.v"
        ;;
    data_mem)
        SRC_FILES=("src/memory/data_mem.v")
        TB_FILE="tb/tb_data_mem.v"
        ;;
    top|mips_monociclo_top)
        TARGET="mips_monociclo_top"
        OUT_VVP="${BUILD_DIR}/mips_monociclo_top.vvp"
        SRC_FILES=(
            "src/datapath/pc.v"
            "src/datapath/adder.v"
            "src/datapath/mux2to1.v"
            "src/datapath/mux3to1.v"
            "src/datapath/mux4to1.v"
            "src/datapath/sign_extend.v"
            "src/datapath/reg_file.v"
            "src/datapath/alu.v"
            "src/datapath/datapath.v"
            "src/control/main_control.v"
            "src/control/alu_control.v"
            "src/control/control_unit.v"
            "src/memory/instr_mem.v"
            "src/memory/data_mem.v"
            "src/mips_monociclo_top.v"
        )
        TB_FILE="tb/tb_mips_monociclo_top.v"
        ;;
    *)
        echo -e "${RED}[ERRO]${RESET} Alvo '${TARGET}' desconhecido."
        echo "Opções válidas: alu, reg_file, control_unit, instr_mem, data_mem, top"
        exit 1
        ;;
esac

if [[ ! -f "${TB_FILE}" ]]; then
    echo -e "${RED}[ERRO]${RESET} Testbench não encontrado: ${TB_FILE}"
    exit 1
fi

echo -e "${BLUE}==>${RESET} Compilando ${TARGET} com Icarus Verilog..."
iverilog -g2012 -Wall \
    -I "${ROOT_DIR}/src/datapath" \
    -I "${ROOT_DIR}/src/control" \
    -I "${ROOT_DIR}/src/memory" \
    -o "${OUT_VVP}" \
    "${SRC_FILES[@]}" "${TB_FILE}"

echo -e "${BLUE}==>${RESET} Executando simulação..."
vvp "${OUT_VVP}"

echo -e "${GREEN}[OK]${RESET} Simulação de '${TARGET}' concluída com sucesso."
