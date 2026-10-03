// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratório
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxílio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Módulo: mux4to1 — Multiplexador 4 para 1 Parametrizado
// Descrição: Multiplexador de quatro entradas parametrizado. Utilizado para
//            selecionar a fonte do próximo PC — PC+4, Branch, Jump ou JR.
// ============================================================================

`timescale 1ns / 1ps

module mux4to1 #(
    parameter DATA_WIDTH = 32
) (
    input  wire [DATA_WIDTH-1:0] d0,
    input  wire [DATA_WIDTH-1:0] d1,
    input  wire [DATA_WIDTH-1:0] d2,
    input  wire [DATA_WIDTH-1:0] d3,
    input  wire [1:0]            sel,
    output wire [DATA_WIDTH-1:0] y
);

    assign y = (sel == 2'b00) ? d0 :
               (sel == 2'b01) ? d1 :
               (sel == 2'b10) ? d2 : d3;

endmodule
