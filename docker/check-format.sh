#!/bin/bash

# Run Biome format check
output=$(npx @biomejs/biome format src)

# Check if there are any formatting issues
if echo "$output" | grep -q "Formatter would have printed the following content:"; then
  echo "Formatting issues found:"
  echo "$output"
  exit 1
else
  echo "No formatting issues found."
  exit 0
fi