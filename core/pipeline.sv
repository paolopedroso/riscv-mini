/*
 *  Paolo Pedroso
 *
 *  Apache 2.0 License
 *
 *  3 Stage Pipeline
 */

// Instruction Fetch -- Decode Execute Register
module if_de_reg (
    input logic clk,
    input logic rst_n,
    input logic flush,

    input logic [15:0] pc_i,
    input logic [15:0] instr_i,
    input logic stall,

    output logic [15:0] pc_o,
    output logic [15:0] instr_o
);

always_ff @(posedge clk) begin
    if (!rst_n || flush) begin
        pc_o <= 16'b0;
        instr_o <= 16'b0;
    end else if (!stall) begin
        pc_o <= pc_i;
        instr_o <= instr_i;
    end
end

endmodule

// Decode Execute -- Memory Writeback Register
module de_mw_reg (
    input logic clk,
    input logic rst_n,
    input logic flush,

    input logic [15:0] pc_i,
    output logic [15:0] pc_o,

    // Decode Execute Stage (DE)
    // control.sv signals
    // input logic [2:0] de_mw_op;
    input logic [1:0] de_mw_wb_sel_i,
    input logic de_mw_mem_write_en_i,
    input logic de_mw_mem_read_en_i,
    // input logic de_mw_imm_en_i,
    // input logic de_mw_jal_en_i,
    // input logic de_mw_jalr_en_i,

    output logic [1:0] de_mw_wb_sel_o,
    output logic de_mw_mem_write_en_o,
    output logic de_mw_mem_read_en_o,
    // output logic de_mw_imm_en_o,
    // output logic de_mw_jal_en_o,
    // output logic de_mw_jalr_en_o,

    // regfile.sv signals
    input logic [15:0] de_mw_rd_data_i,
    output logic [15:0] de_mw_rd_data_o,

    // alu.sv signals
    input logic [15:0] de_mw_alu_data_i,
    output logic [15:0] de_mw_alu_data_o

);

always_ff @(posedge clk) begin
    if (!rst_n || flush) begin
        pc_o <= '0;
        de_mw_wb_sel_o <= '0;
        de_mw_mem_write_en_o <= '0;
        de_mw_mem_read_en_o <= '0;
        // de_mw_imm_en_o <= '0;
        // de_mw_jal_en_o <= '0;
        // de_mw_jalr_en_o <= '0;
        de_mw_rd_data_o <= '0;
        de_mw_alu_data_o <= '0;
    end else begin
        pc_o <= pc_i;
        de_mw_wb_sel_o <= de_mw_wb_sel_i;
        de_mw_mem_write_en_o <= de_mw_mem_write_en_i; 
        de_mw_mem_read_en_o <= de_mw_mem_read_en_i;
        // de_mw_imm_en_o <= de_mw_imm_en_o;
        // de_mw_jal_en_o <= de_mw_jal_en_o;
        // de_mw_jalr_en_o <= de_mw_jalr_en_o;
        de_mw_rd_data_o <= de_mw_rd_data_i;
        de_mw_alu_data_o <= de_mw_alu_data_i;
    end
end

// pc_i;
// de_mw_wb_sel_i;
// de_mw_mem_write_en_i;
// de_mw_mem_read_en_i;
// de_mw_imm_en_i;
// de_mw_jal_en_i;
// de_mw_jalr_en_i;
// de_mw_rd_data_i;
// de_mw_alu_data_i;


endmodule

