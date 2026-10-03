// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratório
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxílio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Módulo: sign_extend — Extensor de Sinal Parametrizado
// Descrição: Converte um valor de campo imediato — padrão: 16 bits — para a
//            largura do barramento interno — padrão: 32 bits —, preservando
//            o bit de sinal para operações com sinal, como aritmética, branches, lw e sw.
// ============================================================================

`timescale 1ns / 1ps

module sign_extend #(
    parameter IN_WIDTH  = 16, 
    parameter OUT_WIDTH = 32
) (
    input  wire [IN_WIDTH-1:0]  in,
    output wire [OUT_WIDTH-1:0] out
);

    assign out = {{(OUT_WIDTH-IN_WIDTH){in[IN_WIDTH-1]}}, in};

endmodule
