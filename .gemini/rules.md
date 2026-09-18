# Diretrizes e Regras do Projeto MIPS Monociclo (Entrega 02)

Este documento define o contexto operacional, convenções arquiteturais e restrições obrigatórias para o assistente **Antigravity** neste repositório.

---

## 1. Identificação do Projeto e Equipe
- **Disciplina:** Arquitetura de Sistemas Digitais e Laboratório (UFAM)
- **Equipe:** José Dercy Vieira da Silva Filho, Vinicius Menezes, Isabela Furtado
- **Plataforma Alvo:** FPGA Intel MAX 10 / Altera DE10-Lite (10M50DAF484C7G)
- **Software de Síntese:** Intel Quartus Prime
- **Simulação RTL:** Icarus Verilog e GTKWave (`scripts/run_simulation.sh`)

---

## 2. Regras Mandatórias de Hardware (Verilog HDL)
1. **Parametrização Obrigatória:**
   - Todo módulo deve obrigatoriamente declarar parâmetros para barramentos e dimensões (ex.: `parameter DATA_WIDTH = 32`, `ADDR_WIDTH = 32`). Módulos sem parametrização violam a Rubrica 4.
2. **Modularização por Bibliotecas:**
   - Caminho de dados em `src/datapath/` (ALU, Register File, Somadores, Multiplexadores, Extensores de Sinal).
   - Controle em `src/control/` (Unidade de Controle Principal e Controle da ALU).
   - Memória em `src/memory/` (Memória de Instruções ROM e Memória de Dados RAM).
   - Integração Top-Level em `src/mips_monociclo_top.v`.
3. **Instruções de Salto (Jumps):**
   - O caminho de dados deve contemplar obrigatoriamente:
     - `j`: Salto incondicional (`PC = {PC+4[31:28], instr[25:0], 2'b00}`).
     - `jal`: Salto incondicional com salvamento do endereço de retorno (`Reg[31] = PC+4`).
     - `jr`: Retorno de função carregando registrador (`PC = Reg[rs]`).
4. **Testbenches Individuais e Top-Level:**
   - Cada componente deve ter um testbench correspondente em `tb/` (ex.: `tb_alu.v`, `tb_reg_file.v`, `tb_control_unit.v`, `tb_mips_monociclo_top.v`).

---

## 3. Convenção de Registradores do Benchmark (Bubble Sort)
Para conformidade estrita com o roteiro da disciplina:
- `$a0` (`$4`): Endereço base do vetor `v`
- `$a1` (`$5`): Tamanho `n` ou índice `k`
- `$s0` (`$16`): Variável `i` do laço externo
- `$s1` (`$17`): Variável `j` do laço interno
- `$sp` (`$29`): Ponteiro de pilha
- `$ra` (`$31`): Endereço de retorno de procedimento

---

## 4. Padrões do Relatório Técnico (LaTeX)
- Local: `docs/relatorio/`
- Arquivo principal: `relatorio_segunda_entrega.tex`
- Compilador padrão: **Tectonic** (`./compilar.sh` ou `tectonic relatorio_segunda_entrega.tex`)
- Modelo obrigatório: **IEEE Conference (`IEEEtran`)**
- Bibliografia: Gerenciada via BibTeX em `200-bib/referencias.bib` com estilo `IEEEtran.bst`. Omissão automática de referências não citadas e numeração sequencial de citações.




////

---

## 5. Fluxo de Trabalho e Versionamento (GitHub)
- **Gestão do Repositório (José Dercy):**
  - **Branch Protection:** Proibido push direto na `main`. Tudo ocorre via Pull Request (PR).
  - **Contratos (Skeletons):** O desenvolvimento de qualquer módulo começa pela criação da estrutura contendo apenas as declarações de portas (`input`, `output`, `parameter`) para garantir nomes de sinais padronizados.
  - **Critério de Aceitação de PR:** Um módulo só está concluído e pronto para merge se vier acompanhado de seu respectivo `testbench` unitário rodando sem erros no Icarus Verilog/GTKWave.

## 6. Divisão de Responsabilidades
- **José Dercy Vieira da Silva Filho (Integração, DevOps e Documentação):** Automação (`scripts/`), projeto Quartus, módulo ULA (`alu.v`), integração Top-Level (`mips_monociclo_top.v`), simulação geral com geração das formas de onda finais, redação do Relatório Técnico em LaTeX e montagem dos slides para o vídeo de defesa.
- **Isabela Furtado (Datapath & Memória):** Módulos de suporte (`pc.v`, `reg_file.v`, `sign_extend.v`, `mux2to1.v`) e memórias (`instr_mem.v`, `data_mem.v`), além de seus respectivos testbenches unitários.
- **Vinicius Menezes (Controle):** Módulos da Unidade de Controle (`main_control.v`, `alu_control.v`) e seus testbenches unitários.