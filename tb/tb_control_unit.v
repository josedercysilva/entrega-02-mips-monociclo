// ============================================================================
// Modulo: tb_control_unit — Testbench Unitario da Unidade de Controle
// ============================================================================

`timescale 1ns / 1ps

module tb_control_unit;

    localparam OPCODE_WIDTH   = 6;
    localparam FUNCT_WIDTH    = 6;
    localparam ALU_CTRL_WIDTH = 4;

    reg  [OPCODE_WIDTH-1:0]   opcode;
    reg  [FUNCT_WIDTH-1:0]    funct;

    wire [1:0]                reg_dst;
    wire                      jump;
    wire                      jal;
    wire                      branch;
    wire                      mem_read;
    wire [1:0]                mem_to_reg;
    wire [ALU_CTRL_WIDTH-1:0] alu_ctrl;
    wire                      mem_write;
    wire                      alu_src;
    wire                      reg_write;
    wire                      jr;

    integer errors = 0;
    integer tests  = 0;

    control_unit #(
        .OPCODE_WIDTH(OPCODE_WIDTH),
        .FUNCT_WIDTH(FUNCT_WIDTH),
        .ALU_CTRL_WIDTH(ALU_CTRL_WIDTH)
    ) uut (
        .opcode(opcode),
        .funct(funct),
        .reg_dst(reg_dst),
        .jump(jump),
        .jal(jal),
        .branch(branch),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .alu_ctrl(alu_ctrl),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .jr(jr)
    );

    task check_signals;
        input [1:0]   x_reg_dst;
        input         x_jump;
        input         x_jal;
        input         x_branch;
        input         x_mem_read;
        input [1:0]   x_mem_to_reg;
        input [3:0]   x_alu_ctrl;
        input         x_mem_write;
        input         x_alu_src;
        input         x_reg_write;
        input         x_jr;
        input [255:0] instr_name;
        begin
            tests = tests + 1;
            #1;
            if (reg_dst !== x_reg_dst || jump !== x_jump || jal !== x_jal ||
                branch !== x_branch || mem_read !== x_mem_read ||
                mem_to_reg !== x_mem_to_reg || alu_ctrl !== x_alu_ctrl ||
                mem_write !== x_mem_write || alu_src !== x_alu_src ||
                reg_write !== x_reg_write || jr !== x_jr) begin

                $display("[FALHA] %0s", instr_name);
                $display("  Esperado: regDst=%b j=%b jal=%b br=%b mRd=%b m2Reg=%b aluC=%b mWr=%b aSrc=%b rWr=%b jr=%b",
                         x_reg_dst, x_jump, x_jal, x_branch, x_mem_read, x_mem_to_reg, x_alu_ctrl, x_mem_write, x_alu_src, x_reg_write, x_jr);
                $display("  Obtido:   regDst=%b j=%b jal=%b br=%b mRd=%b m2Reg=%b aluC=%b mWr=%b aSrc=%b rWr=%b jr=%b",
                         reg_dst, jump, jal, branch, mem_read, mem_to_reg, alu_ctrl, mem_write, alu_src, reg_write, jr);
                errors = errors + 1;
            end else begin
                $display("[OK] %0s", instr_name);
            end
        end
    endtask

    initial begin
        $dumpfile("build/control_unit.vcd");
        $dumpvars(0, tb_control_unit);

        $display("\n==================================================");
        $display("   Iniciando Bateria de Testes: CONTROL UNIT      ");
        $display("==================================================");

        //             regDst j     jal   br    mRd   m2Reg aluCtrl  mWr   aSrc  rWr   jr
        opcode = 6'b000000; funct = 6'b100000; #9;
        check_signals(2'b01, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 4'b0010, 1'b0, 1'b0, 1'b1, 1'b0, "ADD (Tipo-R)");

        opcode = 6'b000000; funct = 6'b100010; #9;
        check_signals(2'b01, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 4'b0110, 1'b0, 1'b0, 1'b1, 1'b0, "SUB (Tipo-R)");

        opcode = 6'b000000; funct = 6'b100100; #9;
        check_signals(2'b01, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 4'b0000, 1'b0, 1'b0, 1'b1, 1'b0, "AND (Tipo-R)");

        opcode = 6'b000000; funct = 6'b100101; #9;
        check_signals(2'b01, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 4'b0001, 1'b0, 1'b0, 1'b1, 1'b0, "OR  (Tipo-R)");

        opcode = 6'b000000; funct = 6'b101010; #9;
        check_signals(2'b01, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 4'b0111, 1'b0, 1'b0, 1'b1, 1'b0, "SLT (Tipo-R)");

        opcode = 6'b000000; funct = 6'b100111; #9;
        check_signals(2'b01, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 4'b1100, 1'b0, 1'b0, 1'b1, 1'b0, "NOR (Tipo-R)");

        opcode = 6'b000000; funct = 6'b001000; #9;
        check_signals(2'b01, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 4'b0000, 1'b0, 1'b0, 1'b0, 1'b1, "JR  (Tipo-R)");

        opcode = 6'b100011; funct = 6'b000000; #9;
        check_signals(2'b00, 1'b0, 1'b0, 1'b0, 1'b1, 2'b01, 4'b0010, 1'b0, 1'b1, 1'b1, 1'b0, "LW  (Tipo-I)");

        opcode = 6'b101011; funct = 6'b000000; #9;
        check_signals(2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 4'b0010, 1'b1, 1'b1, 1'b0, 1'b0, "SW  (Tipo-I)");

        opcode = 6'b001000; funct = 6'b000000; #9;
        check_signals(2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 4'b0010, 1'b0, 1'b1, 1'b1, 1'b0, "ADDI (Tipo-I)");

        opcode = 6'b000100; funct = 6'b000000; #9;
        check_signals(2'b00, 1'b0, 1'b0, 1'b1, 1'b0, 2'b00, 4'b0110, 1'b0, 1'b0, 1'b0, 1'b0, "BEQ (Tipo-I)");

        opcode = 6'b000010; funct = 6'b000000; #9;
        check_signals(2'b00, 1'b1, 1'b0, 1'b0, 1'b0, 2'b00, 4'b0010, 1'b0, 1'b0, 1'b0, 1'b0, "J   (Tipo-J)");

        opcode = 6'b000011; funct = 6'b000000; #9;
        check_signals(2'b10, 1'b1, 1'b1, 1'b0, 1'b0, 2'b10, 4'b0010, 1'b0, 1'b0, 1'b1, 1'b0, "JAL (Tipo-J)");

        #10;
        $display("==================================================");
        if (errors == 0) begin
            $display("[SUCESSO TOTAL] Todos os %0d testes da Control Unit passaram!", tests);
            $display("==================================================\n");
            $finish;
        end else begin
            $display("[FALHA] Foram encontrados %0d erros em %0d testes!", errors, tests);
            $display("==================================================\n");
            $finish(1);
        end
    end

endmodule