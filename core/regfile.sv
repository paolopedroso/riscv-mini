/*
 * Paolo Pedroso
 *
 * Apache 2.0 License
 *
 * Register File
 */

module regfile (
    input logic clk,
    input logic rst_n,

    input logic regw_en,
    input logic [2:0] rd_addr_in,
    input logic [2:0] rs1_addr_in,
    input logic [2:0] rs2_addr_in,

    input logic [15:0] rd_data_in,
    output logic [15:0] rs1_data_o,
    output logic [15:0] rs2_data_o
);

// 16, 16-bit general purpose registers
reg [15:0] register [8];

always_ff @(posedge clk) begin
    if (!rst_n) begin
        for (int i = 0; i < 8; i++) begin
            register[i] <= 0;
        end

    end else if (regw_en && (rd_addr_in != 0)) begin
        register[rd_addr_in] <= rd_data_in;

        $display("Register %0d written with data %0d", rd_addr_in, rd_data_in);
    end
end

        
always_comb begin
    // Ensure x0 is hardwired to 0
    rs1_data_o = (rs1_addr_in == 0) ? 0 : register[rs1_addr_in];
    rs2_data_o = (rs2_addr_in == 0) ? 0 : register[rs2_addr_in];
end
        

endmodule
