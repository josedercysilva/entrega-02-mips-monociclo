// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratório
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxílio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Módulo: reg_file — Banco de Registradores
// Descrição: Array de 32 registradores de 32 bits. Leitura assíncrona dupla
//            e escrita síncrona simples. Registrador $0 é constante (zero).
// ============================================================================

`timescale 1ns / 1ps

module reg_file #(
    parameter DATA_WIDTH = 32,
    parameter NUM_REGS   = 32,
    parameter ADDR_WIDTH = 5 // log2(32)
) (
    input  wire                  clk,
    input  wire                  reset,
    
    // Controle
    input  wire                  reg_write,
    
    // Leitura
    input  wire [ADDR_WIDTH-1:0] read_reg1,
    input  wire [ADDR_WIDTH-1:0] read_reg2,
    output wire [DATA_WIDTH-1:0] read_data1,
    output wire [DATA_WIDTH-1:0] read_data2,
    
    // Escrita
    input  wire [ADDR_WIDTH-1:0] write_reg,
    input  wire [DATA_WIDTH-1:0] write_data
);

    // Array de registradores
    reg [DATA_WIDTH-1:0] registers [0:NUM_REGS-1];
    
    integer i;
    
    // Escrita síncrona
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < NUM_REGS; i = i + 1) begin
                registers[i] <= {DATA_WIDTH{1'b0}};
            end
        end else if (reg_write && write_reg != {ADDR_WIDTH{1'b0}}) begin
            registers[write_reg] <= write_data;
        end
    end
    
    // Leitura combinacional (assíncrona)
    assign read_data1 = (read_reg1 == {ADDR_WIDTH{1'b0}}) ? {DATA_WIDTH{1'b0}} : registers[read_reg1];
    assign read_data2 = (read_reg2 == {ADDR_WIDTH{1'b0}}) ? {DATA_WIDTH{1'b0}} : registers[read_reg2];

endmodule
