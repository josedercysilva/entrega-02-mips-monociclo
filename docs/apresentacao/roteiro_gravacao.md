# Roteiro Estruturado de Gravação em Vídeo — Apresentação da Segunda Entrega

> **Disciplina:** Arquitetura de Sistemas Digitais e Laboratório (2026/2)  
> **Instituição:** Universidade Federal do Amazonas (UFAM) — Faculdade de Engenharia Elétrica e da Computação (FEEC)  
> **Tema:** Processador MIPS Monociclo de 32 bits com Instruções de Desvio (`j`, `jal`, `jr`, `beq`)  
> **Duração Estimada:** 8 minutos (Janela da Rubrica: entre 5 e 10 minutos)  
> **Apresentadores:** José Dercy Vieira da Silva Filho, Vinicius Menezes, Isabela Furtado  

---

## 1. Orientações Gerais de Produção e Gravação

- **Plataforma Recomendada:** Gravação via OBS Studio (ou chamada em grupo no Google Meet / Discord gravada em 1080p com áudio limpo).
- **Câmeras:** Todos com webcams ligadas em plano superior ou em layout de mosaico (3 câmeras) nas transições e na introdução/encerramento.
- **Divisão de Telas:**
  - **Slides:** Slides em PDF (`docs/apresentacao/slides_apresentacao.pdf`) em tela cheia.
  - **Terminal / GTKWave:** Terminal preto e GTKWave com zoom legível nos sinais principais.
  - **Intel Quartus Prime:** Projeto `quartus/mips_monociclo.qpf` já aberto com a janela do **RTL Viewer** em segundo plano pronta para exibição.

---

## 2. Cronograma Minuto a Minuto e Roteiro de Locução

```
+-----------------------------------------------------------------------------------------------+
| TEMPO       | RESPONSÁVEL     | TÓPICO PRINCIPAL               | AÇÃO VISUAL / DEIXA DE TELA  |
+-------------+-----------------+--------------------------------+------------------------------+
| 0:00 - 0:20 | Toda a Equipe   | Abertura Institucional         | Câmera com os 3 integrantes  |
| 0:20 - 1:15 | José Dercy      | ULA de 32 bits e Flags         | Slide 3 (Arquitetura da ULA) |
| 1:15 - 1:50 | José Dercy      | Simulação da ULA no GTKWave    | Terminal: make waves-alu     |
| 1:50 - 2:30 | José Dercy      | Síntese FPGA e RTL Viewer      | Intel Quartus Prime (RTL)    |
| 2:30 - 3:45 | Vinicius        | Banco de Registradores 32x32   | Slide 6 (Register File)      |
| 3:45 - 5:00 | Vinicius        | Unidade de Controle e Saltos   | Slide 7 (Controle e Jumps)   |
| 5:00 - 6:15 | Isabela         | Subsistema de Memória (ROM/RAM)| Slide 8 (Memórias Harvard)   |
| 6:15 - 6:40 | Isabela         | Fiação do Top-Level (Next PC)  | Slide 9 (Cascata de Muxes)   |
| 6:40 - 7:30 | Isabela         | Demonstração Top no GTKWave    | Terminal: make waves-top     |
| 7:30 - 7:50 | José Dercy      | Síntese Física no MAX 10 / CI  | Slide 11 (Resultados Finais) |
| 7:50 - 8:00 | Toda a Equipe   | Rubricas, Fechamento e Pipeline| Slide 12 e Câmera com os 3   |
+-----------------------------------------------------------------------------------------------+
```

---

### [0:00 — 0:20] Abertura Institucional
- **Visual:** Câmera aberta com os 3 alunos visíveis.
- **Locutor (José Dercy):**
  > *"Olá, professor e colegas. Somos alunos de Engenharia da Computação da Universidade Federal do Amazonas (UFAM). Eu sou o José Dercy, e comigo estão o Vinicius Menezes e a Isabela Furtado. Hoje apresentamos a Segunda Entrega do processador MIPS Monociclo de 32 bits da disciplina de Arquitetura de Sistemas Digitais, com foco na integração das instruções de desvio incondicional e condicional, verificação formal e síntese em FPGA."*

---

### [0:20 — 1:15] Bloco 1: Arquitetura da ULA de 32 bits
- **Visual:** Compartilhamento de tela com o **Slide 3**.
- **Locutor (José Dercy):**
  > *"Começando pelo caminho de dados, implementamos a ULA de 32 bits adotando a arquitetura canônica recomendada por Harris & Harris. Para economizar área no FPGA, evitamos sintetizar somadores e subtratores separados: utilizamos uma única cadeia de somador de 32 bits, onde a subtração é realizada por meio do complemento de dois, invertendo condicionalmente o operando B através de portas XOR e injetando o sinal de controle no bit de carry-in.*  
  > *A flag zero foi projetada com tempo de propagação mínimo utilizando redução unária com árvore NOR (`~|alu_result`), sem recursão condicional. Por fim, a operação `SLT` contempla a verificação assinada com tratamento estrito de overflow aritmético."*

