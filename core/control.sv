/*
 * Paolo Pedroso
 *
 * Apache 2.0 License
 *
 * Control Unit
 */

import riscv_pkg::*;

module control (
    input logic [2:0] op_i,

    output logic [1:0] wb_sel_o,
    output logic mem_write_o,
    output logic mem_read_o,

    output logic imm_en_o,
    output logic jal_en_o,
    output logic jalr_en_o
);

// localparam L_OP = 3'b010; // L-type (load)
// localparam S_OP = 3'b011; // S-type (store)

opcode_t opcode;
assign opcode = opcode_t'(op_i);

always_comb begin
    imm_en_o = 1'b0;
    mem_write_o = 1'b0;
    mem_read_o = 1'b0;
    wb_sel_o = 2'b0;
    jal_en_o = 1'b0;
    jalr_en_o = 1'b0;
    case(opcode)
        R_OP: begin
            wb_sel_o = WB_ALU;
        end
        I_OP: begin
            wb_sel_o = WB_ALU;
            imm_en_o = 1'b1;
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
