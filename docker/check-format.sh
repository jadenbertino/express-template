#!/bin/bash

# Run Biome format check
output=$(npx @biomejs/biome format src)

# Check if there are any formatting errors
if echo "$output" | grep -q "error"; then
  echo "Formatting issues found:"
  echo "$output"
  exit 1
else
  echo "No formatting issues found."
  exit 0
fi