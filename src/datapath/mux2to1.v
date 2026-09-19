// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Instituto de Computacao - IComp
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// ----------------------------------------------------------------------------
// Modulo: mux2to1 (Multiplexador 2 para 1 Parametrizado)
// Descricao: Multiplexador de duas entradas parametrizado na largura dos dados.
//            Utilizado para selecionar caminhos alternativos de dados.
// ============================================================================

`timescale 1ns / 1ps

module mux2to1 #(
    parameter DATA_WIDTH = 32 // Largura das palavras de entrada e saida
) (
    input  wire [DATA_WIDTH-1:0] d0,  // Entrada selecionada quando sel = 0
    input  wire [DATA_WIDTH-1:0] d1,  // Entrada selecionada quando sel = 1
    input  wire                  sel, // Chave seletora de 1 bit
    output wire [DATA_WIDTH-1:0] y    // Saida multiplexada
);

    // TODO: Implementar a logica do multiplexador 2:1

endmodule
