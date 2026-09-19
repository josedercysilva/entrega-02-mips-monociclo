// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Instituto de Computacao - IComp
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// ----------------------------------------------------------------------------
// Modulo: mux4to1 (Multiplexador 4 para 1 Parametrizado)
// Descricao: Multiplexador de quatro entradas parametrizado. Utilizado para
//            selecionar a fonte do proximo PC (PC+4, Branch, Jump ou JR).
// ============================================================================

`timescale 1ns / 1ps

module mux4to1 #(
    parameter DATA_WIDTH = 32 // Largura das palavras de dados
) (
    input  wire [DATA_WIDTH-1:0] d0,  // Entrada 0 (sel = 2'b00) - tipicamente PC+4
    input  wire [DATA_WIDTH-1:0] d1,  // Entrada 1 (sel = 2'b01) - tipicamente Branch Target
    input  wire [DATA_WIDTH-1:0] d2,  // Entrada 2 (sel = 2'b10) - tipicamente Jump Target
    input  wire [DATA_WIDTH-1:0] d3,  // Entrada 3 (sel = 2'b11) - tipicamente JR (ReadData1)
    input  wire [1:0]            sel, // Chave seletora de 2 bits
    output wire [DATA_WIDTH-1:0] y    // Saida multiplexada
);

    // TODO: Implementar a logica do multiplexador 4:1

endmodule
