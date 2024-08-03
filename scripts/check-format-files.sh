#!/bin/bash

# Usage:
# ./check-format-files.sh [--write] [file1 file2 file3 ...]
#
# Options:
#   --write    Apply formatting changes to the files (optional)
#
# Arguments:
#   file1, file2, file3, ...   Files or directories to check (optional)
#
# If no files or directories are specified, the script will check the current directory ('.') by default.
# 
# Examples:
#   Check formatting without making changes:
#     ./check-format-files.sh
#     ./check-format-files.sh file1.js file2.ts
#
#   Check and apply formatting changes:
#     ./check-format-files.sh --write
#     ./check-format-files.sh --write file1.js file2.ts

# This script checks the formatting of JavaScript and TypeScript files using Prettier.
# It can be used locally or as part of a GitHub Actions workflow to ensure code
# formatting standards are maintained. The script can check individual files,
# directories, or the current directory ('.') by default. With the --write option,
# it can also apply the formatting changes directly to the files.

# Function to check a file or directory
check_item() {
    local item="$1"
    local write_flag="$2"
    echo "Checking: $item"
    if [ "$write_flag" = true ]; then
        output=$(npx prettier --write "$item" 2>&1)
        exit_code=$?
    else
        output=$(npx prettier --check "$item" 2>&1)
        exit_code=$?
    fi
    if [ $exit_code -ne 0 ]; then
        echo "$output" >> "$error_log"
        return 1
    fi
    return 0
}

# Initialize variables
write_flag=false
items=()

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --write)
            write_flag=true
            shift
            ;;
        *)
            items+=("$1")
            shift
            ;;
    esac
done

# If no file arguments are provided, check the current directory
if [ ${#items[@]} -eq 0 ]; then
    echo "No file arguments provided. Checking the current directory."
    items=(".")
fi

echo "Items to be checked:"
printf '%s\n' "${items[@]}"

# Create a temporary file for error logging
error_log=$(mktemp)

# Initialize array for items with errors
items_with_errors=()

# Iterate through items
for item in "${items[@]}"; do
    if [ -e "$item" ]; then
        if ! check_item "$item" "$write_flag"; then
            items_with_errors+=("$item")
        fi
    else
        echo "Warning: $item does not exist and will be skipped."
    fi
done

# Status Message
if [ ${#items_with_errors[@]} -gt 0 ]; then
    echo "Code style issues found in the following items:"
    cat "$error_log"
    rm "$error_log"
    echo "Items with code style issues:"
    printf '%s\n' "${items_with_errors[@]}"
    exit 1
else
    echo "No code style issues found."
    rm "$error_log"
    exit 0
fi