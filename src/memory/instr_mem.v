// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratório
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxílio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Módulo: instr_mem — Memória de Instruções Parametrizada — ROM
// Descrição: Armazena o código de máquina do programa a ser executado pelo
//            MIPS. Opera em leitura assíncrona, fornecendo a palavra de instrução
//            correspondente ao endereço requisitado pelo Program Counter.
//            Suporta carregamento estático de arquivos .hex via $readmemh.
// ============================================================================

`timescale 1ns / 1ps

module instr_mem #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32,
    parameter MEM_DEPTH  = 256,
    parameter INIT_FILE  = "tb/programa_teste.hex"
) (
    input  wire [ADDR_WIDTH-1:0] addr,
    output wire [DATA_WIDTH-1:0] instr
);

    // Array de memória ROM
    reg [DATA_WIDTH-1:0] rom [0:MEM_DEPTH-1];

    // Inicialização da ROM a partir de arquivo hexadecimal
    initial begin
        $readmemh(INIT_FILE, rom);
    end

    // Leitura combinacional (assíncrona) indexada por palavra
    // Como os endereços do MIPS avançam de 4 em 4 bytes (0, 4, 8...),
    // ignoramos os 2 bits menos significativos (addr[1:0]) para acessar
    // os índices da matriz (0, 1, 2...).
    assign instr = rom[addr[ADDR_WIDTH-1:2]];

endmodule
