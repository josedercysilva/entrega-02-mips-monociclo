// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Instituto de Computacao - IComp
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// ----------------------------------------------------------------------------
// Modulo: pc (Program Counter)
// Descricao: Registrador do Contador de Programa (PC) para o processador MIPS
//            Monociclo. Armazena o endereco da instrucao atual a ser executada.
// ============================================================================

`timescale 1ns / 1ps

module pc #(
    parameter DATA_WIDTH = 32 // Largura do barramento de enderecos/dados (padrao: 32 bits)
) (
    input  wire                  clk,    // Sinal de clock (borda de subida)
    input  wire                  reset,  // Reset sincrono/assincrono ativo em nivel alto
    input  wire [DATA_WIDTH-1:0] pc_in,  // Proximo endereco do PC
    output wire [DATA_WIDTH-1:0] pc_out  // Endereco atual fornecido a memoria de instrucoes
);

    // TODO: Implementar a logica sequencial do registrador PC

endmodule
