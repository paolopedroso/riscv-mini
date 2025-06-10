/*
 * Paolo Pedroso
 *
 * Apache 2.0 License
 *
 * Simple 16-bit Decoder Unit
 */


module decode (
    input logic [15:0] instr,

    output logic [2:0] opcode_o,
    output logic [2:0] rs1_addr_o,
    output logic [2:0] rd_addr_o,
    output logic [2:0] rs2_addr_o,
    output logic [3:0] func4_o,    // Extended opcode field, e.g., for R-type
    output logic [1:0] func2_o,    // Opcode qualifier, e.g., like funct3 for I,L,S,B-types
    output logic [15:0] imm_data_o

    // Control
    // output logic       mem_write_o,
    // output logic       mem_read_o
);

import riscv_pkg::*;

opcode_t opcode;
assign opcode = opcode_t'(instr[2:0]);
assign opcode_o = instr[2:0];

always_comb begin
    // op_o        = instr[2:0]; // op_o always reflects the opcode bits from instruction
    rs1_addr_o  = 3'b0;
    rd_addr_o   = 3'b0;
    rs2_addr_o  = 3'b0;
    func4_o     = 4'b0;
    func2_o     = 2'b0;
    imm_data_o  = 16'b0;

    case (opcode) // Decode based on the 3-bit opcode
        R_OP: begin
            rd_addr_o   = instr[5:3];
            rs1_addr_o  = instr[8:6];
            rs2_addr_o  = instr[11:9];
            func4_o     = instr[15:12];
            // func2_ = '0;
            // imm_data_o  = '0;
        end

        I_OP: begin
            rd_addr_o   = instr[5:3];
            rs1_addr_o  = instr[8:6];
            func2_o     = instr[10:9];
            imm_data_o  = {{11{instr[15]}}, instr[15:11]};
            // rs2_addr_o  r_o = '0;
            // func4_o = '0;
        end

        L_OP: begin
            rd_addr_o   = instr[5:3];
            rs1_addr_o  = instr[8:6];
            func2_o     = instr[10:9];
            imm_data_o  = {{11{instr[15]}}, instr[15:11]};
            // func2
            // 00: lb, 01: lh, 10/11: lw
            // // Control
            // mem_write_o = 1'b0;
            // mem_read_o = 1'b1;
        end

        S_OP: begin
            // SW, SH, SB
            rs1_addr_o  = instr[8:6];
            rs2_addr_o  = instr[5:3];
            func2_o     = instr[10:9];
            imm_data_o  = {{11{instr[15]}}, instr[15:11]};
            
            // 00: sb, 01: sh, 10/11: sw
            // // Control
            // mem_write_o = 1'b1;
            // mem_read_o = 1'b0;    
        end

        B_OP: begin
            // BEQ, BNE
            rs1_addr_o  = instr[8:6];
            rs2_addr_o  = instr[5:3];
            func2_o     = instr[10:9];

            imm_data_o  = {{11{instr[15]}}, instr[15:11]};
        end

        J_OP: begin
            rd_addr_o   = instr[5:3];
            imm_data_o  = {{6{instr[15]}}, instr[15:6]};
        end

        JR_OP: begin
            rd_addr_o   = instr[5:3];
            rs1_addr_o  = instr[8:6];
            imm_data_o  = {{10{instr[15]}}, instr[15:10]};

        end

        default: begin
        end
    endcase
end

endmodule
