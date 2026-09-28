// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxilio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Modulo: alu — Unidade Logica e Aritmetica Parametrizada
// Referencias:
// 1. D. M. Harris e S. L. Harris, "Digital Design and Computer Architecture",
//    2a ed., Morgan Kaufmann / Elsevier, 2012, Cap. 7 — Microarchitecture.
// 2. D. A. Patterson e J. L. Hennessy, "Computer Organization and Design —
//    The Hardware / Software Interface", 4a ed., Morgan Kaufmann, 2012, Cap. 4.
// ============================================================================

`timescale 1ns / 1ps

module alu #(
    parameter DATA_WIDTH     = 32,
    parameter ALU_CTRL_WIDTH = 4
) (
    input  wire [DATA_WIDTH-1:0]     src_a,
    input  wire [DATA_WIDTH-1:0]     src_b,
    input  wire [ALU_CTRL_WIDTH-1:0] alu_ctrl,
    output reg  [DATA_WIDTH-1:0]     alu_result,
    output wire                      zero
);

    wire sub_op = (alu_ctrl == 4'b0110) || (alu_ctrl == 4'b0111);
    wire [DATA_WIDTH-1:0] b_mux = sub_op ? ~src_b : src_b;
    wire [DATA_WIDTH-1:0] sum   = src_a + b_mux + sub_op;
    wire slt = ($signed(src_a) < $signed(src_b));

    assign zero = ~|alu_result;

    always @(*) begin
        case (alu_ctrl)
            4'b0000: alu_result = src_a & src_b;
            4'b0001: alu_result = src_a | src_b;
            4'b0010: alu_result = sum;
            4'b0110: alu_result = sum;
            4'b0111: alu_result = {{DATA_WIDTH-1{1'b0}}, slt};
            4'b1100: alu_result = ~(src_a | src_b);
            default: alu_result = {DATA_WIDTH{1'b0}};
        endcase
    end

endmodule
