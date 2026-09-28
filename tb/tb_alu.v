// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxilio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Modulo: tb_alu — Testbench Unitario da Unidade Logica e Aritmetica
// ============================================================================

`timescale 1ns / 1ps

module tb_alu;

    localparam DATA_WIDTH     = 32;
    localparam ALU_CTRL_WIDTH = 4;

    reg  [DATA_WIDTH-1:0]     src_a;
    reg  [DATA_WIDTH-1:0]     src_b;
    reg  [ALU_CTRL_WIDTH-1:0] alu_ctrl;
    wire [DATA_WIDTH-1:0]     alu_result;
    wire                      zero;

    integer errors = 0;
    integer tests  = 0;

    alu #(
        .DATA_WIDTH(DATA_WIDTH),
        .ALU_CTRL_WIDTH(ALU_CTRL_WIDTH)
    ) uut (
        .src_a(src_a),
        .src_b(src_b),
        .alu_ctrl(alu_ctrl),
        .alu_result(alu_result),
        .zero(zero)
    );

    task check_result;
        input [DATA_WIDTH-1:0] expected_result;
        input                  expected_zero;
        input [127:0]          test_name;
        begin
            tests = tests + 1;
            #1;
            if (alu_result !== expected_result || zero !== expected_zero) begin
                $display("[FALHA] %0s | Esperado: result = %08h, zero = %0b | Obtido: result = %08h, zero = %0b",
                         test_name, expected_result, expected_zero, alu_result, zero);
                errors = errors + 1;
            end else begin
                $display("[OK] %0s | result = %08h, zero = %0b", test_name, alu_result, zero);
            end
        end
    endtask

    initial begin
        $dumpfile("build/alu.vcd");
        $dumpvars(0, tb_alu);

        $display("\n==================================================");
        $display("   Iniciando Bateria de Testes Unitarios da ALU   ");
        $display("==================================================");

        src_a = 32'h00FF00FF;
        src_b = 32'h0F0F0F0F;
        alu_ctrl = 4'b0000;
        #10;
        check_result(32'h000F000F, 1'b0, "AND");

        src_a = 32'hF0000000;
        src_b = 32'h0000000F;
        alu_ctrl = 4'b0001;
        #10;
        check_result(32'hF000000F, 1'b0, "OR");

        src_a = 32'd25;
        src_b = 32'd17;
        alu_ctrl = 4'b0010;
        #10;
        check_result(32'd42, 1'b0, "ADD (25 + 17)");

        src_a = 32'd10;
        src_b = -32'd3;
        alu_ctrl = 4'b0010;
        #10;
        check_result(32'd7, 1'b0, "ADD com negativo (10 + -3)");

        src_a = 32'd50;
        src_b = 32'd20;
        alu_ctrl = 4'b0110;
        #10;
        check_result(32'd30, 1'b0, "SUB (50 - 20)");

        src_a = 32'd100;
        src_b = 32'd100;
        alu_ctrl = 4'b0110;
        #10;
        check_result(32'd0, 1'b1, "SUB com igualdade (Zero = 1)");

        src_a = 32'd5;
        src_b = 32'd9;
        alu_ctrl = 4'b0111;
        #10;
        check_result(32'd1, 1'b0, "SLT (5 < 9)");

        src_a = 32'd9;
        src_b = 32'd5;
        alu_ctrl = 4'b0111;
        #10;
        check_result(32'd0, 1'b1, "SLT (9 < 5)");

        src_a = -32'd10;
        src_b = 32'd2;
        alu_ctrl = 4'b0111;
        #10;
        check_result(32'd1, 1'b0, "SLT signed (-10 < 2)");

        src_a = 32'd2;
        src_b = -32'd10;
        alu_ctrl = 4'b0111;
        #10;
        check_result(32'd0, 1'b1, "SLT signed (2 < -10)");

        src_a = 32'h00000000;
        src_b = 32'h00000000;
        alu_ctrl = 4'b1100;
        #10;
        check_result(32'hFFFFFFFF, 1'b0, "NOR");

        $display("==================================================");
        if (errors == 0) begin
            $display("[SUCESSO TOTAL] Todos os %0d testes da ALU passaram!", tests);
            $display("==================================================\n");
            $finish;
        end else begin
            $display("[FALHA] Foram encontrados %0d erros em %0d testes!", errors, tests);
            $display("==================================================\n");
            $finish(1);
        end
    end

endmodule
