/*
 * Paolo Pedroso
 *
 * Apache 2.0 License
 *
 * Fowarding Unit
 */

module forward_unit(
    input logic [2:0] de_mw_rd_addr_i,
    input logic write_en_i,
    input logic [2:0] rs1_addr_i,
    input logic [2:0] rs2_addr_i,

    output logic [1:0] forward_a_o,
    output logic [1:0] forward_b_o

);

always_comb begin
    forward_a_o = 2'b0;
    forward_b_o = 2'b0;
    if (de_mw_rd_addr_i != 0) begin
        if (write_en_i && (de_mw_rd_addr_i == rs1_addr_i)) begin
            forward_a_o = 2'b10;
        end
    end

    if (de_mw_rd_addr_i != 0) begin
        if (write_en_i && (de_mw_rd_addr_i == rs2_addr_i)) begin
            forward_b_o = 2'b10;
        end
    end
end

endmodule
