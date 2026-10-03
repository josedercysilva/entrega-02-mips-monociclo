// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratório
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxílio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Módulo: pc — Program Counter
// Descrição: Registrador do Contador de Programa — PC — para o processador MIPS
//            Monociclo. Armazena o endereço da instrução atual a ser executada.
// ============================================================================

`timescale 1ns / 1ps

module pc #(
    parameter DATA_WIDTH = 32
) (
    input  wire                  clk,    
    input  wire                  reset,  
    input  wire [DATA_WIDTH-1:0] pc_in,  
    output reg  [DATA_WIDTH-1:0] pc_out  
);

    // Reset assíncrono ativo em nível alto
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_out <= {DATA_WIDTH{1'b0}};
        end else begin
            pc_out <= pc_in;
        end
    end

endmodule
