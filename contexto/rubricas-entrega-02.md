# Orientações e Rubricas da Segunda Entrega: MIPS Monociclo com Jumps

- **Data Limite:** 09/10/2026 até às 13:59h.
- **Formato de Entrega:** Apresentação em vídeo (YouTube) + Relatório Técnico no modelo IEEE (`IEEEtran`).
- **Penalidade:** -2 pontos por dia de atraso.

---

## Rubrica de Avaliação (5 Critérios Essenciais)

| Item | Critério | Requisitos Técnicos | Onde Está no Projeto |
| :---: | :--- | :--- | :--- |
| **1** | **Ambiente de Desenvolvimento** | Configuração do fluxo de ferramentas (Intel Quartus Prime para síntese; Icarus Verilog + GTKWave para simulação). | `quartus/`, `scripts/run_simulation.sh` |
| **2** | **Caminho de Dados com Jumps** | Especificação e implementação completa do MIPS Monociclo incluindo saltos incondicionais (`j`), chamada com link (`jal`) e retorno por registrador (`jr`). | `src/datapath/`, `src/control/`, `src/mips_monociclo_top.v` |
| **3** | **Baterias de Testbenches** | **Todos** os componentes individuais (ALU, RegFile, Controle, Memória) e o Top-Level devem possuir testbenches com validação comportamental. | `tb/tb_*.v` |
| **4** | **Código 100% Parametrizado** | Todos os módulos em Verilog devem usar declaração de parâmetros (`parameter DATA_WIDTH = 32`, etc.). | Módulos em `src/` |
| **5** | **Apresentação em Vídeo** | Vídeo gravado e publicado no YouTube explicando a arquitetura, mostrando a simulação no GTKWave e a síntese no Quartus. | `docs/apresentacao/link_video_youtube.txt` |

---

## Mapeamento com o Relatório IEEE

Cada seção modular do relatório técnico em `docs/relatorio/100-secoes/` responde diretamente a uma rubrica:
- `102-ambiente_desenvolvimento.tex` $\rightarrow$ Item 1 (Quartus, ModelSim, FPGA DE10-Lite).
- `103-especificacao_monociclo_jumps.tex` $\rightarrow$ Itens 2 e 4 (Caminho de dados com Jumps e parametrização).
- `104-testbenches_resultados.tex` $\rightarrow$ Item 3 (Validação dos módulos e simulação do Top-Level).
- `105-consideracoes_finais.tex` $\rightarrow$ Item 5 (Conclusão e link do vídeo no YouTube).
