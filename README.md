# RISC-V MINI
A small 3-stage RV16I RISC-V Processor

## Testing
Prerequisites
- WSL2
- dos2unix
- Verilator (ver 5.0+)

```wsl
dos2unix ./run_test.sh
./run_test <testbench.sv> <module.sv>

# Example
# ./run_test tb_alu.sv alu.sv
```
