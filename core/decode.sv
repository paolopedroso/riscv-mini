/*
 *  Paolo Pedroso
 *
 *  Apache 2.0 License
 *
 *  Simple 16 bit Decoder
 */

module decode (
    input logic [15:0] instr,

    output logic [2:0] op_o,
    output logic [2:0] rs1_addr_o,
    output logic [2:0] rd_o,
    output logic [2:0] rs2_addr_o,
    output logic [3:0] func4_o,
    output logic [2:0] func2_o,
    output logic [5:0] imm_o

);

logic r_en = 1'b0;
logic i_en = 1'b0;
logic l_en = 1'b0;
logic s_en = 1'b0;
logic b_en = 1'b0;
logic j_en = 1'b0;

logic [2:0] op_in = instr[2:0];

always_comb begin
    case(op_in)
        3'b000: r_en = 1'b1;
        3'b001: i_en = 1'b1;
        3'b010: l_en = 1'b1;
        3'b011: s_en = 1'b1;
        3'b100: b_en = 1'b1;
        3'b101: j_en = 1'b1;            
        default: begin
            r_en = 1'b0;
            i_en = 1'b0;
            l_en = 1'b0;
            s_en = 1'b0;
            b_en = 1'b0;
            j_en = 1'b0;
        end
    endcase
    
    if (r_en) begin
        op_o = instr[2:0];
        rs1_addr_o = instr[6:4]; 
        rd_o = instr[9:7]; 
        func4_o = instr[15:12];
        rs2_addr_o = instr[12:10]; 

        imm_o = 6'b0;
    end 
    else if (i_en) begin
        op_o = instr[2:0];
        rs1_addr_o = instr[6:4];
        rd_o = instr[9:7];
        imm_o = instr[15:10];

        rs2_addr_o = 3'b0;
        func4_o = 4'b0;
    end
    else if (l_en) begin
        op_o = instr[2:0];
        rs1_addr_o = instr[6:4];
        rd_o = instr[9:7];
        func2_o = instr[11:10];
        imm_o = instr[15:12];

        func4_o = 4'b0;
        rs2_addr_o = 3'b0;
    end
    else if (s_en) begin
        op_o = instr[2:0];
        rs1_addr_o = instr[6:4];
        rs2_addr_o = instr[9:7];
        func2_o = instr[11:10];
        imm_o = instr[15:12];

        func4_o = 4'b0;
        rd_o = 3'b0;
    end
    else begin
        op_o = 3'b0;
        rs1_addr_o = 3'b0;
        rd_o = 3'b0;
        rs2_addr_o = 3'b0;
        func4_o = 4'b0;
        imm_o = 6'b0;
    end
end

endmodule