// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Instituto de Computacao - IComp
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// ----------------------------------------------------------------------------
// Modulo: alu (Unidade Logica e Aritmetica Parametrizada)
// Descricao: Executa operacoes logicas e aritmeticas (ADD, SUB, AND, OR, SLT, NOR)
//            entre os operandos src_a e src_b, controlada pelo codigo alu_ctrl.
//            Gera a saida zero (ativa em nivel alto quando alu_result == 0) para
//            decisao de desvios condicionais (beq).
// ============================================================================

`timescale 1ns / 1ps

module alu #(
    parameter DATA_WIDTH     = 32, // Largura dos operandos e do resultado (32 bits)
    parameter ALU_CTRL_WIDTH = 4   // Largura da palavra de controle da ALU (4 bits)
) (
    input  wire [DATA_WIDTH-1:0]     src_a,      // Primeiro operando
    input  wire [DATA_WIDTH-1:0]     src_b,      // Segundo operando
    input  wire [ALU_CTRL_WIDTH-1:0] alu_ctrl,   // Codigo de operacao da ALU
    output wire [DATA_WIDTH-1:0]     alu_result, // Resultado da operacao executada
    output wire                      zero        // Flag zero: ativa (1) se resultado igual a zero
);

    // TODO: Implementar as operacoes da ALU e a geracao da flag zero

endmodule
