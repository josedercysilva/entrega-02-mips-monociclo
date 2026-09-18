# Relatório Técnico da Segunda Entrega: Processador MIPS Monociclo com Desvios

Este diretório contém o projeto LaTeX completo do relatório técnico referente à **Entrega 02** da disciplina de Arquitetura de Sistemas Digitais. O documento está rigorosamente estruturado conforme o padrão internacional para publicações e conferências do **IEEE** (`IEEEtran`), pronto para compilação moderna e automatizada com o **Tectonic**.

---

## Estrutura Modular do Projeto

O relatório foi concebido em uma arquitetura modular por seções numeradas, facilitando a escrita simultânea, versionamento no Git e manutenção do código:

```text
relatorio/
├── README.md                      <- Este documento com especificações e créditos
├── compilar.sh                    <- Script para compilação automatizada de 1 clique
├── relatorio_segunda_entrega.tex  <- Documento principal (preâmbulo, estilos e montagem)
├── IEEEtran.cls                   <- Classe oficial de conferência da IEEE
├── IEEEtran.bst                   <- Motor de estilo bibliográfico oficial da IEEE
├── 000-figuras/                   <- Diagramas RTL do Quartus, formas de onda e esquemáticos
├── 100-secoes/                    <- Módulos textuais divididos conforme as rubricas
│   ├── 100-metadados.tex          <- Título do artigo, autores e afiliações acadêmicas (UFAM)
│   ├── 101-introducao.tex         <- Motivação, arquitetura MIPS e objetivos da entrega
│   ├── 102-ambiente_desenvolvimento.tex <- Rubrica 1: Intel Quartus Prime, GTKWave e FPGA DE10-Lite
│   ├── 103-especificacao_monociclo_jumps.tex <- Rubricas 2 e 4: Caminho de dados parametrizado e Jumps (j, jal, jr)
│   ├── 104-testbenches_resultados.tex <- Rubrica 3: Testbenches dos blocos e integração Top-Level
│   ├── 105-consideracoes_finais.tex   <- Rubrica 5: Conclusões, link do YouTube e transição para Pipeline
│   └── 106-bibliografia.tex       <- Inclusão dinâmica do BibTeX
└── 200-bib/                       <- Gestão bibliográfica
    ├── referencias.bib            <- Base de referências no padrão BibTeX
    ├── IEEEabrv.bib / IEEEfull.bib<- Abreviaturas e formatos oficiais da IEEE
    └── IEEEtranS.bst / IEEEexample.bib
```

---

## Compilação com Tectonic

O fluxo de build utiliza o compilador **Tectonic**, que gerencia de forma autônoma e em segundo plano todas as passadas necessárias do motor TeX e do BibTeX.

### Modo Rápido (Recomendado):
Execute o script auxiliar na raiz de `relatorio/`:
```bash
./compilar.sh
```

### Modo Manual:
```bash
tectonic relatorio_segunda_entrega.tex
```

O PDF gerado (`relatorio_segunda_entrega.pdf`) atenderá fielmente a todas as exigências tipográficas, margens e diagramação em duas colunas da IEEE.

---

## Gestão Automatizada de Referências (BibTeX)

A chamada bibliográfica está configurada no motor `IEEEtran.bst` através do arquivo `200-bib/referencias.bib`.

* **Omissão Automática de Referências Não Utilizadas:** Entradas mantidas no banco `.bib` que não receberem uma citação explícita `\cite{...}` em nenhuma seção do texto são **automaticamente omitidas** da listagem final de referências no PDF.
* **Numeração Sequencial Estrita:** As obras citadas são numeradas automaticamente no formato IEEE (`[1]`, `[2]`, `[3]`, etc.) estritamente na ordem em que aparecem no fluxo da leitura.

---

## Transparência e Uso do Ecossistema Google

Em conformidade com os mais elevados padrões de integridade acadêmica, ética e transparência técnica, registra-se que o processo de desenvolvimento documental, automação de compilação, pesquisa e suporte operacional utilizou ativamente ferramentas do **Ecossistema Google**:

1. **Google Antigravity (Google DeepMind):**
   - Atuou como agente de engenharia e codificação no ambiente de desenvolvimento.
   - Responsável pelo transporte e estruturação da base LaTeX no padrão IEEE (`IEEEtran`), configuração do compilador **Tectonic**, resolução dos estilos BibTeX, eliminação de redundâncias e criação dos scripts de automação de compilação e versionamento.

2. **Google NotebookLM:**
   - Empregado como ferramenta de inteligência aumentada para ancoragem e síntese de fontes bibliográficas técnicas.
   - Utilizado no processamento e consulta rápida das notas de aula, literatura de referência de Patterson \& Hennessy e especificações didáticas da disciplina de Arquitetura de Sistemas Digitais.

3. **Google Workspace (Google Docs, Drive e Ferramentas Colaborativas):**
   - Plataforma adotada pelos integrantes da equipe para o trabalho síncrono e assíncrono de rascunho textual, alinhamento de ideias, revisão por pares das seções e compartilhamento de materiais preliminares antes da conversão final para o ambiente LaTeX.

> **Nota:** Toda a concepção arquitetural dos circuitos em Verilog HDL, a lógica dos blocos funcionais do MIPS monociclo, a depuração dos sinais de controle, o desenvolvimento dos *testbenches* e a análise crítica dos dados de simulação são de autoria e responsabilidade integral dos membros da equipe.