---

### [1:15 — 1:50] Bloco 1: Demonstração da ULA no GTKWave
- **Visual:** Cortar para o terminal e executar o comando:
  ```bash
  make waves-alu
  ```
- **Locutor (José Dercy):**
  > *"Para validar a ULA antes da integração estrutural, criamos o testbench `tb_alu.v` com 11 casos de teste formais cobrindo operações lógicas, adições com carry, subtrações e casos de borda com números negativos.*  
  > *(Apontando no GTKWave com o cursor do mouse)*  
  > *Como podemos observar aqui nas formas de onda geradas no GTKWave, nas transições de controle vemos a execução correta da adição e, logo em seguida, a subtração de valores idênticos, momento exato em que o sinal `flag_zero` transita imediatamente para nível lógico 1. Todos os 11 testes foram aprovados com 100% de assertivas."*

---

### [1:50 — 2:30] Bloco 1: Síntese Física e RTL Viewer no Quartus
- **Visual:** Alternar para a janela do **Intel Quartus Prime 19.1 Lite** com o projeto `quartus/mips_monociclo.qpf`.  
  Acessar o menu: **Tools $\rightarrow$ Netlist Viewers $\rightarrow$ RTL Viewer**.
- **Locutor (José Dercy):**
  > *"Cumprindo a Rubrica 1 da disciplina, configuramos o fluxo de compilação física no Intel Quartus Prime apontando para o FPGA Intel MAX 10 (`10M50DAF484C7G`), presente na placa DE10-Lite.*  
  > *(No RTL Viewer, dar duplo clique na entidade `alu`)*  
  > *Visualizando aqui o diagrama RTL gerado pela síntese, podemos confirmar fisicamente a inferência do somador unificado de 32 bits conectado à árvore de multiplexação combinacional. A compilação física foi concluída com 0 erros. Passo agora a palavra ao Vinicius."*

---

### [2:30 — 3:45] Bloco 2: Banco de Registradores de 32 bits
- **Visual:** Compartilhamento de tela com o **Slide 6**.
- **Locutor (Vinicius Menezes):**
  > *"Obrigado, Dercy. Fiquei responsável pela implementação do Banco de Registradores e da Unidade de Controle.*  
  > *O módulo `reg_file.v` possui 32 registradores de 32 bits. Para viabilizar a execução em ciclo único, as portas de leitura são puramente combinacionais e assíncronas: assim que os índices `raddr1` e `raddr2` são decodificados da instrução, os dados são disponibilizados para a ULA no mesmo ciclo.*  
  > *A escrita, por outro lado, é síncrona na borda de subida do clock (`posedge clk`) e condicionada pelo sinal `reg_write`. Um ponto fundamental de projeto é que o registrador `$0` está amarrado fisicamente em zero por hardware (`hardwired zero`), garantindo que leituras em `$0` retornem sempre zero e escritas sejam descartadas."*

---

### [3:45 — 5:00] Bloco 2: Unidade de Controle e Decodificação de Saltos
- **Visual:** Compartilhamento de tela com o **Slide 7**.
- **Locutor (Vinicius Menezes):**
  > *"A Unidade de Controle foi projetada de forma modular e hierárquica, separando o decodificador principal do controle específico da ULA.*  
  > *O núcleo da Segunda Entrega foi o tratamento dos desvios: no caso do branch condicional `beq`, o controle gera o sinal `Branch` que é combinado em uma porta AND com a `flag_zero` da ULA. Para o salto incondicional direto `j`, ativamos o sinal `Jump`, derivando o endereço a partir do campo de 26 bits alinhado por palavra.*  
  > *Para a instrução `jal`, além do salto incondicional, o controle aciona os sinais necessários para escrever `PC+4` diretamente no registrador 31 (`$ra`). E para a instrução `jr`, o decodificador da ULA identifica o `funct 0x08`, gerando o sinal `JR_Control`, que comuta o próximo PC para o valor contido em `$ra`. Passo agora a palavra à Isabela."*

---

