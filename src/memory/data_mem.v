// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Instituto de Computacao - IComp
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// ----------------------------------------------------------------------------
// Modulo: data_mem (Memoria de Dados Parametrizada - RAM)
// Descricao: Memoria de dados do processador MIPS para leitura (lw) e escrita (sw).
//            A gravacao ocorre de forma sincrona na borda de subida do clock
//            quando mem_write esta ativo. A leitura e ativada por mem_read.
// ============================================================================

`timescale 1ns / 1ps

module data_mem #(
    parameter DATA_WIDTH = 32, // Largura da palavra de dados (32 bits)
    parameter ADDR_WIDTH = 32, // Largura do endereco de memoria (32 bits)
    parameter MEM_DEPTH  = 256 // Quantidade de posicoes de palavra na memoria
) (
    input  wire                  clk,        // Sinal de clock do sistema
    input  wire                  mem_read,   // Habilita operacao de leitura de dado
    input  wire                  mem_write,  // Habilita operacao de escrita de dado
    input  wire [ADDR_WIDTH-1:0] addr,       // Endereco acessado (alinhado a palavra)
    input  wire [DATA_WIDTH-1:0] write_data, // Dado a ser armazenado na memoria
    output wire [DATA_WIDTH-1:0] read_data   // Dado lido da posicao especificada
);

    // TODO: Implementar a logica de leitura e escrita da memoria de dados RAM

endmodule
