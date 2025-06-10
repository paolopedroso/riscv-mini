/*
 * Paolo Pedroso
 *
 * Apache 2.0 License
 *
 * Control Unit
 */


module control (
    input logic [2:0] op_i,
    input logic [1:0] func2_i,
    input logic [15:0] rs1_data_i,
    input logic [15:0] rs2_data_i,

    output logic [1:0] wb_sel_o,
    output logic mem_write_o,
    output logic mem_read_o,

    output logic imm_en_o,
    output logic write_en_o,

    output logic jal_en_o,
    output logic jalr_en_o,
    output logic branch_en_o
);

import riscv_pkg::*;

opcode_t opcode;
assign opcode = opcode_t'(op_i);

always_comb begin
    imm_en_o = 1'b0;
    write_en_o = 1'b0;
    mem_write_o = 1'b0;
    mem_read_o = 1'b0;
    wb_sel_o = 2'b0;
    jal_en_o = 1'b0;
    jalr_en_o = 1'b0;
    branch_en_o = 1'b0;
    case(opcode)
        R_OP: begin
            wb_sel_o = WB_ALU;
            write_en_o = 1'b1;
        end
        I_OP: begin
            wb_sel_o = WB_ALU;
            imm_en_o = 1'b1;
            write_en_o = 1'b1;
        end
        L_OP: begin
            mem_write_o = 1'b0;
            mem_read_o = 1'b1;
            
            wb_sel_o = WB_MEM;
        end

        S_OP: begin
            mem_write_o = 1'b1;
            mem_read_o = 1'b0;
        end
        B_OP: begin
            // BEQ, BNE
            case(func2_i)
                00: branch_en_o = (rs1_data_i == rs2_data_i) ? 1: 0;
                01: branch_en_o = (rs1_data_i != rs2_data_i) ? 1: 0;
                default: branch_en_o = 1'b0;
            endcase
        end
        J_OP: begin
            jal_en_o = 1'b1;
            wb_sel_o = WB_PC_PLUS_FOUR;
        end
        JR_OP: begin
            jalr_en_o = 1'b1;
            wb_sel_o = WB_PC_PLUS_FOUR;
        end
        default: begin
            mem_write_o = 1'b0;
            mem_read_o = 1'b0;
            wb_sel_o = WB_ALU;
        end
    endcase
end

endmodule
