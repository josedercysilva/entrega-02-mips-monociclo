// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Instituto de Computacao - IComp
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// ----------------------------------------------------------------------------
// Modulo: main_control (Unidade de Controle Principal)
// Descricao: Decodifica o campo opcode da instrucao (bits [31:26]) e gera
//            os sinais de controle para o caminho de dados e memoria.
//            Suporta instrucoes tipo-R, lw, sw, beq, addi, j e jal.
// ============================================================================

`timescale 1ns / 1ps

module main_control (
    input  wire [5:0] opcode,      // Codigo de operacao (bits [31:26] da instrucao)
    output wire [1:0] reg_dst,     // 2'b00: rt, 2'b01: rd, 2'b10: $31 ($ra para jal)
    output wire       jump,        // 1: desvio incondicional (j ou jal)
    output wire       jal,         // 1: desvio com link (salva PC+4 em $31)
    output wire       branch,      // 1: desvio condicional por igualdade (beq)
    output wire       mem_read,    // 1: habilita leitura da memoria de dados (lw)
    output wire [1:0] mem_to_reg,  // 2'b00: ALU, 2'b01: Memoria de Dados, 2'b10: PC+4 (jal)
    output wire [1:0] alu_op,      // 2'b00: soma (lw/sw/addi), 2'b01: subtracao (beq), 2'b10: tipo-R
    output wire       mem_write,   // 1: habilita escrita na memoria de dados (sw)
    output wire       alu_src,     // 0: segundo operando e registrador rt, 1: imediato estendido
    output wire       reg_write    // 1: habilita escrita no banco de registradores
);

    // TODO: Implementar a decodificacao combinacional do opcode

endmodule
