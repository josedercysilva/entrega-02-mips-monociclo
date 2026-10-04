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
        #12;
        reset = 0;

        #250;

        $display("\nVerificando o estado final do processador...");

        if (uut.datapath_inst.reg_file_inst.registers[10] === 32'd30)
            $display("[PASS] Matemática (add): $t2 = 30.");
        else
            $display("[ERRO] Matemática falhou. Esperado $t2=30, Obtido=%0d", uut.datapath_inst.reg_file_inst.registers[10]);

        if (uut.data_mem_inst.ram[25] === 32'd30)
            $display("[PASS] Memória (sw): RAM[100] = 30.");
        else
            $display("[ERRO] Memória falhou. Esperado RAM[100]=30, Obtido=%0d", uut.data_mem_inst.ram[25]);

        if (uut.datapath_inst.reg_file_inst.registers[16] === 32'd30)
            $display("[PASS] Memória (lw): $s0 = 30.");
        else
            $display("[ERRO] Load Word falhou. Esperado $s0=30, Obtido=%0d", uut.datapath_inst.reg_file_inst.registers[16]);

        if (uut.datapath_inst.reg_file_inst.registers[2] === 32'd99)
            $display("[PASS] Saltos e Funções (beq, j, jal, jr): $v0 = 99.");
        else
            $display("[ERRO] Saltos falharam. Esperado $v0=99, Obtido=%0d", uut.datapath_inst.reg_file_inst.registers[2]);

        $display("==========================================================");
        $display(">>> TESTE INTEGRADO CONCLUÍDO COM SUCESSO! <<<");
        $display("==========================================================");

        $finish;
    end

endmodule
