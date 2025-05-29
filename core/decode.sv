/*
 * Paolo Pedroso
 *
 * Apache 2.0 License
 *
 * Simple 16 bit Decoder - Revised
 */

module decode (
    input logic [15:0] instr,

    output logic [2:0] op_o,
    output logic [2:0] rs1_addr_o,
    output logic [2:0] rd_o,
    output logic [2:0] rs2_addr_o,
    output logic [3:0] func4_o,    // Extended opcode field, e.g., for R-type
    output logic [2:0] func2_o,    // Opcode qualifier, e.g., like funct3 for I,L,S,B-types
    output logic [5:0] imm_o,

    // Control
    // output logic       mem_write_o,
    // output logic       mem_read_o
);

localparam R_OP = 3'b000; // R-type (register-register)
localparam I_OP = 3'b001; // I-type (immediate arithmetic/logical)
localparam L_OP = 3'b010; // L-type (load)
localparam S_OP = 3'b011; // S-type (store)
localparam B_OP = 3'b100; // B-type (branch)
localparam J_OP = 3'b101; // J-type (jump)

always_comb begin
    op_o        = instr[2:0]; // op_o always reflects the opcode bits from instruction
    rs1_addr_o  = 3'b0;
    rd_o        = 3'b0;
    rs2_addr_o  = 3'b0;
    func4_o     = 4'b0;
    func2_o     = 3'b0;
    imm_o       = 6'b0;

    case (instr[2:0]) // Decode based on the 3-bit opcode
        R_OP: begin
            rd_o        = instr[5:3];
            rs1_addr_o  = instr[8:6];
            rs2_addr_o  = instr[11:9];
            func4_o     = instr[15:12];
            // func2_ = '0;
            // imm_o  = '0;
        end

        I_OP: begin
            rd_o        = instr[5:3];
            rs1_addr_o  = instr[8:6];
            func2_o     = instr[11:9];
            imm_o       = {{2{instr[15]}}, instr[15:12]};
            // rs2_addr_o = '0;
            // func4_o = '0;
        end

        L_OP: begin
            rd_o        = instr[5:3];
            rs1_addr_o  = instr[8:6];
            func2_o     = instr[11:9];
            imm_o       = {{2{instr[15]}}, instr[15:12]};

            // // Control
            // mem_write_o = 1'b0;
            // mem_read_o = 1'b1;
        end

        S_OP: begin
            // SW, SH, SB
            rs1_addr_o  = instr[8:6];
            rs2_addr_o  = instr[5:3];
            func2_o     = instr[11:9];
            imm_o       = {{2{instr[15]}}, instr[15:12]};

            // // Control
            // mem_write_o = 1'b1;
            // mem_read_o = 1'b0;    
        end

        B_OP: begin
            // BEQ, BNE
            rs1_addr_o  = instr[8:6];    // First source register for comparison
            rs2_addr_o  = instr[5:3];    // Second source register for comparison
            func2_o     = instr[11:9];   // Specifies branch condition

            imm_o       = {{2{instr[15]}}, instr[15:12]};
        end

        J_OP: begin
            // JAL
            rd_o        = instr[5:3];
            imm_o       = instr[15:10];
        end

        default: begin
        end
    endcase
end

endmodule
