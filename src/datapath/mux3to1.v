// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// Desenvolvido com auxilio de: Gemini 3.8 Flash — High
// ----------------------------------------------------------------------------
// Modulo: mux3to1 — Multiplexador 3 para 1 Parametrizado
// Descricao: Multiplexador de tres entradas parametrizado. Utilizado nos sinais
//            RegDst e MemtoReg para suportar instrucoes do tipo JAL, como $ra e PC+4.
// ============================================================================

`timescale 1ns / 1ps

module mux3to1 #(
    parameter DATA_WIDTH = 32 // Largura das palavras de entrada e saida
) (
    input  wire [DATA_WIDTH-1:0] d0,  // Entrada 0 — sel = 2'b00
    input  wire [DATA_WIDTH-1:0] d1,  // Entrada 1 — sel = 2'b01
    input  wire [DATA_WIDTH-1:0] d2,  // Entrada 2 — sel = 2'b10
    input  wire [1:0]            sel, // Chave seletora de 2 bits
    output wire [DATA_WIDTH-1:0] y    // Saida multiplexada
);

    // Logica combinacional de selecao 3 para 1 (RegDst e MemtoReg com suporte a JAL)
    assign y = (sel == 2'b00) ? d0 :
               (sel == 2'b01) ? d1 :
               (sel == 2'b10) ? d2 : {DATA_WIDTH{1'b0}};

endmodule
