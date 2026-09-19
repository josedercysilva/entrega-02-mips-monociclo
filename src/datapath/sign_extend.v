// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Instituto de Computacao - IComp
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// ----------------------------------------------------------------------------
// Modulo: sign_extend (Extensor de Sinal Parametrizado)
// Descricao: Converte um valor de campo imediato (padrao: 16 bits) para a
//            largura do barramento interno (padrao: 32 bits), preservando
//            o bit de sinal para operacoes com sinal (aritmetica, branches, lw/sw).
// ============================================================================

`timescale 1ns / 1ps

module sign_extend #(
    parameter IN_WIDTH  = 16, // Largura do imediato de entrada
    parameter OUT_WIDTH = 32  // Largura da palavra estendida de saida
) (
    input  wire [IN_WIDTH-1:0]  in,  // Valor imediato de entrada (ex: 16 bits)
    output wire [OUT_WIDTH-1:0] out  // Valor estendido com replicacao do bit de sinal
);

    // TODO: Implementar extensao de sinal com replicacao de in[IN_WIDTH-1]

endmodule
