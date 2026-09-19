// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Instituto de Computacao - IComp
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// ----------------------------------------------------------------------------
// Modulo: mips_monociclo_top (Modulo Raiz - Processador MIPS Monociclo)
// Descricao: Modulo Top-Level do processador MIPS Monociclo com suporte a saltos
//            (j, jal, jr). Realiza a integracao de todos os blocos:
//            - Caminho de Dados (datapath)
//            - Unidade de Controle (control_unit)
//            - Memoria de Instrucoes (instr_mem)
//            - Memoria de Dados (data_mem)
// ============================================================================

`timescale 1ns / 1ps

module mips_monociclo_top #(
    parameter DATA_WIDTH = 32, // Largura das palavras de dados (32 bits)
    parameter ADDR_WIDTH = 32, // Largura do enderecamento (32 bits)
    parameter MEM_DEPTH  = 256 // Capacidade das memorias em palavras
) (
    input  wire                  clk,                // Clock global do sistema
    input  wire                  reset,              // Reset global do sistema

    // Sinais para observacao, depuracao e integracao em testbench / FPGA
    output wire [ADDR_WIDTH-1:0] pc,                 // Endereco atual do PC
    output wire [DATA_WIDTH-1:0] instr,              // Instrucao atual em execucao
    output wire [DATA_WIDTH-1:0] alu_result,         // Saida da ALU
    output wire [DATA_WIDTH-1:0] dmem_data,          // Dado gravado na memoria de dados
    output wire                  dmem_write_enable   // Pulso de escrita na memoria de dados
);

    // TODO: Instanciar e conectar control_unit, datapath, instr_mem e data_mem

endmodule
