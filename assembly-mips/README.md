# Programas em Assembly MIPS e Firmware de Teste (`assembly-mips`)

Este diretório contém os códigos-fonte em linguagem **Assembly MIPS32** e o código de máquina compilado (**firmware**) utilizados na validação do processador MIPS Monociclo.

---

## 1. Descrição dos Arquivos

| Arquivo | Descrição | Ambiente de Execução |
| :--- | :--- | :--- |
| **`sort.s`** | Código-fonte Assembly da sub-rotina canônica de ordenação (*Bubble/Insertion Sort* com sub-rotina `swap`), baseado na Seção 2.13 do livro *Computer Organization and Design* (Patterson & Hennessy). Não contém `main` nem chamadas de sistema (`syscall`), operando em regime *bare-metal* direto no hardware. | Montado para gerar o `sort.bin` |
| **`sort-teste.s`** | Programa Assembly completo com preâmbulo `main`, vetor inicial na seção `.data` (`50, 20, 100, 1, -9`), rotina de impressão (`print_vetor`) e chamadas de sistema `syscall` para teste visual em simulador. | Simulador MARS |
| **`sort.bin`** | Código de máquina em formato de texto binário (palavras de 32 bits compostas por caracteres `'0'` e `'1'`), gerado pelo exportador (*Dump Memory*) do MARS. É carregado estaticamente na memória ROM (`src/memory/instr_mem.v`) via diretiva `$readmemb`. | Processador MIPS (Verilog) |

---

## 2. Ambiente e Ferramenta Recomendada: MARS 4.5

Para montagem, depuração comportamental e exportação do código de máquina, a ferramenta recomendada é o:
* **MARS (MIPS Assembler and Runtime Simulator) — Versão 4.5**
* **Requisitos:** Java Runtime Environment (JRE 8 ou superior instalado).

### Executando o MARS
No terminal Linux:
```bash
java -jar Mars4_5.jar
```
*(Ou através de atalho / clique duplo no arquivo JAR).*

### Configurações Recomendadas no MARS (Settings)
No menu superior do MARS:
1. **Settings -> Memory Configuration:** Certifique-se de selecionar a opção **Default** (Compact, Data at `0x10010000`, Text at `0x00400000`).
2. **Settings -> Permit extended (pseudo) instructions and formats:** Mantenha **marcado** para permitir pseudo-instruções como `la` e `li` presentes em `sort-teste.s`.

---

## 3. Procedimento 1: Simulação Visual no MARS (`sort-teste.s`)

Este teste permite inspecionar a execução do algoritmo passo a passo com interface gráfica e verificar a ordenação do vetor no console:

1. No MARS, acesse **File -> Open...** e abra o arquivo `sort-teste.s`.
2. Monte o código pressionando **Run -> Assemble** (ou tecla de atalho **F3**).
3. Execute o programa pressionando **Run -> Go** (ou tecla de atalho **F5**).
4. No painel inferior (**Run I/O**), será exibida a evolução do vetor:
   ```text
   Vetor antes: 50 20 100 1 -9 
   Vetor depois: -9 1 20 50 100 
   -- program is finished running --
   ```

---

## 4. Procedimento 2: Geração do `sort.bin` para o Hardware a partir de `sort.s`

Se você modificar o algoritmo ou escrever um novo programa Assembly para ser executado pelo processador em Verilog, siga estes passos para gerar o arquivo `.bin` compatível com a ROM:

1. Abra o arquivo `sort.s` no MARS (**File -> Open...**).
2. Monte o programa: **Run -> Assemble** (ou **F3**).
3. No menu superior, clique em **File -> Dump Memory...**
4. Na janela de diálogo que se abrirá:
   * **Memory Segment:** Selecione `.text (0x00400000 - ...)` (todo o segmento de código gerado).
   * **Dump Format:** Selecione **Binary** *(este formato exporta 32 caracteres ASCII '0' e '1' por linha, compatível com a diretiva `$readmemb` do Verilog)*.
   * **Destination File:** Clique em *Dump To File* e salve com o nome `sort.bin` neste mesmo diretório (`assembly-mips/sort.bin`).
5. O arquivo gerado estará no formato exato lido pelo processador na inicialização da ROM.
