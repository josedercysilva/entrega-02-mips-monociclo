# Processador MIPS Monociclo de 32 bits (Segunda Entrega)

Projeto desenvolvido para a disciplina de **Arquitetura de Sistemas Digitais e Laboratório** do **Instituto de Computação (IComp)** da **Universidade Federal do Amazonas (UFAM)** — Manaus, Amazonas.

Esta segunda entrega contempla o projeto, implementação em Verilog HDL e validação do processador **MIPS Monociclo de 32 bits**, parametrizado e com suporte completo a instruções de desvio incondicional (*Jumps*: `j`, `jal`, `jr`), testado através da execução do algoritmo de ordenação (*Bubble Sort* - rotinas `sort` e `swap`).

---

## Ambiente de Desenvolvimento e Ferramentas

A tabela a seguir documenta as ferramentas utilizadas no ciclo de desenvolvimento, simulação, síntese, montagem e documentação do projeto, com suas respectivas versões identificadas no ambiente de trabalho:

| Categoria | Ferramenta | Versão | Função no Projeto |
| :--- | :--- | :--- | :--- |
| **Simulação e Validação RTL** | **Icarus Verilog (`iverilog`)** | `13.0 (stable)` | Compilador e simulador HDL obrigatório para a execução dos *testbenches* unitários e validação do Top-Level. |
| **Simulação e Validação RTL** | **GTKWave** | `3.3.128` | Visualizador de formas de onda utilizado para a inspeção temporal dos sinais gerados nos arquivos de *dump* (`.vcd`). |
| **Síntese e Prototipagem** | **Intel Quartus Prime (Lite Edition)** | `19.1.0 Build 670 SJ` | Ambiente de síntese lógica, mapeamento da pinagem e roteamento direcionado ao chip **Intel MAX 10** (FPGA DE10-Lite). |
| **Síntese e Prototipagem** | **Drivers USB-Blaster / USB-Blaster II** | `19.1.0 (udev/jtagd)` | Interface de comunicação física necessária para a gravação do arquivo de programação na placa Altera DE10-Lite. |
| **Tradução e Memória** | **MARS (MIPS Assembler & Runtime Simulator)** | `4.5` | Ambiente de montagem e depuração comportamental do algoritmo de ordenação, utilizado primariamente para validar a lógica dos desvios. |
| **Tradução e Memória** | **`mips-linux-gnu-binutils` (GNU Binutils)** | `2.45.1` | Conjunto de utilitários acionado para a extração do código de máquina bruto, garantindo a geração do arquivo hexadecimal (`.hex`) para a inicialização da ROM. |
| **Versionamento e Documentação** | **Git** | `2.55.0` | Infraestrutura de versionamento submetida às regras de proteção de *branch* e validação de contratos de interface. |
| **Versionamento e Documentação** | **Tectonic** | `0.17.0` | Motor de tipografia moderno acionado via terminal para a compilação autônoma do relatório técnico no padrão `IEEEtran`. |

### Detalhamento das Ferramentas

#### 1. Simulação e Validação RTL
* **Icarus Verilog (`13.0`):** Utilizado para compilar e executar todos os bancos de teste (`tb/tb_*.v`). Garante a verificação comportamental antes da etapa de síntese em hardware.
* **GTKWave (`3.3.128`):** Empregado na análise visual de temporização, transições de clock, escrita no banco de registradores e leitura da memória de dados.

#### 2. Síntese e Prototipagem em Hardware
* **Intel Quartus Prime Lite Edition (`19.1.0`):** Responsável pela síntese lógica, geração do RTL Viewer e estimativa de uso de elementos lógicos para o FPGA Intel MAX 10 (`10M50DAF484C7G`).
* **Drivers USB-Blaster II:** Configurados via regras de dispositivo (*udev rules*) no Linux para comunicação JTAG transparente com a placa DE10-Lite.

#### 3. Tradução de Software e Memória
* **MARS (`4.5`):** Utilizado para teste comportamental do código Assembly das rotinas `sort` e `swap`, inspeção de registradores e validação dos saltos incondicionais e links (`jal` / `jr`).
* **mips-linux-gnu-binutils (`2.45.1`):** *Cross-assembler* e utilitários (`objcopy`, `objdump`) utilizados no pipeline automatizado de conversão de assembly MIPS para formato legível pelo `$readmemh` da memória de instruções.

#### 4. Controle de Versão e Documentação
* **Git (`2.55.0`):** Gestão e rastreabilidade de código-fonte, histórico de commits e organização das entregas parciais.
* **Tectonic (`0.17.0`):** Compilação de passo único do relatório técnico em LaTeX (`docs/relatorio/relatorio_segunda_entrega.tex`), resolvendo automaticamente dependências do `IEEEtran` e BibTeX.

---

## Estrutura do Repositório

```text
.
├── contexto
│   ├── especifiaao-entrega2-integra-classroom.md
│   ├── especificacao-geral-disciplina.md
│   ├── projeto-arquitetura-integra.md
│   └── rubricas-entrega-02.md
├── docs
│   ├── apresentacao
│   │   ├── link_video_youtube.txt
│   │   └── slides_apresentacao.pdf
│   └── relatorio
│       ├── 000-figuras
│       │   ├── diagrama_datapath.png
│       │   └── wave_jumps.png
│       ├── 100-secoes
│       │   ├── 100-metadados.tex
│       │   ├── 101-introducao.tex
│       │   ├── 102-ambiente_desenvolvimento.tex
│       │   ├── 103-especificacao_monociclo_jumps.tex
│       │   ├── 104-testbenches_resultados.tex
│       │   ├── 105-consideracoes_finais.tex
│       │   └── 106-bibliografia.tex
│       ├── 200-bib
│       │   ├── IEEEabrv.bib
│       │   ├── IEEEexample.bib
│       │   ├── IEEEfull.bib
│       │   ├── IEEEtranS.bst
│       │   └── referencias.bib
│       ├── compilar.sh
│       ├── IEEEtran.bst
│       ├── IEEEtran.cls
│       ├── README.md
│       ├── relatorio_segunda_entrega.pdf
│       └── relatorio_segunda_entrega.tex
├── hex
│   ├── machine_code.bin
│   └── sort_swap.hex
├── quartus
│   ├── mips_monociclo.qpf
│   └── mips_monociclo.qsf
├── README.md
├── scripts
│   ├── run_simulation.sh
│   └── view_waves.sh
├── src
│   ├── control
│   │   ├── alu_control.v
│   │   ├── control_unit.v
│   │   └── main_control.v
│   ├── datapath
│   │   ├── adder.v
│   │   ├── alu.v
│   │   ├── datapath.v
│   │   ├── mux2to1.v
│   │   ├── mux3to1.v
│   │   ├── mux4to1.v
│   │   ├── pc.v
│   │   ├── reg_file.v
│   │   └── sign_extend.v
│   ├── memory
│   │   ├── data_mem.v
│   │   └── instr_mem.v
│   └── mips_monociclo_top.v
└── tb
    ├── tb_alu.v
    ├── tb_control_unit.v
    ├── tb_instr_mem.v
    ├── tb_mips_monociclo_top.v
    └── tb_reg_file.v

16 directories, 53 files


```


