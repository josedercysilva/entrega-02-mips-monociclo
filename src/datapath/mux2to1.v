// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratório
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxílio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Módulo: mux2to1 — Multiplexador 2 para 1 Parametrizado
// Descrição: Multiplexador de duas entradas parametrizado na largura dos dados.
//            Utilizado para selecionar caminhos alternativos de dados.
// ============================================================================

`timescale 1ns / 1ps

module mux2to1 #(
    parameter DATA_WIDTH = 32
) (
    input  wire [DATA_WIDTH-1:0] d0,  
    input  wire [DATA_WIDTH-1:0] d1,  

    input  wire                  sel, 
    
    output wire [DATA_WIDTH-1:0] y   
);


    assign y = sel ? d1 : d0;

endmodule
