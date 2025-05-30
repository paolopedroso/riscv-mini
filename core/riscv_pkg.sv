package riscv_pkg;

typedef enum logic [2:0] { 
    R_OP = 3'b000,
    I_OP = 3'b001,
    L_OP = 3'b010,
    S_OP = 3'b011,
    B_OP = 3'b100,
    J_OP = 3'b101
} opcode_t;

typedef enum logic [1:0] { 
    WB_ALU = 2'b00,
    WB_MEM = 2'b01,
    WB_PC_IMM = 2'b10
} wb_src_t;

typedef enum logic [3:0] { 
    ADD = 4'b0000,
    SUB = 4'b0001,
    INV = 4'b0010,
    SLL = 4'b0011,
    SLR = 4'b0100,
    AND = 4'b0101,
    OR  = 4'b0110,
    SLT = 4'b0111
} alu_src_t;

endpackage