### [5:00 — 6:15] Bloco 3: Subsistema de Memória (ROM e RAM)
- **Visual:** Compartilhamento de tela com o **Slide 8**.
- **Locutor (Isabela Furtado):**
  > *"Olá a todos, sou a Isabela e apresento o subsistema de memórias e a integração do processador.*  
  > *Adotamos o modelo Harvard canônico, com memórias físicas segregadas para instruções e para dados, o que elimina qualquer conflito de acesso em monociclo.*  
  > *A Memória de Instruções (`instr_mem.v`) é uma ROM assíncrona de 256 palavras (1 KB), indexada por `pc[31:2]` para alinhamento em 4 bytes e inicializada via `$readmemh` com o binário compilado. Já a Memória de Dados (`data_mem.v`) é uma RAM que oferece leitura combinacional imediata para a instrução `lw` e escrita síncrona sensível ao clock sob habilitação do sinal `mem_write` para a instrução `sw`."*

---

### [6:15 — 6:40] Bloco 3: Fiação Estrutural do Top-Level
- **Visual:** Compartilhamento de tela com o **Slide 9**.
- **Locutor (Isabela Furtado):**
  > *"Na integração do caminho de dados e do módulo top-level, o maior rigor técnico esteve na cascata de seleção do próximo Program Counter (`next_pc`). Implementamos uma cascata ordenada de 3 multiplexadores:*  
  > *O primeiro avalia o branch condicional (`beq`); o segundo avalia saltos incondicionais diretos (`j` e `jal`); e o terceiro, com prioridade máxima, avalia o retorno de sub-rotina (`jr`), roteando o operando lido do registrador diretamente para o registrador do PC."*

---

### [6:40 — 7:30] Bloco 3: Demonstração do Top-Level no GTKWave
- **Visual:** Cortar para o terminal e executar o comando:
  ```bash
  make waves-top
  ```
- **Locutor (Isabela Furtado):**
  > *"Vamos agora visualizar a simulação completa do MIPS Monociclo executando o programa de teste.*  
  > *(Apontando no GTKWave com o mouse)*  
  > *Aqui temos os sinais principais: `clk`, `pc`, `instr`, `alu_result`, `jump`, `jal` e `jr_ctrl`.*  
  > *Podemos observar a sequência inicial de instruções `addi` e operações aritméticas. Quando o processador atinge o salto `beq`, o desvio é tomado corretamente após a verificação de igualdade.*  
  > *Em seguida, vemos o momento exato do `jal`: o sinal `jal` vai a nível alto, o PC salta para o endereço da sub-rotina e o endereço de retorno `PC+4` é armazenado no registrador `$31`. Poucos ciclos depois, a instrução `jr $ra` é executada e observamos o PC restaurar imediatamente o fluxo para a instrução subsequente ao salto, sem qualquer atraso ou falha de sincronismo."*

---

### [7:30 — 7:50] Resultados de Síntese no FPGA MAX 10 e Qualidade de Código
- **Visual:** Retornar para os slides, exibindo o **Slide 11**.
- **Locutor (José Dercy):**
  > *"Como evidenciado na síntese do Intel Quartus Prime, o caminho crítico do monociclo é delimitado pela instrução mais lenta, a `lw`, que percorre ROM, banco de registradores, ULA, memória RAM e multiplexador de retorno. Nosso projeto obteve 0 erros de compilação.*  
  > *Além disso, cumprindo a Rubrica 4, todos os 15 módulos HDL foram escritos com parametrização estrita (`DATA_WIDTH = 32`), e todo o fluxo de compilação, simulação e teste está 100% automatizado via Makefile e scripts nativos."*

---

### [7:50 — 8:00] Encerramento e Transição para Pipeline
- **Visual:** Exibir o **Slide 12** e alternar para a câmera final com os 3 alunos.
- **Locutores (Equipe reunida):**
  > **Isabela:** *"Comprovamos o atendimento integral das 5 rubricas da Segunda Entrega."*  
  > **Vinicius:** *"A arquitetura estruturada aqui serve como a base perfeita para a segmentação em 5 estágios com Hazards e Forwarding da Terceira Entrega."*  
  > **Dercy:** *"O código completo, os testbenches e o relatório técnico no padrão IEEE estão disponíveis em nosso repositório no GitHub. Agradecemos a atenção de todos!"*

---

## 3. Comandos de Terminal Utilizados Durante a Demonstração

Para os momentos de demonstração ao vivo durante a gravação:

1. **Demonstração da ULA no GTKWave (Minuto 1:20):**
   ```bash
   make waves-alu
   ```
2. **Síntese e Análise RTL no Intel Quartus Prime (Minuto 1:55):**
   ```bash
   make quartus
   # No Quartus Prime: Tools -> Netlist Viewers -> RTL Viewer
   ```
3. **Demonstração do Top-Level Completo no GTKWave (Minuto 6:40):**
   ```bash
   make waves-top
   ```
4. **Recompilação dos Slides Beamer:**
   ```bash
   make apresentacao
   ```
