// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// Desenvolvido com auxilio de: Gemini 3.8 Flash — High
// ----------------------------------------------------------------------------
// Modulo: datapath — Caminho de Dados Monociclo MIPS
// Descricao: Modulo integrador do caminho de dados que interconecta o PC, os
//            somadores — PC+4 e Branch —, o Banco de Registradores, a ALU, os
//            multiplexadores e o extensor de sinal.
//            Suporta instrucoes tipo-R, tipo-I e de salto — j, jal, jr.
// ============================================================================

`timescale 1ns / 1ps

module datapath #(
    parameter DATA_WIDTH = 32, // Largura do barramento de dados
    parameter ADDR_WIDTH = 32  // Largura do barramento de enderecos
) (
    input  wire                  clk,            // Sinal de clock
    input  wire                  reset,          // Sinal de reset

    // Sinais de controle vindos da Unidade de Controle
    input  wire [1:0]            reg_dst,        // Selecao do registrador destino de escrita
    input  wire                  jump,           // Sinal de salto incondicional — j ou jal
    input  wire                  jal,            // Sinal de salto e ligacao — jal
    input  wire                  branch,         // Sinal de desvio condicional — beq
    input  wire [1:0]            mem_to_reg,     // Selecao da origem de escrita no registrador
    input  wire [3:0]            alu_ctrl,       // Sinal de comando de operacao para a ALU
    input  wire                  alu_src,        // Selecao do segundo operando da ALU
    input  wire                  reg_write,      // Habilita escrita no banco de registradores
    input  wire                  jr,             // Sinal de salto por registrador — jr

    // Interface com a memoria de instrucoes
    input  wire [DATA_WIDTH-1:0] instr,          // Instrucao de 32 bits buscada da ROM
    output wire [ADDR_WIDTH-1:0] pc_out,         // Endereco atual do PC para busca da instrucao

    // Campos da instrucao expostos para a Unidade de Controle
    output wire [5:0]            opcode,         // Opcode bits 31 a 26
    output wire [5:0]            funct,          // Funct bits 5 a 0

    // Interface com a memoria de dados
    input  wire [DATA_WIDTH-1:0] mem_read_data,  // Dado lido da RAM
    output wire [ADDR_WIDTH-1:0] alu_result,     // Endereco ou resultado de operacao da ALU
    output wire [DATA_WIDTH-1:0] mem_write_data, // Dado a ser escrito na RAM

    // Sinais de status e monitoramento
    output wire                  zero            // Flag zero da ALU — para beq
);

    // TODO: Instanciar e interconectar os blocos do caminho de dados

endmodule
