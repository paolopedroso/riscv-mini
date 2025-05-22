# RISC-V MINI
A small 3-stage RV16I RISC-V Processor

## Testing

`verilator <test.sv> <tb.sv> <flags>`

Flags to use and examples
```bash
# Define var for conditional code
-D<var>

# `ifdef var
# always_comb begin
#   if (var) begin
#       $display("Var: %0d not valid", var);
#   end
# end
# `endef

# Enable assertions
--assert

# assert($onehot0({r_en, i_en, l_en, s_en, b_en, j_en}))
#         else $error("Multiple instruction types enabled simultaneously");

# assert(op_in <= 3'b101)
#     else $error("Invalid opcode: %b", op_in);

# Checks for warnings, syntax, etc.
--lint-only 

# See all warnings
-Wall

# Use timing
--timing
--no-timing

# Don't exit on warnings
-Wno-fatal
```