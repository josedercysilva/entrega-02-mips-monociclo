# Processador MIPS Monociclo de 32 bits

> **Segunda Entrega** da disciplina de **Arquitetura de Sistemas Digitais e Laboratório**  
> **Universidade Federal do Amazonas (UFAM)** — Faculdade de Engenharia Elétrica e da Computação (FEEC)  
> **Autores:** José Dercy Vieira da Silva Filho e Vinicius Menezes  
> **Plataforma Alvo:** FPGA Intel MAX 10 (`10M50DAF484C7G`) — Placa Terasic DE10-Lite  

---

## Visão Geral

Implementação em Verilog HDL de um processador **MIPS Monociclo de 32 bits** sob a norma IEEE Std 1364-2005. O projeto adota arquitetura **Harvard** com memórias e barramentos estritamente desacoplados para instruções (ROM) e dados (RAM), garantindo execução com $\text{CPI} = 1$.

O processador foi validado ponta a ponta executando o algoritmo canônico de ordenação (*Sort*) de Patterson & Hennessy (`sort.s` $\to$ `sort.bin`), em regime puramente *bare-metal* sobre lógica reconfigurável, integrando suporte completo a desvios e saltos (`beq`, `bne`, `j`, `jal` e `jr`).

---

## Estrutura do Repositório

```text
.
├── Makefile                # Orquestrador de testes, simulação, síntese e documentação
├── docs/                   # Documentação técnica e científica
│   ├── apresentacao/       # Slides em LaTeX Beamer e link do vídeo da sabatina
│   └── relatorio/          # Relatório técnico no formato IEEE (6 páginas em LaTeX)
├── quartus/                # Projeto de síntese física para FPGA Intel MAX 10 (.qpf / .qsf)
├── scripts/                # Scripts de automação para simulação e GTKWave
├── src/                    # Código-fonte Verilog HDL do processador
│   ├── control/            # Unidade de Controle (main_control, alu_control, control_unit)
│   ├── datapath/           # Caminho de dados (alu, pc, reg_file, somadores e multiplexadores)
│   ├── memory/             # Subsistema Harvard (ROM instr_mem e RAM data_mem)
│   └── mips_monociclo_top.v# Nível de topo estrutural interconectando os módulos
├── tb/                     # Suíte de 7 bancadas de teste e binário do benchmark sort
└── hex/                    # Arquivos auxiliares de código de máquina (.hex / .bin)
```

---

## Repertório de Instruções Suportado

O conjunto de 13 instruções foi selecionado para atender de forma ótima aos procedimentos `sort` (não-folha) e `swap` (folha) da convenção MIPS ABI:

| Formato | Instruções | Função no Algoritmo |
| :---: | :--- | :--- |
| **Tipo-R** | `add`, `sub`, `and`, `or`, `nor`, `slt` | Operações aritméticas, lógicas e comparações com sinal |
| **Tipo-R** | `sll` | Indexação de palavras do vetor na memória ($j \times 4 \equiv j \ll 2$) |
| **Tipo-R** | `jr` | Retorno de função via registrador `$ra` com trava de proteção |
| **Tipo-I** | `lw`, `sw` | Acesso de leitura e escrita na memória de dados (RAM) |
| **Tipo-I** | `addi`, `slti` | Alocação de pilha (`$sp`), incrementos e avaliação de parada (`j < 0`) |
| **Tipo-I** | `beq`, `bne` | Desvios condicionais por igualdade e diferença nos laços |
| **Tipo-J** | `j`, `jal` | Salto incondicional e chamada de sub-rotina com salvamento de `PC + 4` em `$ra` |

---

## Guia Rápido de Execução

Todo o fluxo de compilação, simulação, síntese e documentação é encapsulado no `Makefile`:

```bash
# Executa a suíte de regressão completa (7 testbenches, 48 testes)
make test

# Simula a integração top-level executando o algoritmo sort.bin
make top

# Inspeciona as formas de onda da última simulação no GTKWave
make waves-top

# Executa a síntese física completa no Intel Quartus Prime (gera bitstream .sof)
make quartus-build

# Grava o bitstream (.sof) no FPGA MAX 10 via USB-Blaster
make quartus-pgm

# Compila o relatório técnico IEEE em PDF via Tectonic
make relatorio
```

---

## Resumo de Resultados e Validação

* **Simulação Comportamental (Icarus Verilog):** 48 testes automatizados em 7 bancadas unitárias e de integração com **100% de aprovação (0 falhas)**.
* **Benchmark Sort:** Ordenação comprovada do vetor de `[88, 15, 42, 7, 99]` para `[7, 15, 42, 88, 99]`.
* **Síntese Física (Intel MAX 10 `10M50DAF484C7G`):**
  * 17.089 Logic Elements (LEs) e 131 pinos de E/S.
  * **0 latches transparentes espúrios** (lógica 100% síncrona e combinacional coberta).
  * Distribuição de relógio via redes dedicadas globais `CLKCTRL_G3` e `CLKCTRL_G4`.
* **Documentação Científica:** Artigo técnico de 6 páginas balanceadas no padrão IEEE Transactions compilado em [`docs/relatorio/relatorio_segunda_entrega.pdf`](file:///home/jdercy/01-dev/03-periodos-ufam/08-periodo/01-arquitetura/entrega-02-mips-monociclo/docs/relatorio/relatorio_segunda_entrega.pdf).
