// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// Desenvolvido com auxilio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Modulo: sign_extend — Extensor de Sinal Parametrizado
// Atribuicao Original do Projeto: Isabela Furtado (Datapath)
// Implementacao e Integracao: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Descricao: Converte um valor de campo imediato — padrao: 16 bits — para a
//            largura do barramento interno — padrao: 32 bits —, preservando
//            o bit de sinal para operacoes com sinal, como aritmetica, branches, lw e sw.
// ============================================================================

`timescale 1ns / 1ps

module sign_extend #(
    parameter IN_WIDTH  = 16, // Largura do imediato de entrada
    parameter OUT_WIDTH = 32  // Largura da palavra estendida de saida
) (
    input  wire [IN_WIDTH-1:0]  in,  // Valor imediato de entrada — ex: 16 bits
    output wire [OUT_WIDTH-1:0] out  // Valor estendido com replicacao do bit de sinal
);

    // Logica combinacional de extensao de sinal com replicacao do MSB
    assign out = {{(OUT_WIDTH-IN_WIDTH){in[IN_WIDTH-1]}}, in};

endmodule
