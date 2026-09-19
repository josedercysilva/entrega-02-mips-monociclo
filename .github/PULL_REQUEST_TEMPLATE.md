## Descrição do Pull Request

Descreva o módulo ou funcionalidade implementada.

* **Módulos alterados:** `src/...`
* **Testbench correspondente:** `tb/...`

---

## Critérios de Aceitação (Checklist Obrigatório)

Para aprovação e integração na branch `main`, marque todos os itens abaixo confirmando a execução técnica local:

- [ ] **1. Contrato de Interface:** O módulo em `src/` mantém rigorosamente as portas (`input`/`output`) e parâmetros (ex: `DATA_WIDTH`) definidos no *skeleton* inicial.
- [ ] **2. Testbench Unitário:** O arquivo de teste correspondente foi criado ou atualizado na pasta `tb/`.
- [ ] **3. Simulação RTL (Icarus Verilog):** O código compila e executa localmente sem erros sintáticos ou falhas.
- [ ] **4. Validação Visual (GTKWave):** As formas de onda foram inspecionadas e atestam o comportamento esperado do circuito lógico.
- [ ] **5. Commit Limpo:** Nenhum artefato de compilação ou arquivo temporário (`.vcd`, `.out`, `.vvp`, diretórios do Quartus) foi incluído no repositório.

> Política de Integração: Pull Requests sem testbench anexado ou com falha de simulação serão rejeitados.