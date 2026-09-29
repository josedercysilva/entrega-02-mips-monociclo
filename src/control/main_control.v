// ============================================================================
// Modulo: main_control — Unidade de Controle Principal
// ============================================================================

`timescale 1ns / 1ps

module main_control (
    input  wire [5:0] opcode,
    output reg  [1:0] reg_dst,
    output reg        jump,
    output reg        jal,
    output reg        branch,
    output reg        branch_bne,
    output reg        mem_read,
    output reg  [1:0] mem_to_reg,
    output reg  [1:0] alu_op,
    output reg        mem_write,
    output reg        alu_src,
    output reg        reg_write
);

    always @(opcode) begin
        // Valores padrao
        reg_dst    = 2'b00;
        jump       = 1'b0;
        jal        = 1'b0;
        branch     = 1'b0;
        branch_bne = 1'b0;
        mem_read   = 1'b0;
        mem_to_reg = 2'b00;
        alu_op     = 2'b00;
        mem_write  = 1'b0;
        alu_src    = 1'b0;
        reg_write  = 1'b0;

        case (opcode)
            6'b000000: begin // Tipo-R
                reg_dst    = 2'b01;
                alu_src    = 1'b0;
                mem_to_reg = 2'b00;
                reg_write  = 1'b1;
                alu_op     = 2'b10;
            end

            6'b100011: begin // lw
                reg_dst    = 2'b00;
                alu_src    = 1'b1;
                mem_to_reg = 2'b01;
                reg_write  = 1'b1;
                mem_read   = 1'b1;
                alu_op     = 2'b00;
            end

            6'b101011: begin // sw
                alu_src    = 1'b1;
                mem_write  = 1'b1;
                alu_op     = 2'b00;
            end

            6'b001000: begin // addi
                reg_dst    = 2'b00;
                alu_src    = 1'b1;
                mem_to_reg = 2'b00;
                reg_write  = 1'b1;
                alu_op     = 2'b00;
            end

            6'b000100: begin // beq
                branch     = 1'b1;
                alu_op     = 2'b01;
            end

            6'b000101: begin // bne
                branch_bne = 1'b1;
                alu_op     = 2'b01;
            end

            6'b000010: begin // j
                jump       = 1'b1;
            end

            6'b000011: begin // jal
                jump       = 1'b1;
                jal        = 1'b1;
                reg_dst    = 2'b10;
                mem_to_reg = 2'b10;
                reg_write  = 1'b1;
            end
        endcase
    end
endmodule