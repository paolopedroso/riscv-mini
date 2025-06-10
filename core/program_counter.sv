/*
 * Paolo Pedroso
 *
 * Apache 2.0 License
 *
 * Program Counter
 */

module program_counter (
    input logic clk,
    input logic rst_n,

    input logic branch_en,
    input logic jal_en,
    input logic jalr_en,
    input logic [15:0] imm_data_i,
    input logic [15:0] alu_data_i,
    input logic stall_en_i,

    input logic [15:0] pc_i,
    output logic [15:0] pc_o

);

logic [15:0] pc_next;

always_comb begin
    if (jal_en) begin
        pc_next = pc_i + imm_data_i;
    end else if (jalr_en) begin
        pc_next = alu_data_i;
    end else if (branch_en) begin
        pc_next = pc_i + imm_data_i;
    end else begin
        pc_next = pc_i + 16'd4;
    end
end

always_ff @(posedge clk) begin
    if (!rst_n) begin
        pc_o <= 16'd0;
    end else if (!stall_en_i) begin
        pc_o <= pc_next;
    end
end

endmodule
