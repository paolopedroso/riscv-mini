/*
 *  Paolo Pedroso
 *
 *  Apache 2.0 License
 *
 *  Simple 16-bit ALU
 */

import riscv_pkg::*;

module alu (
    // input logic        rst_n,
    input logic [15:0] rs1_data,
    input logic [15:0] rs2_data,
    input logic [5:0]  imm,
    input logic [2:0]  op,
    input logic [3:0]  func4,

    output logic [15:0] alu_data_o

);

logic [15:0] operand_b;
logic [15:0] imm_ex;

alu_src_t alu_sel;
assign alu_sel = alu_src_t'(func4);

always_comb begin : alu
    imm_ex = {{10{imm[5]}}, imm};
    operand_b = (op == 3'b001) ? imm_ex : rs2_data;
    case(alu_sel)
        ADD: alu_data_o = rs1_data + operand_b; 
        SUB: alu_data_o = rs1_data - operand_b;
        INV: alu_data_o = ~rs1_data;
        SLL: alu_data_o = rs1_data << operand_b;
        SLR: alu_data_o = rs1_data >> operand_b;
        AND: alu_data_o = rs1_data & operand_b;
        OR: alu_data_o = rs1_data | operand_b;
        SLT: alu_data_o = (rs1_data < operand_b) ? 16'b1 : 16'b0;
        default: alu_data_o = 16'b0;
    endcase
end

endmodule
