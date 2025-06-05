/*
 *  Paolo Pedroso
 *
 *  Apache 2.0 License
 *
 *  Simple 16-bit ALU
 */

import riscv_pkg::*;

module alu (
    input logic [15:0] rs1_data_i,
    input logic [15:0] rs2_data_i,
    input logic [15:0] imm_data_i,
    input logic imm_en_i,
    input logic [3:0] func4,

    input logic jalr_en_i,

    output logic [15:0] alu_data_o

);

logic [15:0] operand_b;

alu_src_t alu_sel;
assign alu_sel = alu_src_t'(func4);

always_comb begin : alu
    operand_b = (imm_en_i) ? imm_data_i : rs2_data_i;
    if (jalr_en_i) begin
        alu_data_o = (rs1_data_i + imm_data_i) & 16'hFFFE;
    end else begin
        case(alu_sel)
            ADD: alu_data_o = rs1_data_i + operand_b; 
            SUB: alu_data_o = rs1_data_i - operand_b;
            INV: alu_data_o = ~rs1_data_i;
            SLL: alu_data_o = rs1_data_i << operand_b;
            SLR: alu_data_o = rs1_data_i >> operand_b;
            AND: alu_data_o = rs1_data_i & operand_b;
            OR: alu_data_o = rs1_data_i | operand_b;
            XOR: alu_data_o = rs1_data_i ^ operand_b;
            SLT: alu_data_o = (rs1_data_i < operand_b) ? 16'b1 : 16'b0;
            default: alu_data_o = 16'b0;
        endcase
    end
end

endmodule
