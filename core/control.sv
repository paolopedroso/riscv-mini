/*
 * Paolo Pedroso
 *
 *
 *
 */

module control (
    input logic [2:0] op_i,

    output mem_write_o,
    output mem_read_o
);

localparam L_OP = 3'b010; // L-type (load)
localparam S_OP = 3'b011; // S-type (store)

always_comb begin
    case(op[2:0])
        L_OP: begin
            mem_write_o = 1'b0;
            mem_read_o = 1'b1;
        end

        S_OP: begin
            mem_write_o = 1'b1;
            mem_read_o = 1'b0;
        end
    endcase
end

endmodule
