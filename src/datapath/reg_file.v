// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// Desenvolvido com auxilio de: Gemini 3.8 Flash — High
// ----------------------------------------------------------------------------
// Modulo: reg_file — Banco de Registradores Parametrizado
// Descricao: Banco com 32 registradores de 32 bits conforme a arquitetura MIPS.
//            Possui duas portas de leitura assincronas, read_data1 e read_data2,
//            e uma porta de escrita sincrona na borda de subida do clock.
//            O registrador $0 — $zero — e fixo em zero, cuja leitura sempre retorna 0.
// ============================================================================

`timescale 1ns / 1ps

module reg_file #(
    parameter DATA_WIDTH = 32, // Largura dos dados em bits — 32 bits
    parameter ADDR_WIDTH = 5,  // Largura de enderecamento de registradores — 5 bits para 32 regs
    parameter NUM_REGS   = 32  // Quantidade total de registradores
) (
    input  wire                  clk,        // Sinal de clock do sistema
    input  wire                  reset,      // Sinal de reinicializacao
    input  wire                  reg_write,  // Habilita escrita no registrador
    input  wire [ADDR_WIDTH-1:0] read_reg1,  // Endereco do registrador fonte 1 — rs
    input  wire [ADDR_WIDTH-1:0] read_reg2,  // Endereco do registrador fonte 2 — rt
    input  wire [ADDR_WIDTH-1:0] write_reg,  // Endereco do registrador destino de escrita
    input  wire [DATA_WIDTH-1:0] write_data, // Dado a ser gravado no registrador destino
    output wire [DATA_WIDTH-1:0] read_data1, // Conteudo lido da porta 1
    output wire [DATA_WIDTH-1:0] read_data2  // Conteudo lido da porta 2
);

    // TODO: Implementar a logica do banco de registradores

endmodule
