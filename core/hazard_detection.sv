/*
 *  Paolo Pedroso
 *
 *  Apache 2.0 License
 *
 *  Hazard Detection Unit
 */

module hazard_detection(
    // DE
    input logic [2:0] rd_addr_i,
    input logic jal_en_i,
    input logic jalr_en_i,
    input logic branch_en_i,

    // WB
    input logic [2:0] rs1_addr_i,
    input logic [2:0] rs2_addr_i,
    input logic mem_read_i,

    output logic if_de_flush_o,
    output logic de_mw_flush_o,
    output logic stall_o

);

always_comb begin
    stall_o = 1'b0;
    if_de_flush_o = 1'b0;
    de_mw_flush_o = 1'b0;

    // Load Use Hazard
    if ((rd_addr_i == rs1_addr_i || rd_addr_i == rs2_addr_i) && rd_addr_i != 0) begin
        stall_o = 1'b1;
        if_de_flush_o = 1'b1;
    
    // Control Hazard
    end else if (jalr_en_i || jal_en_i || branch_en_i) begin
        stall_o = 1'b0;
        de_mw_flush_o = 1'b1;
    end
end

endmodule
