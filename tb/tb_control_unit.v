// ============================================================================
// Modulo: tb_control_unit — Testbench Unitario da Unidade de Controle
// ============================================================================

`timescale 1ns / 1ps

module tb_control_unit;

    // Entradas (registros para injetar sinal)
    reg [5:0] opcode;
    reg [5:0] funct;

    // Saídas (fios para ler o resultado)
    wire [1:0] reg_dst;
    wire       jump;
    wire       jal;
    wire       branch;
    wire       branch_bne;
    wire       mem_read;
    wire [1:0] mem_to_reg;
    wire [3:0] alu_ctrl;
    wire       mem_write;
    wire       alu_src;
    wire       reg_write;
    wire       jr;

    // Variáveis de controle de teste
    integer errors = 0;
    integer tests  = 0;

    // Instanciação da Unidade de Controle
    control_unit uut (
        .opcode(opcode),
        .funct(funct),
        .reg_dst(reg_dst),
        .jump(jump),
        .jal(jal),
        .branch(branch),
        .branch_bne(branch_bne),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .alu_ctrl(alu_ctrl),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .jr(jr)
    );

    // Task para verificar e relatar automaticamente os sinais
    task check_signals;
        input [1:0] x_reg_dst;
        input       x_jump;
        input       x_jal;
        input       x_branch;
        input       x_branch_bne;
        input       x_mem_read;
        input [1:0] x_mem_to_reg;
        input [3:0] x_alu_ctrl;
        input       x_mem_write;
        input       x_alu_src;
        input       x_reg_write;
        input       x_jr;
        input [255:0] instr_name;
        begin
            tests = tests + 1;
            #1; // Espera 1ns para os sinais estabilizarem
            
            // Verifica se a saída gerada pela UUT (Unit Under Test) bate com o esperado (x_)
            if (reg_dst !== x_reg_dst || jump !== x_jump || jal !== x_jal || 
                branch !== x_branch || branch_bne !== x_branch_bne || 
                mem_read !== x_mem_read || mem_to_reg !== x_mem_to_reg || 
                alu_ctrl !== x_alu_ctrl || mem_write !== x_mem_write || 
                alu_src !== x_alu_src || reg_write !== x_reg_write || jr !== x_jr) begin
                
                $display("[FALHA] Instrucao: %0s", instr_name);
                $display("  -> Esperado: regDst=%b, j=%b, jal=%b, beq=%b, bne=%b, mRead=%b, mToReg=%b, aluOp=%b, mWrite=%b, aluSrc=%b, rWrite=%b, jr=%b", 
                         x_reg_dst, x_jump, x_jal, x_branch, x_branch_bne, x_mem_read, x_mem_to_reg, x_alu_ctrl, x_mem_write, x_alu_src, x_reg_write, x_jr);
                $display("  -> Obtido:   regDst=%b, j=%b, jal=%b, beq=%b, bne=%b, mRead=%b, mToReg=%b, aluOp=%b, mWrite=%b, aluSrc=%b, rWrite=%b, jr=%b\n", 
                         reg_dst, jump, jal, branch, branch_bne, mem_read, mem_to_reg, alu_ctrl, mem_write, alu_src, reg_write, jr);
                errors = errors + 1;
            end else begin
                $display("[OK] %0s validada com sucesso.", instr_name);
            end
        end
    endtask

    initial begin
        // Configuração para o GTKWave
        $dumpfile("build/control_unit.vcd");
        $dumpvars(0, tb_control_unit);

        $display("\n============================================================");
        $display("   Iniciando Bateria de Testes: UNIDADE DE CONTROLE         ");
        $display("============================================================");

        // ====================================================================
        // TESTES DE INSTRUÇÕES
        // ====================================================================
        
        // 1. ADD (Tipo-R) | opcode = 0, funct = 32 (0x20)
        opcode = 6'b000000; funct = 6'b100000;
        //            regDst   j      jal    beq    bne    mRd    mToReg  aluCt   mWr    aSrc   rWr    jr 
        check_signals(2'b01,   1'b0,  1'b0,  1'b0,  1'b0,  1'b0,  2'b00,  4'b0010, 1'b0,  1'b0,  1'b1,  1'b0, "ADD (Tipo-R)");

        // 2. SUB (Tipo-R) | opcode = 0, funct = 34 (0x22)
        opcode = 6'b000000; funct = 6'b100010;
        check_signals(2'b01,   1'b0,  1'b0,  1'b0,  1'b0,  1'b0,  2'b00,  4'b0110, 1'b0,  1'b0,  1'b1,  1'b0, "SUB (Tipo-R)");

        // 3. JR (Jump Register) | opcode = 0, funct = 8 (0x08)
        // Note: rWr = 0 (reg_write deve ser desligado) e jr = 1
        opcode = 6'b000000; funct = 6'b001000;
        check_signals(2'b01,   1'b0,  1'b0,  1'b0,  1'b0,  1'b0,  2'b00,  4'b0000, 1'b0,  1'b0,  1'b0,  1'b1, "JR (Jump Register)");

        // 4. LW (Load Word) | opcode = 35 (0x23)
        opcode = 6'b100011; funct = 6'b000000; // funct é ignorado
        check_signals(2'b00,   1'b0,  1'b0,  1'b0,  1'b0,  1'b1,  2'b01,  4'b0010, 1'b0,  1'b1,  1'b1,  1'b0, "LW (Load Word)");

        // 5. SW (Store Word) | opcode = 43 (0x2B)
        opcode = 6'b101011; funct = 6'b000000;
        check_signals(2'b00,   1'b0,  1'b0,  1'b0,  1'b0,  1'b0,  2'b00,  4'b0010, 1'b1,  1'b1,  1'b0,  1'b0, "SW (Store Word)");

        // 6. BEQ (Branch on Equal) | opcode = 4 (0x04)
        opcode = 6'b000100; funct = 6'b000000;
        check_signals(2'b00,   1'b0,  1'b0,  1'b1,  1'b0,  1'b0,  2'b00,  4'b0110, 1'b0,  1'b0,  1'b0,  1'b0, "BEQ (Branch Equal)");

        // 7. BNE (Branch Not Equal) | opcode = 5 (0x05)
        opcode = 6'b000101; funct = 6'b000000;
        check_signals(2'b00,   1'b0,  1'b0,  1'b0,  1'b1,  1'b0,  2'b00,  4'b0110, 1'b0,  1'b0,  1'b0,  1'b0, "BNE (Branch Not Equal)");

        // 8. JAL (Jump and Link) | opcode = 3 (0x03)
        // Note: rWr = 1, regDst = 2'b10 (escreve no $31), mToReg = 2'b10 (salva PC+4)
        opcode = 6'b000011; funct = 6'b000000;
        check_signals(2'b10,   1'b1,  1'b1,  1'b0,  1'b0,  1'b0,  2'b10,  4'b0010, 1'b0,  1'b0,  1'b1,  1'b0, "JAL (Jump and Link)");

        $display("============================================================");
        if (errors == 0) begin
            $display("[SUCESSO TOTAL] Unidade de Controle validada em %0d cenários!", tests);
            $display("============================================================\n");
            $finish;
        end else begin
            $display("[FALHA CRITICA] Foram encontrados %0d erros em %0d testes!", errors, tests);
            $display("============================================================\n");
            $finish(1);
        end
    end

endmodule