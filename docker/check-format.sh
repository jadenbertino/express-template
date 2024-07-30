#!/bin/bash

# Function to check a single file
check_file() {
    local file="$1"
    echo "Checking file: $file"
    output=$(npx @biomejs/biome format "$file" 2>&1)
    if echo "$output" | grep -q "error"; then
        echo "$output" >> "$error_log"
        return 1
    fi
    return 0
}

# If no files are provided, check all files in src
if [ $# -eq 0 ]; then
    echo "No files provided. Checking all files in src directory."
    files=("src")
else
    files=("$@")
fi

echo "Files to be checked:"
printf '%s\n' "${files[@]}"

# Create a temporary file for error logging
error_log=$(mktemp)

# Initialize counter and array for files with errors
total_files=0
files_with_errors=()

# Iterate through files
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        ((total_files++))
        if ! check_file "$file"; then
            files_with_errors+=("$file")
        fi
    else
        echo "Warning: $file is not a valid file and will be skipped."
    fi
done

# Status Message
echo "Total files checked: $total_files"
if [ ${#files_with_errors[@]} -gt 0 ]; then
    echo "Formatting issues were found in the following files:"
    cat "$error_log"
    rm "$error_log"
    echo "Files with formatting issues:"
    printf '%s\n' "${files_with_errors[@]}"
    exit 1
else
    echo "No formatting issues found."
    rm "$error_log"
    exit 0
fi