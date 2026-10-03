// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratório
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxílio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Módulo: adder — Somador Aritmético Parametrizado
// Descrição: Somador combinacional utilizado no caminho de dados para o cálculo
//            do incremento de PC, PC + 4, e do endereço de desvio condicional
//            — Branch Target Address.
// ============================================================================

`timescale 1ns / 1ps

module adder #(
    parameter DATA_WIDTH = 32 
) (
    input  wire [DATA_WIDTH-1:0] a, 
    input  wire [DATA_WIDTH-1:0] b,
    output wire [DATA_WIDTH-1:0] result 
);

    assign result = a + b;

endmodule
