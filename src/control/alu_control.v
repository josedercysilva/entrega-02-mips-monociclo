// ============================================================================
// Universidade Federal do Amazonas - UFAM
// Faculdade de Engenharia Elétrica e da Computação - FEEC
// Disciplina: Arquitetura de Sistemas Digitais e Laboratorio
// Manaus, Amazonas, Brasil
// Desenvolvido com auxilio de: Gemini 3.8 Flash — High
// ----------------------------------------------------------------------------
// Modulo: alu_control — Controle da ALU
// Descricao: Decodifica o sinal alu_op vindo do controle principal e o campo
//            funct da instrucao — bits [5:0] — para instrucoes tipo-R.
//            Gera o codigo de controle da ALU, alu_ctrl de 4 bits, e o sinal
//            de deteccao de desvio por registrador — jr.
// ============================================================================

`timescale 1ns / 1ps

module alu_control (
    input  wire [1:0] alu_op,
    input  wire [5:0] funct,
    output reg  [3:0] alu_ctrl, 
    output reg        jr        
);

    always @(*) begin
        
        alu_ctrl = 4'b0000;
        jr       = 1'b0;

        case (alu_op)
            2'b00: begin
                // Usado por lw, sw, addi
                // A ALU sempre soma os endereços
                alu_ctrl = 4'b0010; 
            end

            2'b01: begin
                // Usado por beq, bne
                // A ALU sempre subtrai para ativar a flag "zero"
                alu_ctrl = 4'b0110; 
            end

            2'b10: begin
                // Usado pelas Instruções Tipo-R. s
                case (funct)
                    6'b100000: alu_ctrl = 4'b0010; // add (Soma)
                    6'b100010: alu_ctrl = 4'b0110; // sub (Subtração)
                    6'b100100: alu_ctrl = 4'b0000; // and (E lógico)
                    6'b100101: alu_ctrl = 4'b0001; // or  (Ou lógico)
                    6'b101010: alu_ctrl = 4'b0111; // slt (Set on Less Than)
                    6'b100111: alu_ctrl = 4'b1100; // nor (NOR lógico)
                    
                    6'b001000: begin 
                        // jr (Jump Register) - Instrução especial Tipo-R
                        // O controle principal não sabe que é um JR, ele só 
                        // sabe que é Tipo-R e manda pra cá.
                        // Aqui detectamos o funct e disparamos a flag "jr".
                        jr = 1'b1;
                    end
                    
                    default: alu_ctrl = 4'b0000;
                endcase
            end

            default: alu_ctrl = 4'b0000;
        endcase
    end
endmodule