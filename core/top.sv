/*
 * Paolo Pedroso
 *
 * Apache 2.0 License
 *
 * RV16I 3-stage RISC-V Processor
 */

// import riscv_pkg::*;

module top (
    input logic clk,
    input logic rst_n
);

// Instruction Fetch Stage (IF) //

logic [15:0] pc_o;
logic [15:0] if_de_pc;
logic [15:0] instr_i;
logic [15:0] if_de_instr;

// Decode Execute Stage (DE) //

logic [15:0] de_mw_instr;
logic [2:0] opcode;
logic [2:0] rs1_addr;
logic [2:0] rs2_addr;
logic [3:0] func4;
logic [1:0] func2;
logic [15:0] imm_data;
logic [1:0] de_mw_wb_sel;
logic de_mw_mem_write;
logic de_mw_mem_read;
logic imm_en;
logic jal_en;
logic jalr_en;
logic branch_en;
logic de_mw_jal_en;
logic if_de_flush;
logic de_mw_flush;
logic stall;
logic [2:0] rd_addr;
logic [15:0] rs1_data;
logic [15:0] rs2_data;
logic [15:0] alu_data;
logic [15:0] de_mw_alu_data;

// MEM WB stage (MW) //

logic mem_write;
logic mem_read;
logic [15:0] read_data;
logic [15:0] de_mw_pc;
logic [15:0] de_mw_address;
logic [15:0] de_mw_rs2_data;
logic [2:0] de_mw_rd_addr;
logic de_mw_write_en;
logic [1:0] wb_sel;
logic write_en;
logic write_valid;
logic [15:0] write_data;


instr_mem instr_mem_inst(
    .addr_i(pc_o),
    .instr_o(instr_i)
);

program_counter program_counter_inst(
    .clk(clk),
    .rst_n(rst_n),
    .branch_en(branch_en),
    .jal_en(jal_en),
    .jalr_en(jalr_en),
    .imm_data_i(imm_data),
    .alu_data_i(alu_data),
    .stall_en_i(stall),
    .pc_i(pc_o),
    .pc_o(pc_o)
);

// IF/DE REGISTER //

always_ff @(posedge clk) begin
    if (!rst_n || if_de_flush) begin
        if_de_pc <= '0;
        if_de_instr <= '0;
    end else if (!stall) begin
        if_de_pc <= pc_o;
        if_de_instr <= instr_i;
    end
end


decode decode_inst(
    .instr(if_de_instr),
    .opcode_o(opcode),
    .rs1_addr_o(rs1_addr),
    .rd_addr_o(rd_addr),
    .rs2_addr_o(rs2_addr),
    .func4_o(func4),
    .func2_o(func2),
    .imm_data_o(imm_data)
);

control control_inst(
    .op_i(opcode),
    .func2_i(func2),
    .rs1_data_i(rs1_data),
    .rs2_data_i(rs2_data),
    .wb_sel_o(wb_sel),
    .mem_write_o(mem_write),
    .mem_read_o(mem_read),
    .imm_en_o(imm_en),
    .write_en_o(write_en),
    .jal_en_o(jal_en),
    .jalr_en_o(jalr_en),
    .branch_en_o(branch_en)
);

hazard_detection hazard_detection_inst(
    .rd_addr_i(rd_addr),
    .jal_en_i(jal_en),
    .jalr_en_i(jalr_en),
    .branch_en_i(branch_en),
    .rs1_addr_i(rs1_addr),
    .rs2_addr_i(rs2_addr),
    .mem_read_i(mem_read),

    .if_de_flush_o(if_de_flush),
    .de_mw_flush_o(de_mw_flush),
    
    .stall_o(stall)
);

regfile regfile_inst(
    .clk(clk),
    .rst_n(rst_n),
    .regw_en_i(write_valid),
    .rd_addr_i(de_mw_rd_addr),
    .rd_data_i(write_data),
    .rs1_addr_i(rs1_addr),
    .rs2_addr_i(rs2_addr),
    .rs1_data_o(rs1_data),
    .rs2_data_o(rs2_data)
);

logic [1:0] forward_a;
logic [1:0] forward_b;
logic [15:0] alu_rs1_data;
logic [15:0] alu_rs2_data;

forward_unit forward_unit_inst(
    .de_mw_rd_addr_i(de_mw_rd_addr),
    .write_en_i(write_en),
    .rs1_addr_i(rs1_addr),
    .rs2_addr_i(rs2_addr),
    .forward_a_o(forward_a),
    .forward_b_o(forward_b)
);

always_comb begin
    case(forward_a)
        2'b00: alu_rs1_data = rs1_data;
        2'b10: alu_rs1_data = de_mw_alu_data;
    endcase
    default: alu_rs1_data = rs1_data;
end

always_comb begin
    case(forward_b)
        2'b00: alu_rs2_data = rs2_data;
        2'b10: alu_rs2_data = de_mw_alu_data;
        default: alu_rs2_data = rs2_data;
    endcase
end

alu alu_inst(
    .rs1_data_i(alu_rs1_data),
    .rs2_data_i(alu_rs2_data),
    .imm_data_i(imm_data),
    .imm_en_i(imm_en),
    .func4(func4),
    .jalr_en_i(jalr_en),
    .alu_data_o(alu_data)
);

// DE/MW REGISTER // 

always_ff @(posedge clk) begin
    if (!rst_n || de_mw_flush) begin
        de_mw_pc <= '0;
        de_mw_mem_write <= '0;
        de_mw_mem_read <= '0;
        de_mw_address <= '0;
        de_mw_rs2_data <= '0;
        de_mw_rd_addr <= '0;
        de_mw_wb_sel <= '0;
        de_mw_write_en <= '0;

    end else begin
        de_mw_pc <= if_de_pc;
        de_mw_mem_write <= mem_write;
        de_mw_mem_read <= mem_read;
        de_mw_address <= alu_data;
        de_mw_alu_data <= alu_data;
        de_mw_rs2_data <= rs2_data;
        de_mw_rd_addr <= rd_addr;
        de_mw_wb_sel <= wb_sel;
        de_mw_write_en <= write_en;

    end
end

dmem dmem_inst(
    .clk(clk),
    .rst_n(rst_n),
    .address(de_mw_address),
    .mem_data(de_mw_rs2_data),
    .mem_write_i(de_mw_mem_write),
    .mem_read_i(de_mw_mem_read),
    .read_data_o(read_data)
);

logic [15:0] return_addr;
assign return_addr = de_mw_pc + 16'd4;

wbmux wbmux_inst(
    .rd_addr_i(de_mw_rd_addr),
    .read_data_i(read_data),
    .alu_data_i(alu_data),
    .return_addr_i(return_addr),
    .write_en_i(de_mw_write_en),
    .wb_sel_i(de_mw_wb_sel),
    .write_data_o(write_data),
    .write_valid_o(write_valid)
);

endmodule
