/*
 * Paolo Pedroso
 *
 * Apache 2.0 License
 *
 * Small Data Memory
 */

// alu_o = mem_addr
// rs2 = 
module dmem #(
    parameter int MEM_SIZE = 8192,
    parameter int ADDR_WIDTH = $clog2(MEM_SIZE) // Use 13 bits of address
) (
    input logic clk,
    input logic rst_n,

    input logic [15:0] address,
    input logic [15:0] mem_data,

    input logic mem_write_i, // From control signals
    input logic mem_read_i,  // From control signals

    output logic [15:0] read_data_o 

);

logic [ADDR_WIDTH-1:0] mem_addr;
reg [15:0] memory[0:MEM_SIZE-1];

// Properly truncate bits
assign mem_addr = address[ADDR_WIDTH-1:0];

always_ff @(posedge clk) begin
    if (!rst_n) begin
        read_data_o <= 16'b0;
        for (int i = 0; i < MEM_SIZE; i++) begin
            memory[i] = 16'b0;
        end
    // Synchronous write logic
    end else if (mem_write_i && (mem_addr < MEM_SIZE)) begin
        memory[mem_addr] <= mem_data;

    // Synchrounous read logic
    end else if (mem_read_i && (mem_addr < MEM_SIZE)) begin
        
        // Write Priotity (SHOULDNT HAPPEN)
        if (mem_write_i) begin
            memory[mem_addr] <= mem_data;


            $display("DMEM: WRITE AND READ BOTH ENABLED");
            $display("DMEM: CHECK PIPELINE");

        end else begin
            read_data_o <= memory[mem_addr];
        end

    // No read/write
    end else begin
        read_data_o <= 16'b0;
    end
end

endmodule
