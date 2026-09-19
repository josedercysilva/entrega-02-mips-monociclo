// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Instituto de Computacao - IComp
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// ----------------------------------------------------------------------------
// Modulo: control_unit (Unidade de Controle Integrada)
// Descricao: Integra o modulo main_control e o modulo alu_control, decodificando
//            tanto o opcode quanto o funct para orquestrar todos os sinais
//            de controle do processador MIPS Monociclo.
// ============================================================================

`timescale 1ns / 1ps

module control_unit (
    input  wire [5:0] opcode,     // Campo opcode da instrucao
    input  wire [5:0] funct,      // Campo de funcao tipo-R
    output wire [1:0] reg_dst,    // Seleciona registrador destino (rt, rd ou $31)
    output wire       jump,       // Sinal de desvio incondicional
    output wire       jal,        // Sinal de desvio com link
    output wire       branch,     // Sinal de desvio condicional beq
    output wire       mem_read,   // Leitura da memoria de dados
    output wire [1:0] mem_to_reg, // Seleciona origem do dado para escrita no registrador
    output wire [3:0] alu_ctrl,   // Controle de 4 bits para a ALU
    output wire       mem_write,  // Escrita na memoria de dados
    output wire       alu_src,    // Seleciona segundo operando da ALU
    output wire       reg_write,  // Habilita gravacao no banco de registradores
    output wire       jr          // Deteccao de desvio por registrador jr
);

    // TODO: Instanciar e interconectar main_control e alu_control

endmodule
