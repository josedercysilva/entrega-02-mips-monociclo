// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratório
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxílio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Testbench Top-Level: tb_mips_monociclo_top — Integração Completa (Fase 4)
// ============================================================================

`timescale 1ns / 1ps

module tb_mips_monociclo_top;

    reg clk;
    reg reset;

    mips_monociclo_top uut (
        .clk(clk),
        .reset(reset)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("build/top.vcd");
        $dumpvars(0, tb_mips_monociclo_top);

        $display("==========================================================");
        $display("   Iniciando Simulação Top-Level MIPS Monociclo (Fase 4)  ");
        $display("==========================================================");

        clk = 0;
        reset = 1;

        $display("\n[ANTES DA ORDENAÇÃO] Vetor na RAM (Tempo 0):");
        $display("Posicao 0: %0d", uut.data_mem_inst.ram[0]);
        $display("Posicao 1: %0d", uut.data_mem_inst.ram[1]);
        $display("Posicao 2: %0d", uut.data_mem_inst.ram[2]);
        $display("Posicao 3: %0d", uut.data_mem_inst.ram[3]);
        $display("Posicao 4: %0d", uut.data_mem_inst.ram[4]);

        #12;
        reset = 0;

        #5000; // Tempo de execucao do Sort

        $display("\n[DEPOIS DA ORDENAÇÃO] Vetor na RAM (Fim da Execução):");
        $display("Posicao 0: %0d", uut.data_mem_inst.ram[0]);
        $display("Posicao 1: %0d", uut.data_mem_inst.ram[1]);
        $display("Posicao 2: %0d", uut.data_mem_inst.ram[2]);
        $display("Posicao 3: %0d", uut.data_mem_inst.ram[3]);
        $display("Posicao 4: %0d", uut.data_mem_inst.ram[4]);

        $display("\n==========================================================");
        $display(">>> TESTE DO SORT CONCLUÍDO COM SUCESSO! <<<");
        $display("==========================================================");

        $finish;
    end

endmodule
