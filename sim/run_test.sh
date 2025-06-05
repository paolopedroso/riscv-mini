#!/bin/bash
#
# Paolo Pedroso
#
# Apache2.0 License
#
# Test Shell Script
#

set -e

TB_FILE=$1
CORE_FILE=$2
if [ -z "$CORE_FILE" ] || [ -z "$TB_FILE" ]; then
    echo "Usage: $0 <tb_name.sv> <module_name.sv>"
    exit 1
fi

# Extract module name
TB_MODULE=$(basename "$TB_FILE" .sv)

# Clean previous build
if [ -d obj_dir ]; then
    echo "Cleaning previous build"
    rm -rf obj_dir
fi

echo "Initializing tests..."
echo "Skipping Warnings..."
verilator --cc --top-module "$TB_MODULE" ../core/riscv_pkg.sv ../core/"$CORE_FILE" "../tb/$TB_FILE" --timing --exe --main --Wno-fatal
make -C obj_dir -f V${TB_MODULE}.mk

echo "Simulating $1..."
./obj_dir/V${TB_MODULE}

echo "Simulation Complete"

