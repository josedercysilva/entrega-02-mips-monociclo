// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratório
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxílio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Módulo: mux3to1 — Multiplexador 3 para 1 Parametrizado
// Descrição: Multiplexador de três entradas parametrizado. Utilizado nos sinais
//            RegDst e MemtoReg para suportar instruções do tipo JAL, como $ra e PC+4.
// ============================================================================

`timescale 1ns / 1ps

module mux3to1 #(
    parameter DATA_WIDTH = 32
) (
    input  wire [DATA_WIDTH-1:0] d0,
    input  wire [DATA_WIDTH-1:0] d1,
    input  wire [DATA_WIDTH-1:0] d2,

    input  wire [1:0]            sel,

    output wire [DATA_WIDTH-1:0] y
);

    assign y = (sel == 2'b00) ? d0 :
               (sel == 2'b01) ? d1 :
               (sel == 2'b10) ? d2 : {DATA_WIDTH{1'b0}};

endmodule
