// ============================================================================
// Modulo: main_control — Unidade de Controle Principal
// ============================================================================

`timescale 1ns / 1ps

module main_control #(
    parameter OPCODE_WIDTH = 6, // Largura do campo opcode
    parameter ALU_OP_WIDTH = 2  // Largura do sinal alu_op
) (
    input  wire [OPCODE_WIDTH-1:0] opcode,     // Codigo de operacao — bits 31 a 26 da instrucao
    output reg  [1:0]              reg_dst,    // 2'b00: rt, 2'b01: rd, 2'b10: $31 — $ra para jal
    output reg                     jump,       // 1: desvio incondicional — j ou jal
    output reg                     jal,        // 1: desvio com link — salva PC+4 em $31
    output reg                     branch,     // 1: desvio condicional por igualdade — beq
    output reg                     bne,        // 1: desvio condicional por diferenca — bne
    output reg                     mem_read,   // 1: habilita leitura da memoria de dados — lw
    output reg  [1:0]              mem_to_reg, // 2'b00: ALU, 2'b01: Memoria de Dados, 2'b10: PC+4 — jal
    output reg  [ALU_OP_WIDTH-1:0] alu_op,     // 2'b00: soma — lw, sw, addi —, 2'b01: subtracao — beq —, 2'b10: tipo-R
    output reg                     mem_write,  // 1: habilita escrita na memoria de dados — sw
    output reg                     alu_src,    // 0: segundo operando e registrador rt, 1: imediato estendido
    output reg                     reg_write   // 1: habilita escrita no banco de registradores
);

    // Codigos de operacao (Opcodes MIPS)
    localparam [OPCODE_WIDTH-1:0] OP_RTYPE = 6'b000000,
                                  OP_J     = 6'b000010,
                                  OP_JAL   = 6'b000011,
                                  OP_BEQ   = 6'b000100,
                                  OP_BNE   = 6'b000101,
                                  OP_ADDI  = 6'b001000,
                                  OP_SLTI  = 6'b001010,
                                  OP_LW    = 6'b100011,
                                  OP_SW    = 6'b101011;

    always @(opcode) begin
        // Valores padrao para evitar inferencia de latches
        reg_dst    = 2'b00;
        jump       = 1'b0;
        jal        = 1'b0;
        branch     = 1'b0;
        bne        = 1'b0;
        mem_read   = 1'b0;
        mem_to_reg = 2'b00;
        alu_op     = 2'b00;
        mem_write  = 1'b0;
        alu_src    = 1'b0;
        reg_write  = 1'b0;

        case (opcode)
            OP_RTYPE: begin
                reg_dst    = 2'b01;
                alu_src    = 1'b0;
                mem_to_reg = 2'b00;
                reg_write  = 1'b1;
                alu_op     = 2'b10;
            end

            OP_LW: begin
                reg_dst    = 2'b00;
                alu_src    = 1'b1;
                mem_to_reg = 2'b01;
                reg_write  = 1'b1;
                mem_read   = 1'b1;
                alu_op     = 2'b00;
            end

            OP_SW: begin
                alu_src    = 1'b1;
                mem_write  = 1'b1;
                alu_op     = 2'b00;
            end

            OP_ADDI: begin
                reg_dst    = 2'b00;
                alu_src    = 1'b1;
                mem_to_reg = 2'b00;
                reg_write  = 1'b1;
                alu_op     = 2'b00;
            end

            OP_SLTI: begin
                reg_dst    = 2'b00;
                alu_src    = 1'b1;
                mem_to_reg = 2'b00;
                reg_write  = 1'b1;
                alu_op     = 2'b11; // 11 mapeia para ALU_SLT na controladora da ALU
            end

            OP_BEQ: begin
                branch     = 1'b1;
                alu_op     = 2'b01;
            end

            OP_BNE: begin
                bne        = 1'b1;
                alu_op     = 2'b01;
            end

            OP_J: begin
                jump       = 1'b1;
            end

            OP_JAL: begin
                jump       = 1'b1;
                jal        = 1'b1;
                reg_dst    = 2'b10;
                mem_to_reg = 2'b10;
                reg_write  = 1'b1;
            end

            default: begin
                // Mantem sinais zerados para opcodes desconhecidos
            end
        endcase
    end

endmodule