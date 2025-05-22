## Main Objective

### Stage 1: Fetch

Use the Program Counter (PC) to fetch the instruction from instruction memory
Increment PC to point to the next instruction
Pass the instruction to the next stage via a pipeline register

### Stage 2: Decode/Execute

Decode the instruction (opcode, registers, immediate values)
Read register values from the register file
Perform ALU operations (arithmetic, logic, shifts)
Calculate branch/jump target addresses
Update PC for control flow instructions (branches/jumps)

### Stage 3: Memory/Writeback

Access data memory for load/store instructions
Write results back to the register file (from ALU or memory)


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