# Especificação Geral da Disciplina: Processador MIPS em Verilog

Documento consolidado a partir da especificação oficial da disciplina de **Arquitetura de Sistemas Digitais e Laboratório** (UFAM).

---

## 1. Escopo e Diretrizes Globais

O objetivo do projeto é implementar, na linguagem de descrição de hardware **Verilog HDL**, um processador **MIPS de 32 bits**, considerando o tratamento de perigos estruturais, de dados e de controle (*hazards*).
A referência bibliográfica central para a descrição dos blocos funcionais é:
> **D. A. Patterson e J. L. Hennessy**, *Computer Organization and Design: The Hardware / Software Interface*, 4ª ed. revisada, Academic Press, 2012.

---

## 2. Requisitos Técnicos Mandatórios

1. **Modularização em Bibliotecas:**
   - Devem ser criadas bibliotecas separadas para cada bloco funcional do processador (ex: Banco de Registradores, ALU, Unidade de Controle, Memórias).
2. **Parametrização Rigorosa:**
   - **Todos os blocos funcionais devem ser construídos utilizando parâmetros (`parameter`)**, de modo que larguras de barramento e profundidade possam ser modificadas facilmente.
3. **Plataforma de Prototipagem em Hardware:**
   - O código resultante deve ser sintetizado e embarcado em uma placa **FPGA** (Altera DE10-Lite / Intel MAX 10).
4. **Relatório Técnico IEEE:**
   - Deve ser redigido utilizando o modelo oficial de conferência do IEEE (`IEEEtran`).
5. **Critério de Avaliação em Equipe:**
   - O projeto é desenvolvido e entregue em equipe de até 3 integrantes. Penalidade de 2 pontos por dia de atraso após o prazo estipulado.

---

## 3. Algoritmo de Teste Padrão (Benchmark)

O processador deve ser testado e validado executando o algoritmo de ordenação (*Bubble Sort*) em memória, obedecendo rigorosamente à alocação de registradores definida pelo professor:

### Código em C:
```c
void sort (int v[], int n) {
    int i, j;
    for (i = 0; i < n; i += 1) {
        for (j = i - 1; j >= 0 && v[j] > v[j + 1]; j -= 1) {
            swap(v, j);
        }
    }
}

void swap (int v[], int k) {
    int temp;
    temp = v[k];
    v[k] = v[k + 1];
    v[k + 1] = temp;
}
```

### Convenção Estrita de Registradores:
- **Ponteiro base do vetor $v$:** armazenado em `$a0`
- **Tamanho do vetor $n$:** armazenado em `$a1`
- **Índice $i$ (laço externo):** mapeado no registrador salvo `$s0`
- **Índice $j$ (laço interno):** mapeado no registrador salvo `$s1`

---

## 4. Cronograma de Entregas Parciais

| Etapa | Data de Apresentação | Foco Principal |
| :--- | :--- | :--- |
| **1ª Entrega** | 11 de Setembro de 2026 | Software Base, Mapeamento C $\rightarrow$ Assembly $\rightarrow$ Código de Máquina |
| **2ª Entrega** | 09 de Outubro de 2026 | MIPS Monociclo com Jumps, Testbenches parametrizados, Quartus e Vídeo |
| **3ª Entrega** | 13 de Novembro de 2026 | Inserção do Pipeline de 5 Estágios e Unidade de Detecção de Hazards |
| **4ª Entrega** | 11 de Dezembro de 2026 | Integração Final Top-Level, Forwarding completo e Síntese em FPGA |
