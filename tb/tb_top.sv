/*
 *  Paolo Pedroso
 *
 *  Apache 2.0 License
 *
 *  Top Testbench
 */

module tb_top;

// Inputs //
logic clk;
logic rst_n;

top dut(.*);

// clk generation

// 200 MHZ
initial clk = 0;
int cycle;
always #5 clk = ~clk;

function automatic int get_instruction_count();
    int count = 0;
    for (int i = 0; i < dut.instr_mem_inst.MEM_SIZE; i++) begin
        if (dut.instr_mem_inst.imem[i] != 16'h0000) begin
            count++;
        end else begin
            break;
        end
    end
    return count;
endfunction

function automatic int display_reg();
    for (int i = 0; i < 8; i++) begin
        $display("x%d: %d\n", i, dut.regfile_inst.register[i]);
    end
    $display("\n");
    return 0;
endfunction

function automatic int get_instr();
    if (!$isunknown(dut.instr_mem_inst.imem)) begin
        for (int i = 0; i < dut.instr_mem_inst.MEM_SIZE; i++) begin
            if (dut.instr_mem_inst.imem[i] != 16'h0000) begin
                $display("Instruction %d: %b", i, dut.instr_mem_inst.imem[i]);
            end
        end
        $display("\n");
        return 0;
    end else begin
        $error("/////////// Instruction Memory not properly initialized! ///////////");
        return 1;
    end
endfunction


initial begin
    $display("\nStarting Top Testbench...\n");
    rst_n = 0;
    repeat(3) @(posedge clk);
    rst_n = 1;
    $display("Releasing reset...\n");
    cycle = 0;
    repeat(get_instruction_count()) begin
        @(posedge clk);
        $display("PC: %d, Instruction: %b, Cycle: %d", dut.pc_o, dut.instr_i, cycle);
        cycle++;
    end
    $display("\nEnd of instructions...\n");
    repeat(3) @(posedge clk);
    $display("\nClearing pipeline data...\n");
    #20;

    $display("/////////// Displaying Instructions ///////////");
    get_instr();

    $display("/////////// Displaying Final Register Values ///////////");
    display_reg();

    $display("Testbench Completed");
    $finish;
end

endmodule
