#!/bin/bash

# Function to check a single file
check_file() {
    local file="$1"
    echo "Checking file: $file"
    output=$(npx @biomejs/biome format "$file"2>&1)
    if echo "$output" | grep -q "error"; then
        echo "$output" >> "$error_log"
        return 1
    fi
    return 0
}

# If no files are provided, check all files in src
if [ $# -eq 0 ]; then
    echo "No files provided. Checking all files in src directory."
    files="src"
else
    files="$@"
fi

echo "Files to be checked:"
echo "$files"

# Create a temporary file for error logging
error_log=$(mktemp)

# Initialize counters
total_files=0
files_with_errors=0

# Iterate through files
for file in $files; do
    if [ -f "$file" ]; then
        total_files=$((total_files + 1))
        if ! check_file "$file"; then
            files_with_errors=$((files_with_errors + 1))
        fi
    else
        echo "Warning: $file is not a valid file and will be skipped."
    fi
done

# Print summary and errors
echo "Format check complete."
echo "Total files checked: $total_files"
echo "Files with formatting issues: $files_with_errors"

if [ $files_with_errors -gt 0 ]; then
    echo "Formatting issues were found in the following files:"
    cat "$error_log"
    rm "$error_log"
    exit 1
else
    echo "No formatting issues found."
    rm "$error_log"
    exit 0
fi