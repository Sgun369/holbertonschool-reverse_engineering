#!/bin/bash

# Check if the correct number of arguments is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <ELF file>"
    exit 1
fi

file_name="$1"

# Check if the file exists
if [ ! -f "$file_name" ]; then
    echo "Error: File '$file_name' does not exist."
    exit 1
fi

# Check if the file is an ELF file
if ! file "$file_name" | grep -q "ELF"; then
    echo "Error: '$file_name' is not a valid ELF file."
    exit 1
fi

# Extract ELF header information
magic_number=$(xxd -p -l 4 "$file_name" | tr -d '\n')
class=$(readelf -h "$file_name" | grep "Class:" | awk '{print $2, $3}')
byte_order=$(readelf -h "$file_name" | grep "Data:" | awk '{print $2, $3}')
entry_point_address=$(readelf -h "$file_name" | grep "Entry point address:" | awk '{print $4}')

# Source messages.sh to use its functions
source ./messages.sh

# Call the function to display extracted information
display_elf_header_info
