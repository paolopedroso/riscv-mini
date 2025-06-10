/*
*  Paolo Pedroso
*
*  Apache 2.0 License
*
*  Data Memory Testbench
*/


module tb_dmem;
// Input Signals
logic clk;
logic rst_n;
logic [15:0] address;
logic [15:0] mem_data;
logic mem_write_i;
logic mem_read_i;

// Output Signals
logic [15:0] read_data_o;

dmem dut(.*);

// clk generation

// 200 MHZ
always #5 clk = ~clk;

// Write Memory
// addr = address, data = mem_data
task write_dmem(input [15:0] addr, input [15:0] data);
    begin
        @(posedge clk);
        address = addr;
        mem_data = data;
        mem_write_i = 1;
        mem_read_i = 0;
        @(posedge clk);
        mem_write_i = 0;
        $display("WRITE: Addr=0x%04h, Data=0x%04h", addr, data);
    end
endtask

// Read Memory
task read_dmem(input [15:0] addr, input [15:0] expected);
    begin
        @(posedge clk);
        address = addr;
        mem_read_i = 1;
        mem_write_i = 0;
        @(posedge clk);
        mem_read_i = 0;

        if (expected == read_data_o) begin
            $display("✓ READ SUCCESS: Addr=0x%04h, Data=0x%04h", addr, expected);
        end else begin
            $error("✗ READ FAIL: Addr=0x%04h, Expected Data=0x%04h, Read Data=0x%04h", addr, expected, read_data_o);
        end
    end
endtask

// Test simultaneous read and write - checks write priority
task read_write(input [15:0] addr, input [15:0] data, input [15:0] expected);
    begin
        $display("CHECKING WRITE PRIORITY with simultaneous read/write...");
        @(posedge clk);
        mem_write_i = 1;
        mem_read_i = 1;
        mem_data = data;
        address = addr;
        @(posedge clk);
        mem_write_i = 0;
        mem_read_i = 0;
        $display("WRITE: Addr=0x%04h, Data=0x%04h", addr, data);
        
        // Wait a bit then verify the write was successful
        @(posedge clk);
        $display("VERIFYING WRITE was successful...");
        address = addr;
        mem_read_i = 1;
        mem_write_i = 0;
        @(posedge clk);
        mem_read_i = 0;
        
        if (read_data_o == expected) begin
            $display("✓ SUCCESS: Addr=0x%04h, Data=0x%04h", addr, expected);
        end else begin
            $error("✗ READ FAIL: Addr=0x%04h, Expected Data=0x%04h, Read Data=0x%04h", addr, expected, read_data_o);
        end
    end
endtask

// Task to reset all control signals
task reset_signals();
    begin
        address = 16'b0;
        mem_data = 16'b0;
        mem_write_i = 1'b0;
        mem_read_i = 1'b0;
    end
endtask

initial begin
    clk = 1'b0;
    rst_n = 1'b0;
    reset_signals();
    
    $display("Testing Data Memory Unit...");
    #20; // Wait for a few clock cycles
    
    rst_n = 1; // Release reset
    #10;

    // Test 1: Basic Write Operation
    $display("\nTest 1: Basic Write");
    write_dmem(16'h0000, 16'hABCD);

    // Test 2: Basic Read Operation
    $display("\nTest 2: Basic Read");
    read_dmem(16'h0000, 16'hABCD);

    // Test 3: Write to different address
    $display("\nTest 3: Write to different address");
    write_dmem(16'h0004, 16'h1234);
    read_dmem(16'h0004, 16'h1234);

    // Test 4: Verify first address still has original data
    $display("\nTest 4: Verify original data intact");
    read_dmem(16'h0000, 16'hABCD);

    // Test 5: Overwrite existing data
    $display("\nTest 5: Overwrite existing data");
    write_dmem(16'h0000, 16'h5678);
    read_dmem(16'h0000, 16'h5678);

    // Test 6: Simultaneous Read/Write (Write Priority Test)
    $display("\nTest 6: Simultaneous Read/Write");
    read_write(16'h0008, 16'h9ABC, 16'h9ABC);

    // Test 7: Read from uninitialized location
    $display("\nTest 7: Read from uninitialized location");
    read_dmem(16'h0010, 16'h0000); // Assuming uninitialized memory reads as 0

    // Test 8: Boundary testing
    $display("\nTest 8: Address boundary testing");
    write_dmem(16'hFFFC, 16'hDEAD);
    read_dmem(16'hFFFC, 16'hDEAD);

    $display("\n ALL TESTS FINISHED");
    #20;
    $finish;
end

endmodule