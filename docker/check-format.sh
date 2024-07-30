#!/bin/bash

# If no files are provided, check all files in src
if [ $# -eq 0 ]; then
  files="src"
else
  files="$@"
fi

echo "Checking formatting for the following files:"
echo "$files"

# Run Biome format check
output=$(npx @biomejs/biome format $files --check)

# Check if there are any formatting errors
if echo "$output" | grep -q "Found [0-9]\+ error"; then
  echo "Formatting issues found:"
  echo "$output"
  exit 1
else
  echo "No formatting issues found."
  exit 0
fi