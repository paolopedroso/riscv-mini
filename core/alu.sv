/*
 *  Paolo Pedroso
 *
 *  Apache 2.0 License
 *
 *  Simple 16 bit ALU
 */

module alu (
    // input logic        rst_n,
    input logic [15:0] rs1_data,
    input logic [15:0] rs2_data,
    input logic [5:0]  imm,
    input logic [2:0]  op,
    input logic [3:0]  func4,

    output logic [15:0] alu_o

);

logic [15:0] operand_b;
logic [15:0] imm_ex;

always_comb begin : alu
    imm_ex = {{10{imm[5]}}, imm};
    operand_b = (op == 3'b001) ? imm_ex : rs2_data;
    case(func4)
        4'b0000: alu_o = rs1_data + operand_b; 
        4'b0001: alu_o = rs1_data - operand_b;
        4'b0010: alu_o = ~rs1_data;
        4'b0011: alu_o = rs1_data << operand_b;
        4'b0100: alu_o = rs1_data >> operand_b;
        4'b0101: alu_o = rs1_data & operand_b;
        4'b0110: alu_o = rs1_data | operand_b;
        4'b0111: alu_o = (rs1_data < operand_b) ? 16'b1 : 16'b0;
        default: alu_o = 16'b0;
    endcase
end

endmodule
