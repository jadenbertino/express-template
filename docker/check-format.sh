#!/bin/bash

# Function to check a file or directory
check_item() {
    local item="$1"
    echo "Checking: $item"
    output=$(npx @biomejs/biome format "$item" 2>&1)
    if echo "$output" | grep -q "error"; then
        echo "$output" >> "$error_log"
        return 1
    fi
    return 0
}

# If no arguments are provided, check the src directory
if [ $# -eq 0 ]; then
    echo "No arguments provided. Checking the src directory."
    items=("src")
else
    items=("$@")
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
        if ! check_item "$item"; then
            items_with_errors+=("$item")
        fi
    else
        echo "Warning: $item does not exist and will be skipped."
    fi
done

# Status Message
if [ ${#items_with_errors[@]} -gt 0 ]; then
    echo "Formatting issues were found in the following items:"
    cat "$error_log"
    rm "$error_log"
    echo "Items with formatting issues:"
    printf '%s\n' "${items_with_errors[@]}"
    exit 1
else
    echo "No formatting issues found."
    rm "$error_log"
    exit 0
fi