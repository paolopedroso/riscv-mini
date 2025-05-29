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

    always #5 clk = ~clk; // clk generation

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
            @(posedge clk); // First posedge
            address = addr;
            mem_read_i = 1;
            mem_write_i = 0;
            @(posedge clk); // Second posedge
            mem_read_i = 0;

            if (expected == read_data_o) begin
                $display("READ SUCCESS: Addr=0x%04h, Data=0x%04h", addr, expected);
            end else begin
                $error("READ FAIL: Addr=0x%04h, Expected Data=0x%04h, Read Data=0x%04h", addr, expected, read_data_o);
            end
        end
    endtask

    initial begin
        clk = 1'b0;
        rst_n = 1'b0;
        address = 16'b0;
        mem_data = 16'b0;
        mem_write_i = 1'b0;
        mem_read_i = 1'b0;
        #10;

        $display("Testing Data Memory Unit...");
        #20;
        rst_n = 1;
        #10;

        // Basic Read and Write Test
        // Inputs: Addr, Data
        $display("Test 1: Basic Write...");
        write_dmem(16'h0000, 16'hABCD);

        $display("Test 2: Basic Read...");
        read_dmem(16'h0000, 16'hABCD);

        $display("TESTS FINISHED");
        #10;
        $finish;
    end

endmodule
