/*
 * Paolo Pedroso
 *
 * Apache 2.0 License
 *
 * Write Back Mux
 */

import riscv_pkg::*;

module wbmux (
    input logic [2:0] rd_addr_i,
    input logic [15:0] read_data_i,
    input logic [15:0] alu_data_i,
    input logic [15:0] pc_imm,
    input logic write_en,
    input logic wb_sel_i,

    output logic [15:0] write_data,
    output logic write_valid
);

wb_src_t wb_sel_i;
assign wb_sel = wb_src_t'(wb_sel_i);

always_comb begin
    case(wb_sel)
        WB_ALU: begin
            write_data = alu_data_i;
        end
        WB_MEM: begin
            write_data = read_data_i;
        end
        WB_PC_IMM: begin
            write_data = pc_imm;
        end
    endcase
end


endmodule
