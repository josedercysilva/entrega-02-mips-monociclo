SHELL := /usr/bin/env bash

QUARTUS_BIN_DIR ?= /home/jdercy/01-dev/programas/opt_intel/quartus/bin
export PATH := $(QUARTUS_BIN_DIR):$(PATH)

.PHONY: all help test alu reg_file control instr_mem data_mem top waves waves-alu waves-top relatorio apresentacao quartus quartus-build quartus-pgm clean

all: top

help:
	@echo "Alvos disponíveis no Makefile:"
	@echo "  make alu           - Executa o testbench da ALU"
	@echo "  make reg_file      - Executa o testbench do Register File"
	@echo "  make control       - Executa o testbench da Unidade de Controle"
	@echo "  make instr_mem     - Executa o testbench da Memória de Instruções"
	@echo "  make data_mem      - Executa o testbench da Memória de Dados"
	@echo "  make top           - Executa a simulação do MIPS Monociclo Top-Level"
	@echo "  make test          - Executa toda a bateria de testes de regressão"
	@echo "  make quartus       - Executa Análise e Elaboração rápida no Intel Quartus Prime"
	@echo "  make quartus-build - Compilação Completa (Síntese + Fitter + Geração do Bitstream .sof)"
	@echo "  make quartus-pgm   - Grava o bitstream (.sof) na placa DE10-Lite via USB-Blaster"
	@echo "  make waves         - Abre a última simulação gerada no GTKWave"
	@echo "  make waves-alu     - Abre as formas de onda da ALU no GTKWave"
	@echo "  make waves-top     - Abre as formas de onda do Top-Level no GTKWave"
	@echo "  make relatorio     - Compila o relatório IEEE em LaTeX via Tectonic"
	@echo "  make apresentacao  - Compila os slides da apresentação em LaTeX Beamer via Tectonic"
	@echo "  make clean         - Remove arquivos compilados e temporários (.vvp, .vcd)"

alu:
	@./scripts/run_simulation.sh alu

reg_file:
	@./scripts/run_simulation.sh reg_file

control:
	@./scripts/run_simulation.sh control_unit

instr_mem:
	@./scripts/run_simulation.sh instr_mem

data_mem:
	@./scripts/run_simulation.sh data_mem

top:
	@./scripts/run_simulation.sh top

test:
	@./scripts/run_all_tests.sh

quartus:
	@echo "Executando Análise e Elaboração no Intel Quartus Prime..."
	@cd quartus && quartus_map mips_monociclo --analysis_and_elaboration

quartus-build:
	@echo "==> [1/3] Análise e Síntese (quartus_map)..."
	@cd quartus && quartus_map mips_monociclo
	@echo "==> [2/3] Mapeamento e Roteamento (quartus_fit)..."
	@cd quartus && quartus_fit mips_monociclo
	@echo "==> [3/3] Geração do Bitstream .sof (quartus_asm)..."
	@cd quartus && quartus_asm mips_monociclo
	@echo "[OK] Bitstream gerado com sucesso em quartus/output_files/mips_monociclo.sof"

quartus-pgm:
	@echo "Verificando conexão JTAG com a placa DE10-Lite..."
	@jtagconfig
	@echo "Gravando bitstream no FPGA Intel MAX 10..."
	@cd quartus && quartus_pgm -m jtag -c 1 -o "p;output_files/mips_monociclo.sof"

waves:
	@./scripts/view_waves.sh

waves-alu:
	@./scripts/view_waves.sh alu

waves-top:
	@./scripts/view_waves.sh top

relatorio:
	@cd docs/relatorio && ./compilar.sh

apresentacao:
	@cd docs/apresentacao && ./compilar.sh

clean:
	@./scripts/clean.sh
