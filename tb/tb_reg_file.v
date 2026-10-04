// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratório
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxílio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Testbench: tb_reg_file — Testes do Banco de Registradores
// ============================================================================

`timescale 1ns / 1ps

module tb_reg_file;

    localparam DATA_WIDTH = 32;
    localparam ADDR_WIDTH = 5;
    
    reg clk;
    reg reset;
    
    reg reg_write;
    
    reg [ADDR_WIDTH-1:0] read_reg1;
    reg [ADDR_WIDTH-1:0] read_reg2;
    wire [DATA_WIDTH-1:0] read_data1;
    wire [DATA_WIDTH-1:0] read_data2;
    
    reg [ADDR_WIDTH-1:0] write_reg;
    reg [DATA_WIDTH-1:0] write_data;
    
    integer tests  = 0;
    integer errors = 0;
    
    reg_file #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .clk(clk),
        .reset(reset),
        .reg_write(reg_write),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .write_reg(write_reg),
        .write_data(write_data)
    );
    
    // Gerador de Clock (T=10ns)
    always #5 clk = ~clk;
    
    initial begin
        // Inicialização
        clk = 0;
        reset = 1;
        reg_write = 0;
        read_reg1 = 0;
        read_reg2 = 0;
        write_reg = 0;
        write_data = 0;
        
        $display("==========================================================");
        $display("   Iniciando Testbench do Banco de Registradores (Fase 2) ");
        $display("==========================================================");
        
        #12; // Sai do reset (ativo alto)
        reset = 0;
        #8;
        
        // 1. Leitura inicial do $0 (deve ser 0)
        tests = tests + 1;
        read_reg1 = 5'd0;
        #2;
        if (read_data1 !== 32'd0) begin
            $display("[ERRO] Leitura do registrador $0 retornou 0x%08h, esperado 0x00000000.", read_data1);
            errors = errors + 1;
        end else begin
            $display("[PASS] Leitura inicial de $0 OK.");
        end
        
        // 2. Tentativa de escrita no $0 (deve ignorar)
        tests = tests + 1;
        write_reg = 5'd0;
        write_data = 32'hDEADBEEF;
        reg_write = 1;
        #10; // Aguarda 1 ciclo de clock
        reg_write = 0;
        read_reg1 = 5'd0;
        #2;
        if (read_data1 !== 32'd0) begin
            $display("[ERRO] Proteção de gravação no $0 falhou! 0x%08h gravado.", read_data1);
            errors = errors + 1;
        end else begin
            $display("[PASS] Proteção contra escrita em $0 OK.");
        end
        
        // 3. Escrita e leitura síncrona em $t0 (reg 8) e $t1 (reg 9)
        tests = tests + 2; // Testando dois registradores
        write_reg = 5'd8;
        write_data = 32'h12345678;
        reg_write = 1;
        #10;
        
        write_reg = 5'd9;
        write_data = 32'hAABBCCDD;
        reg_write = 1;
        #10;
        reg_write = 0;
        
        read_reg1 = 5'd8;
        read_reg2 = 5'd9;
        #2;
        if (read_data1 !== 32'h12345678) begin
            $display("[ERRO] Leitura de $t0 (8) incorreta! Obtido: 0x%08h", read_data1);
            errors = errors + 1;
        end else begin
            $display("[PASS] Escrita e leitura em $t0 (8) OK.");
        end
        
        if (read_data2 !== 32'hAABBCCDD) begin
            $display("[ERRO] Leitura de $t1 (9) incorreta! Obtido: 0x%08h", read_data2);
            errors = errors + 1;
        end else begin
            $display("[PASS] Escrita e leitura em $t1 (9) OK.");
        end
        
        // 4. Escrita com reg_write = 0 (não deve alterar dado)
        tests = tests + 1;
        write_reg = 5'd8;
        write_data = 32'hFFFFFFFF;
        reg_write = 0; // Desativado
        #10;
        read_reg1 = 5'd8;
        #2;
        if (read_data1 !== 32'h12345678) begin
            $display("[ERRO] Dado alterado mesmo com reg_write=0! Obtido: 0x%08h", read_data1);
            errors = errors + 1;
        end else begin
            $display("[PASS] Proteção de controle (reg_write=0) em $t0 (8) OK.");
        end
        
        // 5. Validação do registrador de retorno $ra (reg 31)
        tests = tests + 1;
        write_reg = 5'd31;
        write_data = 32'h00400024;
        reg_write = 1;
        #10;
        reg_write = 0;
        
        read_reg1 = 5'd31;
        #2;
        if (read_data1 !== 32'h00400024) begin
            $display("[ERRO] Leitura de $ra (31) incorreta! Obtido: 0x%08h", read_data1);
            errors = errors + 1;
        end else begin
            $display("[PASS] Escrita e leitura em $ra (31) OK.");
        end
        
        $display("==========================================================");
        $display("Resumo: %0d testes executados, %0d erros encontrados.", tests, errors);
        $display("==========================================================");
        
        if (errors == 0) begin
            $display(">>> TESTE DO BANCO DE REGISTRADORES APROVADO! <<<");
            $finish;
        end else begin
            $display(">>> FALHA NO TESTE DO BANCO DE REGISTRADORES! <<<");
            $stop;
        end
    end

endmodule
