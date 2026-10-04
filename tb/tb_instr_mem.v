// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratório
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxílio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Testbench: tb_instr_mem — Teste unitário da Memória de Instruções (ROM)
// ============================================================================

`timescale 1ns / 1ps

module tb_instr_mem;

    localparam DATA_WIDTH = 32;
    localparam ADDR_WIDTH = 32;
    
    reg  [ADDR_WIDTH-1:0] addr;
    wire [DATA_WIDTH-1:0] instr;
    
    integer tests  = 0;
    integer errors = 0;
    
    instr_mem #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .MEM_DEPTH(256),
        .INIT_FILE("tb/programa_teste.bin")
    ) uut (
        .addr(addr),
        .instr(instr)
    );
    
    initial begin
        $display("==========================================================");
        $display("   Iniciando Testbench da Memória de Instruções (Fase 3)  ");
        $display("==========================================================");
        
        #10; // Aguarda a inicialização estática via $readmemb
        
        // 1. Lendo endereço 0
        tests = tests + 1;
        addr = 32'd0;
        #5;
        if (instr !== 32'h00000000) begin
            $display("[ERRO] Falha no endereço 0x0. Obtido: 0x%08h", instr);
            errors = errors + 1;
        end else begin
            $display("[PASS] Leitura do endereço 0x0 (Palavra 0) OK.");
        end
        
        // 2. Lendo endereço 4 (Palavra 1)
        tests = tests + 1;
        addr = 32'd4;
        #5;
        if (instr !== 32'h11111111) begin
            $display("[ERRO] Falha no endereço 0x4. Obtido: 0x%08h", instr);
            errors = errors + 1;
        end else begin
            $display("[PASS] Leitura do endereço 0x4 (Palavra 1) OK.");
        end
        
        // 3. Lendo endereço 8 (Palavra 2)
        tests = tests + 1;
        addr = 32'd8;
        #5;
        if (instr !== 32'h22222222) begin
            $display("[ERRO] Falha no endereço 0x8. Obtido: 0x%08h", instr);
            errors = errors + 1;
        end else begin
            $display("[PASS] Leitura do endereço 0x8 (Palavra 2) OK.");
        end

        // 4. Lendo endereço 12 (Palavra 3)
        tests = tests + 1;
        addr = 32'd12;
        #5;
        if (instr !== 32'h33333333) begin
            $display("[ERRO] Falha no endereço 0xC. Obtido: 0x%08h", instr);
            errors = errors + 1;
        end else begin
            $display("[PASS] Leitura do endereço 0xC (Palavra 3) OK.");
        end

        // 5. Lendo endereço 16 (Palavra 4)
        tests = tests + 1;
        addr = 32'd16;
        #5;
        if (instr !== 32'hAAAABBBB) begin
            $display("[ERRO] Falha no endereço 0x10. Obtido: 0x%08h", instr);
            errors = errors + 1;
        end else begin
            $display("[PASS] Leitura do endereço 0x10 (Palavra 4) OK.");
        end
        
        $display("==========================================================");
        $display("Resumo: %0d testes executados, %0d erros encontrados.", tests, errors);
        $display("==========================================================");
        
        if (errors == 0) begin
            $display(">>> TESTE DA MEMÓRIA DE INSTRUÇÕES APROVADO! <<<");
            $finish;
        end else begin
            $display(">>> FALHA NO TESTE DA MEMÓRIA DE INSTRUÇÕES! <<<");
            $stop;
        end
    end

endmodule
