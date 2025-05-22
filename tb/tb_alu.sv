/*
 *  Paolo Pedroso
 *
 *  Apache 2.0 License
 *
 *  ALU Testbench
 */


module tb_alu;
    logic [15:0] rs1_data;
    logic [15:0] rs2_data;
    logic [5:0]  imm;
    logic [2:0]  op;
    logic [3:0]  func4;
    logic [15:0] alu_o;

    alu dut(.*);

    initial begin
        rs1_data = 16'd0;
        rs2_data = 16'd0;
        imm = 6'd0;
        op = 3'd0;
        func4 = 4'd0;
        #10;

        $display("Testing ALU unit...");

//////// ADD ////////

        $display("Adding 3 + 3...");
        rs1_data = 16'd3;
        rs2_data = 16'd3;
        op = 3'd0;
        func4 = 4'd0; // ADD
        #1;
        if (alu_o != 16'd6) begin
            $display("E: ALU ADD incorrect! alu_o=%0d", alu_o);
        end else begin
            $display("ALU ADD Pass!");
        end

//////// SUB ////////

        $display("Subtracting 5 - 4...");
        rs1_data = 16'd5;
        rs2_data = 16'd4;
        func4 = 4'd1; // SUB
        #1;
        if (alu_o != 16'd1) begin
            $display("E: ALU SUB incorrect! alu_o=%0d", alu_o);
        end else begin
            $display("ALU SUB Pass!");
        end

//////// INV ////////

        $display("Inverting 2...");
        rs1_data = 16'd2;
        rs2_data = 16'd0; // Unused
        func4 = 4'd2; // INV
        #1;
        if (alu_o != 16'd65533) begin
            $display("E: ALU INV incorrect! alu_o=%0d", alu_o);
        end else begin
            $display("ALU INV Pass!");
        end

//////// SLL ////////

//////// SLR ////////

//////// AND ////////

//////// OR ////////

//////// SLT ////////

        #10;
        $finish;
    end
endmodule