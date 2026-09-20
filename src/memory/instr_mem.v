// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// Desenvolvido com auxilio de: Gemini 3.8 Flash — High
// ----------------------------------------------------------------------------
// Modulo: instr_mem — Memoria de Instrucoes Parametrizada — ROM
// Descricao: Armazena o codigo de maquina do programa a ser executado pelo
//            MIPS. Opera em leitura assincrona, fornecendo a palavra de instrucao
//            correspondente ao endereco requisitado pelo Program Counter.
//            Suporta carregamento estatico de arquivos .hex via $readmemh.
// ============================================================================

`timescale 1ns / 1ps

module instr_mem #(
    parameter DATA_WIDTH = 32, // Largura da instrucao em bits — 32 bits
    parameter ADDR_WIDTH = 32, // Largura do barramento de endereco — 32 bits
    parameter MEM_DEPTH  = 256 // Quantidade de posicoes de instrucao na memoria
) (
    input  wire [ADDR_WIDTH-1:0] addr,  // Endereco da instrucao — alinhado a palavra
    output wire [DATA_WIDTH-1:0] instr  // Palavra de instrucao lida
);

    // TODO: Implementar a memoria de instrucoes e carga inicial via $readmemh

endmodule
