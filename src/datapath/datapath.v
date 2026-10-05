// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxilio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Modulo: datapath — Caminho de Dados Monociclo MIPS
// ============================================================================

`timescale 1ns / 1ps

module datapath #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32
) (
    input  wire                  clk,
    input  wire                  reset,
    input  wire [1:0]            reg_dst,
    input  wire                  jump,
    input  wire                  jal,
    input  wire                  branch,
    input  wire                  bne,
    input  wire [1:0]            mem_to_reg,
    input  wire [3:0]            alu_ctrl,
    input  wire                  alu_src,
    input  wire                  reg_write,
    input  wire                  jr,
    input  wire [DATA_WIDTH-1:0] instr,
    output wire [ADDR_WIDTH-1:0] pc_out,
    output wire [5:0]            opcode,
    output wire [5:0]            funct,
    input  wire [DATA_WIDTH-1:0] mem_read_data,
    output wire [ADDR_WIDTH-1:0] alu_result,
    output wire [DATA_WIDTH-1:0] mem_write_data,
    output wire                  zero
);

    // PC e PC + 4
    wire [ADDR_WIDTH-1:0] pc_current;
    wire [ADDR_WIDTH-1:0] next_pc;
    wire [ADDR_WIDTH-1:0] pc_plus_4;

    pc #(.DATA_WIDTH(ADDR_WIDTH)) pc_inst (
        .clk(clk),
        .reset(reset),
        .pc_in(next_pc),
        .pc_out(pc_current)
    );

    assign pc_out = pc_current;

    adder #(.DATA_WIDTH(ADDR_WIDTH)) pc_adder_inst (
        .a(pc_current),
        .b({{(ADDR_WIDTH-3){1'b0}}, 3'd4}),
        .result(pc_plus_4)
    );

    // Decodificacao dos campos da instrucao
    assign opcode = instr[31:26];
    assign funct  = instr[5:0];

    wire [4:0]  rs       = instr[25:21];
    wire [4:0]  rt       = instr[20:16];
    wire [4:0]  rd       = instr[15:11];
    wire [15:0] imm16    = instr[15:0];
    wire [25:0] target26 = instr[25:0];

    // Extensao de sinal e calculo de branch
    wire [DATA_WIDTH-1:0] sign_ext_imm;
    wire [ADDR_WIDTH-1:0] pc_branch;

    sign_extend #(.IN_WIDTH(16), .OUT_WIDTH(DATA_WIDTH)) sign_ext_inst (
        .in(imm16),
        .out(sign_ext_imm)
    );

    wire [ADDR_WIDTH-1:0] branch_offset = {sign_ext_imm[ADDR_WIDTH-3:0], 2'b00};

    adder #(.DATA_WIDTH(ADDR_WIDTH)) branch_adder_inst (
        .a(pc_plus_4),
        .b(branch_offset),
        .result(pc_branch)
    );

    // Selecao do proximo PC (Branch, Jump e JR)
    wire                  pc_src = (branch & zero) | (bne & ~zero);
    wire [ADDR_WIDTH-1:0] pc_next_branch;
    wire [ADDR_WIDTH-1:0] pc_jump = {pc_plus_4[31:28], target26, 2'b00};
    wire [ADDR_WIDTH-1:0] pc_next_jump;

    mux2to1 #(.DATA_WIDTH(ADDR_WIDTH)) mux_branch_inst (
        .d0(pc_plus_4),
        .d1(pc_branch),
        .sel(pc_src),
        .y(pc_next_branch)
    );

    mux2to1 #(.DATA_WIDTH(ADDR_WIDTH)) mux_jump_inst (
        .d0(pc_next_branch),
        .d1(pc_jump),
        .sel(jump),
        .y(pc_next_jump)
    );

    wire [DATA_WIDTH-1:0] read_data1;

    mux2to1 #(.DATA_WIDTH(ADDR_WIDTH)) mux_jr_inst (
        .d0(pc_next_jump),
        .d1(read_data1[ADDR_WIDTH-1:0]),
        .sel(jr),
        .y(next_pc)
    );

    // Banco de Registradores
    wire [4:0]            write_reg;
    wire [DATA_WIDTH-1:0] read_data2;
    wire [DATA_WIDTH-1:0] reg_write_data;

    mux3to1 #(.DATA_WIDTH(5)) mux_reg_dst_inst (
        .d0(rt),
        .d1(rd),
        .d2(5'd31),
        .sel(reg_dst),
        .y(write_reg)
    );

    reg_file #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(5),
        .NUM_REGS(32)
    ) reg_file_inst (
        .clk(clk),
        .reset(reset),
        .reg_write(reg_write),
        .read_reg1(rs),
        .read_reg2(rt),
        .write_reg(write_reg),
        .write_data(reg_write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    assign mem_write_data = read_data2;

    // ULA e selecao de operando B
    wire [DATA_WIDTH-1:0] alu_operand_b;
    wire [DATA_WIDTH-1:0] alu_res;

    mux2to1 #(.DATA_WIDTH(DATA_WIDTH)) mux_alu_src_inst (
        .d0(read_data2),
        .d1(sign_ext_imm),
        .sel(alu_src),
        .y(alu_operand_b)
    );

    alu #(
        .DATA_WIDTH(DATA_WIDTH),
        .ALU_CTRL_WIDTH(4)
    ) alu_inst (
        .src_a(read_data1),
        .src_b(alu_operand_b),
        .shamt(instr[10:6]),
        .alu_ctrl(alu_ctrl),
        .alu_result(alu_res),
        .zero(zero)
    );

    assign alu_result = alu_res;

    // Selecao do dado de retorno (MemtoReg)
    mux3to1 #(.DATA_WIDTH(DATA_WIDTH)) mux_mem_to_reg_inst (
        .d0(alu_res),
        .d1(mem_read_data),
        .d2(pc_plus_4),
        .sel(mem_to_reg),
        .y(reg_write_data)
    );

endmodule
