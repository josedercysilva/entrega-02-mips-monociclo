// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// ----------------------------------------------------------------------------
// Testbench: tb_datapath_aux — Testes dos Modulos Auxiliares do Datapath
// Subprojeto: Validacao dos Modulos da Parte da Isabela Furtado (Datapath)
// Implementacao e Integracao: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxilio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ============================================================================

`timescale 1ns / 1ps

module tb_datapath_aux;

    localparam DATA_WIDTH = 32;

    // Sinais globais
    reg clk;
    reg reset;

    // Sinais PC
    reg  [DATA_WIDTH-1:0] pc_in;
    wire [DATA_WIDTH-1:0] pc_out;

    // Sinais Adder
    reg  [DATA_WIDTH-1:0] adder_a;
    reg  [DATA_WIDTH-1:0] adder_b;
    wire [DATA_WIDTH-1:0] adder_result;

    // Sinais Sign Extend
    reg  [15:0]           sign_ext_in;
    wire [DATA_WIDTH-1:0] sign_ext_out;

    // Sinais Mux 2:1
    reg  [DATA_WIDTH-1:0] m2_d0, m2_d1;
    reg                   m2_sel;
    wire [DATA_WIDTH-1:0] m2_y;

    // Sinais Mux 3:1
    reg  [DATA_WIDTH-1:0] m3_d0, m3_d1, m3_d2;
    reg  [1:0]            m3_sel;
    wire [DATA_WIDTH-1:0] m3_y;

    // Sinais Mux 4:1
    reg  [DATA_WIDTH-1:0] m4_d0, m4_d1, m4_d2, m4_d3;
    reg  [1:0]            m4_sel;
    wire [DATA_WIDTH-1:0] m4_y;

    integer errors = 0;
    integer tests = 0;

    // Instanciacoes
    pc #(.DATA_WIDTH(DATA_WIDTH)) uut_pc (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    adder #(.DATA_WIDTH(DATA_WIDTH)) uut_adder (
        .a(adder_a),
        .b(adder_b),
        .result(adder_result)
    );

    sign_extend #(.IN_WIDTH(16), .OUT_WIDTH(DATA_WIDTH)) uut_sign_ext (
        .in(sign_ext_in),
        .out(sign_ext_out)
    );

    mux2to1 #(.DATA_WIDTH(DATA_WIDTH)) uut_mux2 (
        .d0(m2_d0),
        .d1(m2_d1),
        .sel(m2_sel),
        .y(m2_y)
    );

    mux3to1 #(.DATA_WIDTH(DATA_WIDTH)) uut_mux3 (
        .d0(m3_d0),
        .d1(m3_d1),
        .d2(m3_d2),
        .sel(m3_sel),
        .y(m3_y)
    );

    mux4to1 #(.DATA_WIDTH(DATA_WIDTH)) uut_mux4 (
        .d0(m4_d0),
        .d1(m4_d1),
        .d2(m4_d2),
        .d3(m4_d3),
        .sel(m4_sel),
        .y(m4_y)
    );

    // Gerador de clock (periodo = 10ns)
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        pc_in = 32'h00000000;
        adder_a = 0; adder_b = 0;
        sign_ext_in = 0;
        m2_d0 = 32'hAAAA_AAAA; m2_d1 = 32'hBBBB_BBBB; m2_sel = 0;
        m3_d0 = 32'h1111_1111; m3_d1 = 32'h2222_2222; m3_d2 = 32'h3333_3333; m3_sel = 0;
        m4_d0 = 32'h1000_0000; m4_d1 = 32'h2000_0000; m4_d2 = 32'h3000_0000; m4_d3 = 32'h4000_0000; m4_sel = 0;

        $display("==========================================================");
        $display("   Iniciando Testbench dos Modulos Auxiliares (Fase 1)    ");
        $display("==========================================================");

        // --- 1. Teste do PC ---
        #12;
        tests = tests + 1;
        if (pc_out !== 32'h00000000) begin
            $display("[ERRO PC] Reset ativo nao zerou PC! Obtido: 0x%08h", pc_out);
            errors = errors + 1;
        end else begin
            $display("[PASS PC] Reset assincrono ativo zerou PC: 0x%08h", pc_out);
        end

        reset = 0;
        pc_in = 32'h00400004;
        #10;
        tests = tests + 1;
        if (pc_out !== 32'h00400004) begin
            $display("[ERRO PC] Atualizacao de PC falhou! Esperado: 0x00400004, Obtido: 0x%08h", pc_out);
            errors = errors + 1;
        end else begin
            $display("[PASS PC] Atualizacao no posedge clk com sucesso: 0x%08h", pc_out);
        end

        pc_in = 32'h00400008;
        #10;
        tests = tests + 1;
        if (pc_out !== 32'h00400008) begin
            $display("[ERRO PC] Atualizacao subsequente falhou! Obtido: 0x%08h", pc_out);
            errors = errors + 1;
        end else begin
            $display("[PASS PC] Segundo ciclo de clock validado: 0x%08h", pc_out);
        end

        // --- 2. Teste do Adder ---
        adder_a = 32'd100; adder_b = 32'd4; #2;
        tests = tests + 1;
        if (adder_result !== 32'd104) begin
            $display("[ERRO ADDER] 100 + 4 falhou! Obtido: %d", adder_result);
            errors = errors + 1;
        end else begin
            $display("[PASS ADDER] Soma 100 + 4 = 104 verificada.");
        end

        adder_a = 32'hFFFF_FFF0; adder_b = 32'd16; #2;
        tests = tests + 1;
        if (adder_result !== 32'd0) begin
            $display("[ERRO ADDER] Overflow/Complemento de 2 falhou! Obtido: %h", adder_result);
            errors = errors + 1;
        end else begin
            $display("[PASS ADDER] Soma com complemento de dois (0xFFFFFFF0 + 16 = 0) verificada.");
        end

        // --- 3. Teste do Sign Extend ---
        sign_ext_in = 16'h0007; #2;
        tests = tests + 1;
        if (sign_ext_out !== 32'h00000007) begin
            $display("[ERRO SIGN_EXT] Valor positivo falhou! Obtido: 0x%08h", sign_ext_out);
            errors = errors + 1;
        end else begin
            $display("[PASS SIGN_EXT] Extensao positiva 0x0007 -> 0x00000007 correta.");
        end

        sign_ext_in = 16'hFFFF; #2;
        tests = tests + 1;
        if (sign_ext_out !== 32'hFFFFFFFF) begin
            $display("[ERRO SIGN_EXT] Valor negativo -1 falhou! Obtido: 0x%08h", sign_ext_out);
            errors = errors + 1;
        end else begin
            $display("[PASS SIGN_EXT] Extensao negativa 0xFFFF -> 0xFFFFFFFF correta.");
        end

        sign_ext_in = 16'h8000; #2;
        tests = tests + 1;
        if (sign_ext_out !== 32'hFFFF8000) begin
            $display("[ERRO SIGN_EXT] Mais negativo falhou! Obtido: 0x%08h", sign_ext_out);
            errors = errors + 1;
        end else begin
            $display("[PASS SIGN_EXT] Extensao 0x8000 -> 0xFFFF8000 correta.");
        end

        // --- 4. Teste do Mux 2:1 ---
        m2_sel = 0; #2;
        tests = tests + 1;
        if (m2_y !== 32'hAAAA_AAAA) begin
            $display("[ERRO MUX2] sel=0 falhou! Obtido: 0x%08h", m2_y);
            errors = errors + 1;
        end else begin
            $display("[PASS MUX2] sel=0 seleciona d0 corretamente.");
        end

        m2_sel = 1; #2;
        tests = tests + 1;
        if (m2_y !== 32'hBBBB_BBBB) begin
            $display("[ERRO MUX2] sel=1 falhou! Obtido: 0x%08h", m2_y);
            errors = errors + 1;
        end else begin
            $display("[PASS MUX2] sel=1 seleciona d1 corretamente.");
        end

        // --- 5. Teste do Mux 3:1 ---
        m3_sel = 2'b00; #2;
        tests = tests + 1;
        if (m3_y !== 32'h1111_1111) begin
            $display("[ERRO MUX3] sel=00 falhou! Obtido: 0x%08h", m3_y);
            errors = errors + 1;
        end

        m3_sel = 2'b01; #2;
        tests = tests + 1;
        if (m3_y !== 32'h2222_2222) begin
            $display("[ERRO MUX3] sel=01 falhou! Obtido: 0x%08h", m3_y);
            errors = errors + 1;
        end

        m3_sel = 2'b10; #2;
        tests = tests + 1;
        if (m3_y !== 32'h3333_3333) begin
            $display("[ERRO MUX3] sel=10 falhou! Obtido: 0x%08h", m3_y);
            errors = errors + 1;
        end else begin
            $display("[PASS MUX3] Selecoes 2'b00, 2'b01 e 2'b10 validadas.");
        end

        // --- 6. Teste do Mux 4:1 ---
        m4_sel = 2'b00; #2; tests = tests + 1;
        if (m4_y !== 32'h1000_0000) errors = errors + 1;

        m4_sel = 2'b01; #2; tests = tests + 1;
        if (m4_y !== 32'h2000_0000) errors = errors + 1;

        m4_sel = 2'b10; #2; tests = tests + 1;
        if (m4_y !== 32'h3000_0000) errors = errors + 1;

        m4_sel = 2'b11; #2; tests = tests + 1;
        if (m4_y !== 32'h4000_0000) errors = errors + 1;
        else $display("[PASS MUX4] Todas as 4 entradas do mux4to1 validadas.");

        $display("==========================================================");
        $display("Resumo: %0d testes executados, %0d erros encontrados.", tests, errors);
        $display("==========================================================");

        if (errors == 0) begin
            $display(">>> TODOS OS MODULOS AUXILIARES FORAM APROVADOS! <<<");
            $finish;
        end else begin
            $display(">>> FALHA NOS TESTES AUXILIARES! <<<");
            $stop;
        end
    end

endmodule
