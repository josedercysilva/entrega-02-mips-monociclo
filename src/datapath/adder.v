// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxilio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Modulo: adder — Somador Aritmetico Parametrizado
// Descricao: Somador combinacional utilizado no caminho de dados para o calculo
//            do incremento de PC, PC + 4, e do endereco de desvio condicional
//            — Branch Target Address.
// ============================================================================

`timescale 1ns / 1ps

module adder #(
    parameter DATA_WIDTH = 32 // Largura dos operandos e do resultado
) (
    input  wire [DATA_WIDTH-1:0] a,      // Primeira parcela da soma
    input  wire [DATA_WIDTH-1:0] b,      // Segunda parcela da soma
    output wire [DATA_WIDTH-1:0] result  // Resultado da soma — a + b
);

    // Logica combinacional de soma parametrizada
    assign result = a + b;

endmodule
