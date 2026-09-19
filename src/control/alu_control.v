// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Instituto de Computacao - IComp
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// ----------------------------------------------------------------------------
// Modulo: alu_control (Controle da ALU)
// Descricao: Decodifica o sinal alu_op vindo do controle principal e o campo
//            funct da instrucao (bits [5:0]) para instrucoes tipo-R.
//            Gera o codigo de controle da ALU (alu_ctrl de 4 bits) e o sinal
//            de deteccao de desvio por registrador (jr).
// ============================================================================

`timescale 1ns / 1ps

module alu_control (
    input  wire [1:0] alu_op,   // Codigo de operacao base do controle principal
    input  wire [5:0] funct,    // Campo de funcao da instrucao tipo-R (bits [5:0])
    output wire [3:0] alu_ctrl, // Codigo de operacao de 4 bits para a ALU
    output wire       jr        // 1: Instrucao JR detectada (funct = 6'b001000)
);

    // TODO: Implementar a tabela de verdade combinacional do controle da ALU

endmodule
