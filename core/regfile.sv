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

    input logic regw_en_i,
    input logic [2:0] rd_addr_i,
    input logic [15:0] rd_data_i,

    input logic [2:0] rs1_addr_i,
    input logic [2:0] rs2_addr_i,

    output logic [15:0] rs1_data_o,
    output logic [15:0] rs2_data_o
);

// 8, 16-bit general purpose registers
reg [15:0] register [8];

always_ff @(posedge clk) begin
    if (!rst_n) begin
        for (int i = 0; i < 8; i++) begin
            register[i] <= 0;
        end

    end else if (regw_en_i && (rd_addr_i != 0)) begin
        register[rd_addr_i] <= rd_data_i;

        $display("Register %0d written with data %0d", rd_addr_i, rd_data_i);
    end
end

        
always_comb begin
    // Ensure x0 is hardwired to 0
    rs1_data_o = (rs1_addr_i == 0) ? 0 : register[rs1_addr_i];
    rs2_data_o = (rs2_addr_i == 0) ? 0 : register[rs2_addr_i];
end
        

endmodule
