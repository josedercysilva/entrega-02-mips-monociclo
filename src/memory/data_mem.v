// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratório
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxílio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Módulo: data_mem — Memória de Dados Parametrizada — RAM
// Descrição: Memória de dados do processador MIPS para leitura — lw — e escrita — sw.
//            A gravação ocorre de forma síncrona na borda de subida do clock
//            quando mem_write está ativo. A leitura é ativada por mem_read.
// ============================================================================

`timescale 1ns / 1ps

module data_mem #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32,
    parameter MEM_DEPTH  = 256
) (
    input  wire                  clk,
    input  wire                  mem_read,
    input  wire                  mem_write,
    input  wire [ADDR_WIDTH-1:0] addr,
    input  wire [DATA_WIDTH-1:0] write_data,
    output wire [DATA_WIDTH-1:0] read_data
);

    // Array de memória RAM
    reg [DATA_WIDTH-1:0] ram [0:MEM_DEPTH-1];

    // Leitura assíncrona combinacional
    // Opcionalmente protegida por mem_read para evitar leituras indevidas
    assign read_data = mem_read ? ram[addr[ADDR_WIDTH-1:2]] : {DATA_WIDTH{1'b0}};

    // Escrita síncrona
    always @(posedge clk) begin
        if (mem_write) begin
            ram[addr[ADDR_WIDTH-1:2]] <= write_data;
        end
    end

endmodule
