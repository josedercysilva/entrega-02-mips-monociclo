// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxilio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Modulo: pc — Program Counter
// Descricao: Registrador do Contador de Programa — PC — para o processador MIPS
//            Monociclo. Armazena o endereco da instrucao atual a ser executada.
// ============================================================================

`timescale 1ns / 1ps

module pc #(
    parameter DATA_WIDTH = 32 // Largura do barramento de enderecos e dados — padrao: 32 bits
) (
    input  wire                  clk,    // Sinal de clock — borda de subida
    input  wire                  reset,  // Reset sincrono ou assincrono ativo em nivel alto
    input  wire [DATA_WIDTH-1:0] pc_in,  // Proximo endereco do PC
    output reg  [DATA_WIDTH-1:0] pc_out  // Endereco atual fornecido a memoria de instrucoes
);

    // Logica sequencial do registrador PC com reset assincrono ativo em nivel alto
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_out <= {DATA_WIDTH{1'b0}};
        end else begin
            pc_out <= pc_in;
        end
    end

endmodule
