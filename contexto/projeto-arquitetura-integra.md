# Projeto de Arquitetura de Sistemas Digitais

## Implementação em Linguagem de Descrição de Hardware do Processador MIPS

No projeto da disciplina de arquitetura de sistemas digitais e laboratório, a equipe deverá implementar na linguagem de descrição de hardware Verilog, o processador MIPS com pipeline considerando perigos de controle, dados e estrutural. A descrição completa de cada bloco funcional pode ser encontrada em [1].

Criem bibliotecas para cada um dos blocos funcionais do processador MIPS com o intuito de modularizar o projeto do processador. Todos os blocos devem ser criados usando parâmetros, de maneira que possam ser modificados facilmente.

Além disso, o código resultante desta implementação deve ser embarcado em um FPGA (*Field-Programmable Gate Array*) e testado usando o programa C/assembly mostrado logo abaixo (considere a variável `v` em `$a0`, `n` em `$a1`, `i` em `$s0` e `j` em `$s1`).

Vale ressaltar que, além da implementação do processador, a equipe também deverá escrever um relatório técnico, descrevendo todos os blocos funcionais do processador MIPS, código implementado e os testes que foram realizados para cada bloco funcional com o intuito de garantir o correto funcionamento do sistema. Cada grupo deverá escrever este relatório técnico usando o seguinte template da IEEE: [https://www.ieee.org/conferences/publishing/templates.html](https://www.ieee.org/conferences/publishing/templates.html?utm_source=gemini).

### Procedimento de ordenação em C

```c
void sort(int v[], int n) {
    int i, j;
    for (i = 0; i < n; i += 1) {
        for (j = i - 1; j >= 0 && v[j] > v[j + 1]; j -= 1) {
            swap(v, j);
        }
    }
}

void swap(int v[], int k) {
    int temp;
    temp = v[k];
    v[k] = v[k + 1];
    v[k + 1] = temp;
}

```

---

## Referências

* **[1]** D. A. Patterson and J. L. Hennessy, *Computer Organization and Design - The Hardware / Software Interface* (Revised 4th Edition). The Morgan Kaufmann Series, Academic Press, 2012.

---

## Datas das Apresentações Parciais

O progresso do projeto será acompanhado através de apresentação e relatório técnico, mensalmente, de acordo com o seguinte planejamento:

* **Primeira apresentação:** 11 de setembro de 2026;
* **Segunda apresentação:** 9 de outubro de 2026;
* **Terceira apresentação:** 13 de novembro de 2026;
* **Quarta apresentação:** 11 de dezembro de 2026;

Após esta data será descontado 2 pontos por dia de atraso. O projeto pode ser desenvolvido e entregue em equipe de 3 integrantes.