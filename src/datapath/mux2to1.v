// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// Desenvolvido com auxilio de: Gemini 3.8 Flash — High
// ----------------------------------------------------------------------------
// Modulo: mux2to1 — Multiplexador 2 para 1 Parametrizado
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

    // Logica combinacional de selecao 2 para 1
    assign y = sel ? d1 : d0;

endmodule
