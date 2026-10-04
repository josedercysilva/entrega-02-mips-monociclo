// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratório
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxílio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Testbench: tb_data_mem — Teste unitário da Memória de Dados (RAM)
// ============================================================================

`timescale 1ns / 1ps

module tb_data_mem;

    localparam DATA_WIDTH = 32;
    localparam ADDR_WIDTH = 32;
    
    reg clk;
    reg mem_read;
    reg mem_write;
    reg  [ADDR_WIDTH-1:0] addr;
    reg  [DATA_WIDTH-1:0] write_data;
    wire [DATA_WIDTH-1:0] read_data;
    
    integer tests  = 0;
    integer errors = 0;
    
    data_mem #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .MEM_DEPTH(256)
    ) uut (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data)
    );
    
    // Gerador de clock
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        mem_read = 0;
        mem_write = 0;
        addr = 0;
        write_data = 0;
        
        $display("==========================================================");
        $display("     Iniciando Testbench da Memória de Dados (Fase 3)     ");
        $display("==========================================================");
        
        #12;
        
        // 1. Escrita síncrona
        tests = tests + 1;
        addr = 32'd20; // Word 5
        write_data = 32'hFACEB00C;
        mem_write = 1;
        #10;
        mem_write = 0;
        
        // 2. Leitura assíncrona com mem_read = 1
        mem_read = 1;
        #2;
        if (read_data !== 32'hFACEB00C) begin
            $display("[ERRO] Falha na leitura do endereço 20. Obtido: 0x%08h", read_data);
            errors = errors + 1;
        end else begin
            $display("[PASS] Escrita síncrona e leitura em memória OK (Endereço 20).");
        end
        
        // 3. Isolamento do mem_read
        tests = tests + 1;
        mem_read = 0;
        #2;
        if (read_data !== 32'h00000000) begin
            $display("[ERRO] Dado sendo lido mesmo com mem_read=0. Obtido: 0x%08h", read_data);
            errors = errors + 1;
        end else begin
            $display("[PASS] Proteção do sinal mem_read=0 OK (zera saída).");
        end
        
        // 4. Isolamento do mem_write
        tests = tests + 1;
        addr = 32'd24; // Word 6
        write_data = 32'h12345678;
        mem_write = 0; // Desativado!
        #10;
        
        mem_read = 1;
        #2;
        if (read_data !== 32'bx && read_data !== 32'h00000000) begin
             // Assumimos que a memória não inicializada seja X ou 0.
             // O importante é que NÃO seja 12345678.
             if (read_data === 32'h12345678) begin
                 $display("[ERRO] Escrita ocorreu mesmo com mem_write=0!");
                 errors = errors + 1;
             end
        end else begin
            $display("[PASS] Proteção do sinal mem_write=0 OK (não gravou lixo).");
        end
        
        // 5. Teste de múltiplos endereços alinhados
        tests = tests + 1;
        addr = 32'd100;
        write_data = 32'hDEADBEEF;
        mem_write = 1;
        #10;
        mem_write = 0;
        
        addr = 32'd104;
        write_data = 32'hCAFEBA5E;
        mem_write = 1;
        #10;
        mem_write = 0;
        
        mem_read = 1;
        addr = 32'd100;
        #2;
        if (read_data !== 32'hDEADBEEF) errors = errors + 1;
        
        addr = 32'd104;
        #2;
        if (read_data !== 32'hCAFEBA5E) errors = errors + 1;
        
        if (errors == 0) $display("[PASS] Múltiplos endereços alinhados gravados e lidos com sucesso.");

        $display("==========================================================");
        $display("Resumo: %0d testes executados, %0d erros encontrados.", tests, errors);
        $display("==========================================================");
        
        if (errors == 0) begin
            $display(">>> TESTE DA MEMÓRIA DE DADOS APROVADO! <<<");
            $finish;
        end else begin
            $display(">>> FALHA NO TESTE DA MEMÓRIA DE DADOS! <<<");
            $stop;
        end
    end

endmodule
