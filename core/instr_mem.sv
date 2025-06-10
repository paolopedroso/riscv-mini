/*
 * Paolo Pedroso
 *
 * Apache 2.0 License
 *
 * Instruction Memory
 */

module instr_mem #(
    parameter int DATA_WIDTH = 16,
    parameter int MEM_SIZE = 1024, // 64 Instructions
    parameter int ADDR_WIDTH = $clog2(MEM_SIZE)
)(
    input logic [15:0] addr_i,
    output logic [15:0] instr_o
);

import riscv_pkg::*;

// 64, 16 bit, instructions
logic [DATA_WIDTH-1:0] imem[MEM_SIZE-1:0];
logic [ADDR_WIDTH-1:0] word_addr;
assign word_addr = addr_i[ADDR_WIDTH+1:2];

always_comb begin
    if (word_addr < MEM_SIZE) begin
        instr_o = imem[word_addr];
    end else begin
        instr_o = 16'h0000;
        $display("IMEM: PC OUT OF RANGE - addr: %h, word_addr: %h", addr_i, word_addr);
    end
end

initial begin
    for (int i = 0; i < MEM_SIZE; i++) begin
        imem[i] = 0;
    end

    // Simple Test //
    $display("=== Simple Test ===");
    imem[0]  = 16'b00011_00_010_001_001;  // I-type: ADDI x1, x2, 3
    imem[1]  = 16'b0000_010_001_100_000;  // R-type: ADD x4, x1, x2  
    imem[2]  = 16'b00000_10_001_011_010;  // L-type: LW x3, 0(x1)
    imem[3]  = 16'b00000_10_001_010_011;  // S-type: SW x2, 0(x1)

end

endmodule
