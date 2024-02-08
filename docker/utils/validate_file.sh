#!/bin/bash
set -e

# Validate if argument is provided
if [ -z "$1" ]; then
  echo "Error: No file provided to validate." >&2
  exit 1
fi

# Assign the argument to file_to_check
file_to_check=$1

# Check if the file exists
if [ -f "$file_to_check" ]; then
  echo "The file '$file_to_check' exists."
else
  echo "Error: The file '$file_to_check' does not exist." >&2
  exit 1
fi