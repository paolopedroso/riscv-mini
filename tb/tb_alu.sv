/*
 *  Paolo Pedroso
 *
 *  Apache 2.0 License
 *
 *  ALU Testbench
 */

module tb_alu;
    logic [15:0] rs1_data_i;
    logic [15:0] rs2_data_i;
    logic [15:0] imm_data_i;
    logic [3:0]  func4;
    logic        imm_en_i;
    logic [15:0] alu_data_o;

    logic jalr_en_i;
    // logic [15:0] rs1_data_i;

    alu dut(.*);

    // Fixed and completed ALU test task
    task alu_test(
        input [3:0]  func4_in, 
        input [15:0] rs1_data_in, 
        input [15:0] rs2_data_in,
        input [15:0] imm_in, 
        input        imm_en_i_in, 
        input [15:0] expected
    );
        string alu_op;
        string operand_desc;
        
        // Map function code to operation name
        case(func4_in)
            4'b0000: alu_op = "ADD";
            4'b0001: alu_op = "SUB";
            4'b0010: alu_op = "INV";
            4'b0011: alu_op = "SLL";
            4'b0100: alu_op = "SLR";
            4'b0101: alu_op = "AND";
            4'b0110: alu_op = "OR";
            4'b0111: alu_op = "XOR";
            4'b1000: alu_op = "SLT";
            default: alu_op = "UNKNOWN";
        endcase

        // Apply inputs to DUT
        rs1_data_i = rs1_data_in;
        rs2_data_i = rs2_data_in;
        imm_data_i = imm_in;
        func4 = func4_in;
        imm_en_i = imm_en_i_in;
        
        // Wait for combinational logic to settle
        #1;
        
        // Create description of operands
        if (imm_en_i_in) begin
            operand_desc = $sformatf("%0d %s %0d (imm)", rs1_data_in, alu_op, imm_in);
        end else begin
            operand_desc = $sformatf("%0d %s %0d", rs1_data_in, alu_op, rs2_data_in);
        end
        
        // Check result and display
        if (alu_data_o == expected) begin
            $display("✓ PASS: %s = %0d", operand_desc, alu_data_o);
        end else begin
            $error("✗ FAIL: %s = %0d, Expected: %0d", operand_desc, alu_data_o, expected);
        end
    endtask

    // Task to reset all inputs
    task reset_inputs();
        rs1_data_i = 16'd0;
        rs2_data_i = 16'd0;
        imm_data_i = 16'd0;
        func4 = 4'd0;
        imm_en_i = 1'b0;
        jalr_en_i = 1'b0;
        #1;
    endtask

    // task alu_test(
    //     input [3:0]  func4_in, 
    //     input [15:0] rs1_data_in, 
    //     input [15:0] rs2_data_in,
    //     input [15:0] imm_in, 
    //     input        imm_en_i_in, 
    //     input [15:0] expected
    // );

    initial begin
        reset_inputs();
        #10;

        $display("Testing ALU Unit...\n");

        //////// ADD Tests ////////
        $display(" ADD Operations");
        alu_test(4'b0000, 16'd3, 16'd3, 16'd0, 1'b0, 16'd6);        // 3 + 3 = 6
        alu_test(4'b0000, 16'd10, 16'd5, 16'd0, 1'b0, 16'd15);      // 10 + 5 = 15
        alu_test(4'b0000, 16'd0, 16'd0, 16'd0, 1'b0, 16'd0);        // 0 + 0 = 0
        
        // ADDI Tests (ADD Immediate)
        $display(" ADDI Operations");
        alu_test(4'b0000, 16'd3, 16'd999, 16'd2, 1'b1, 16'd5);      // 3 + 2(imm) = 5
        alu_test(4'b0000, 16'd10, 16'd999, 16'd7, 1'b1, 16'd17);    // 10 + 7(imm) = 17
        
        //////// SUB Tests ////////
        $display(" SUB Operations");
        alu_test(4'b0001, 16'd5, 16'd4, 16'd0, 1'b0, 16'd1);        // 5 - 4 = 1
        alu_test(4'b0001, 16'd10, 16'd3, 16'd0, 1'b0, 16'd7);       // 10 - 3 = 7
        alu_test(4'b0001, 16'd5, 16'd5, 16'd0, 1'b0, 16'd0);        // 5 - 5 = 0
        
        //////// INV Tests ////////
        $display(" INV Operations");
        alu_test(4'b0010, 16'd2, 16'd0, 16'd0, 1'b0, 16'hFFFD);     // ~2 = 0xFFFD (65533)
        alu_test(4'b0010, 16'h0000, 16'd0, 16'd0, 1'b0, 16'hFFFF);  // ~0 = 0xFFFF
        alu_test(4'b0010, 16'hFFFF, 16'd0, 16'd0, 1'b0, 16'h0000);  // ~0xFFFF = 0
        
        //////// SLL Tests (Shift Left Logical) ////////
        $display(" SLL Operations");
        alu_test(4'b0011, 16'd4, 16'd1, 16'd0, 1'b0, 16'd8);        // 4 << 1 = 8
        alu_test(4'b0011, 16'd1, 16'd4, 16'd0, 1'b0, 16'd16);       // 1 << 4 = 16
        alu_test(4'b0011, 16'd5, 16'd0, 16'd0, 1'b0, 16'd5);        // 5 << 0 = 5
        
        //////// SLR Tests (Shift Right Logical) ////////
        $display(" SLR Operations");
        alu_test(4'b0100, 16'd8, 16'd1, 16'd0, 1'b0, 16'd4);        // 8 >> 1 = 4
        alu_test(4'b0100, 16'd16, 16'd4, 16'd0, 1'b0, 16'd1);       // 16 >> 4 = 1
        alu_test(4'b0100, 16'd5, 16'd0, 16'd0, 1'b0, 16'd5);        // 5 >> 0 = 5
        
        //////// AND Tests ////////
        $display(" AND Operations");
        alu_test(4'b0101, 16'hF0F0, 16'h0F0F, 16'd0, 1'b0, 16'h0000); // 0xF0F0 & 0x0F0F = 0x0000
        alu_test(4'b0101, 16'hFFFF, 16'h5555, 16'd0, 1'b0, 16'h5555); // 0xFFFF & 0x5555 = 0x5555
        alu_test(4'b0101, 16'd12, 16'd10, 16'd0, 1'b0, 16'd8);        // 12 & 10 = 8
        
        //////// OR Tests ////////
        $display(" OR Operations");
        alu_test(4'b0110, 16'hF0F0, 16'h0F0F, 16'd0, 1'b0, 16'hFFFF); // 0xF0F0 | 0x0F0F = 0xFFFF
        alu_test(4'b0110, 16'h0000, 16'h5555, 16'd0, 1'b0, 16'h5555); // 0x0000 | 0x5555 = 0x5555
        alu_test(4'b0110, 16'd12, 16'd10, 16'd0, 1'b0, 16'd14);       // 12 | 10 = 14
        
        //////// XOR Tests ////////
        $display(" XOR Operations");
        alu_test(4'b0111, 16'hF0F0, 16'h0F0F, 16'd0, 1'b0, 16'hFFFF); // 0xF0F0 ^ 0x0F0F = 0xFFFF
        alu_test(4'b0111, 16'hFFFF, 16'hFFFF, 16'd0, 1'b0, 16'h0000); // 0xFFFF ^ 0xFFFF = 0x0000
        alu_test(4'b0111, 16'd12, 16'd10, 16'd0, 1'b0, 16'd6);        // 12 ^ 10 = 6
        
        //////// SLT Tests (Set Less Than) ////////
        $display(" SLT Operations");
        alu_test(4'b1000, 16'd3, 16'd5, 16'd0, 1'b0, 16'd1);         // 3 < 5 = 1 (true)
        alu_test(4'b1000, 16'd5, 16'd3, 16'd0, 1'b0, 16'd0);         // 5 < 3 = 0 (false)
        alu_test(4'b1000, 16'd5, 16'd5, 16'd0, 1'b0, 16'd0);         // 5 < 5 = 0 (false)

        $display("\n=== ALU Testing Complete ===");
        #10;
        $finish;
    end
endmodule
