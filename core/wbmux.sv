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
    input logic [15:0] return_addr_i,
    input logic write_en_i,
    input logic [1:0] wb_sel_i,

    output logic [15:0] write_data_o,
    output logic write_valid_o
);

wb_src_t wb_sel;
assign wb_sel = wb_src_t'(wb_sel_i);

always_comb begin
    case(wb_sel)
        WB_ALU: begin
            write_data_o = alu_data_i;
            // write_en_i = 1'b1;
        end
        WB_MEM: begin
            write_data_o = read_data_i;
        end
        WB_PC_PLUS_FOUR: begin // JAL/JALR
            write_data_o = return_addr_i;
        end
        default: begin
            write_data_o = 16'b0;
            write_valid_o = 1'b0;
        end
    endcase
end

assign write_valid_o = write_en_i && (rd_addr_i != 3'b0);

endmodule
