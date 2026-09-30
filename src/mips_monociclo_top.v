// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// Autor: José Dercy Vieira da Silva Filho <josedercysilva@gmail.com>
// Desenvolvido com auxilio de: Google Antigravity (Google DeepMind) — Gemini 3.8 Flash
// ----------------------------------------------------------------------------
// Modulo: mips_monociclo_top — Modulo Raiz — Processador MIPS Monociclo
// ============================================================================

`timescale 1ns / 1ps

module mips_monociclo_top #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32,
    parameter MEM_DEPTH  = 256
) (
    input  wire                  clk,
    input  wire                  reset,
    output wire [ADDR_WIDTH-1:0] pc,
    output wire [DATA_WIDTH-1:0] instr,
    output wire [DATA_WIDTH-1:0] alu_result,
    output wire [DATA_WIDTH-1:0] dmem_data,
    output wire                  dmem_write_enable
);

    wire [ADDR_WIDTH-1:0] pc_bus;
    wire [DATA_WIDTH-1:0] instr_bus;
    wire [5:0]            opcode_bus;
    wire [5:0]            funct_bus;

    wire [1:0]            reg_dst_ctrl;
    wire                  jump_ctrl;
    wire                  jal_ctrl;
    wire                  branch_ctrl;
    wire                  mem_read_ctrl;
    wire [1:0]            mem_to_reg_ctrl;
    wire [3:0]            alu_ctrl_bus;
    wire                  mem_write_ctrl;
    wire                  alu_src_ctrl;
    wire                  reg_write_ctrl;
    wire                  jr_ctrl;

    wire [DATA_WIDTH-1:0] mem_read_data_bus;
    wire [ADDR_WIDTH-1:0] alu_result_bus;
    wire [DATA_WIDTH-1:0] mem_write_data_bus;
    wire                  zero_flag;

    instr_mem #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .MEM_DEPTH(MEM_DEPTH)
    ) instr_mem_inst (
        .addr(pc_bus),
        .instr(instr_bus)
    );

    control_unit control_unit_inst (
        .opcode(opcode_bus),
        .funct(funct_bus),
        .reg_dst(reg_dst_ctrl),
        .jump(jump_ctrl),
        .jal(jal_ctrl),
        .branch(branch_ctrl),
        .mem_read(mem_read_ctrl),
        .mem_to_reg(mem_to_reg_ctrl),
        .alu_ctrl(alu_ctrl_bus),
        .mem_write(mem_write_ctrl),
        .alu_src(alu_src_ctrl),
        .reg_write(reg_write_ctrl),
        .jr(jr_ctrl)
    );

    datapath #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) datapath_inst (
        .clk(clk),
        .reset(reset),
        .reg_dst(reg_dst_ctrl),
        .jump(jump_ctrl),
        .jal(jal_ctrl),
        .branch(branch_ctrl),
        .mem_to_reg(mem_to_reg_ctrl),
        .alu_ctrl(alu_ctrl_bus),
        .alu_src(alu_src_ctrl),
        .reg_write(reg_write_ctrl),
        .jr(jr_ctrl),
        .instr(instr_bus),
        .pc_out(pc_bus),
        .opcode(opcode_bus),
        .funct(funct_bus),
        .mem_read_data(mem_read_data_bus),
        .alu_result(alu_result_bus),
        .mem_write_data(mem_write_data_bus),
        .zero(zero_flag)
    );

    data_mem #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .MEM_DEPTH(MEM_DEPTH)
    ) data_mem_inst (
        .clk(clk),
        .mem_read(mem_read_ctrl),
        .mem_write(mem_write_ctrl),
        .addr(alu_result_bus),
        .write_data(mem_write_data_bus),
        .read_data(mem_read_data_bus)
    );

    assign pc                = pc_bus;
    assign instr             = instr_bus;
    assign alu_result        = alu_result_bus;
    assign dmem_data         = mem_write_data_bus;
    assign dmem_write_enable = mem_write_ctrl;

endmodule
