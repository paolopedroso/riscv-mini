# RISC-V MINI (In Dev)
A small 3-stage RV16I RISC-V Processor

## Architecture
![3 stage risc diagram](https://github.com/user-attachments/assets/74d77f71-d339-403a-ac02-8d86979679a4)

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
