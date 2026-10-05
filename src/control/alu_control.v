// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// Desenvolvido com auxilio de: Gemini 3.8 Flash — High
// ----------------------------------------------------------------------------
// Modulo: alu_control — Controle da ALU
// Descricao: Decodifica o sinal alu_op vindo do controle principal e o campo
//            funct da instrucao — bits [5:0] — para instrucoes tipo-R.
//            Gera o codigo de controle da ALU, alu_ctrl de 4 bits, e o sinal
//            de deteccao de desvio por registrador — jr.
// ============================================================================

`timescale 1ns / 1ps

module alu_control #(
    parameter ALU_OP_WIDTH   = 2, // Largura do codigo alu_op
    parameter FUNCT_WIDTH    = 6, // Largura do campo funct
    parameter ALU_CTRL_WIDTH = 4  // Largura do sinal de controle da ALU
) (
    input  wire [ALU_OP_WIDTH-1:0]   alu_op,   // Codigo de operacao base do controle principal
    input  wire [FUNCT_WIDTH-1:0]    funct,    // Campo de funcao da instrucao tipo-R — bits 5 a 0
    output reg  [ALU_CTRL_WIDTH-1:0] alu_ctrl, // Codigo de operacao de 4 bits para a ALU
    output reg                       jr        // 1: Instrucao JR detectada — funct = 6'b001000
);

    // Codigos do campo funct (Tipo-R)
    localparam [FUNCT_WIDTH-1:0] FUNCT_SLL = 6'b000000,
                                 FUNCT_JR  = 6'b001000,
                                 FUNCT_ADD = 6'b100000,
                                 FUNCT_SUB = 6'b100010,
                                 FUNCT_AND = 6'b100100,
                                 FUNCT_OR  = 6'b100101,
                                 FUNCT_NOR = 6'b100111,
                                 FUNCT_SLT = 6'b101010;

    // Codigos de operacao para a ALU
    localparam [ALU_CTRL_WIDTH-1:0] ALU_AND = 4'b0000,
                                    ALU_OR  = 4'b0001,
                                    ALU_ADD = 4'b0010,
                                    ALU_SLL = 4'b0011,
                                    ALU_SUB = 4'b0110,
                                    ALU_SLT = 4'b0111,
                                    ALU_NOR = 4'b1100;

    always @(alu_op or funct) begin
        alu_ctrl = ALU_AND;
        jr       = 1'b0;

        case (alu_op)
            2'b00: alu_ctrl = ALU_ADD; // lw, sw, addi
            2'b01: alu_ctrl = ALU_SUB; // beq
            2'b10: begin               // Tipo-R
                case (funct)
                    FUNCT_SLL: alu_ctrl = ALU_SLL;
                    FUNCT_ADD: alu_ctrl = ALU_ADD;
                    FUNCT_SUB: alu_ctrl = ALU_SUB;
                    FUNCT_AND: alu_ctrl = ALU_AND;
                    FUNCT_OR:  alu_ctrl = ALU_OR;
                    FUNCT_SLT: alu_ctrl = ALU_SLT;
                    FUNCT_NOR: alu_ctrl = ALU_NOR;
                    FUNCT_JR: begin
                        alu_ctrl = ALU_AND;
                        jr       = 1'b1;
                    end
                    default: alu_ctrl = ALU_AND;
                endcase
            end
            2'b11: alu_ctrl = ALU_SLT; // slti
            default: alu_ctrl = ALU_AND;
        endcase
    end

endmodule