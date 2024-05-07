#!/bin/bash

# Check if a file path is provided
if [ -z "$1" ]; then
  echo "Error: No file path specified." >&2
  exit 1
fi

# Check if the specified file exists
file_path=$1
if [ ! -f "$file_path" ]; then
  echo "Error: File $file_path not found." >&2
  exit 1
fi

echo "Reading from file: $file_path"

# Initialize azure_env_args with the prefix
azure_env_args="--set-env-vars "

# Read the specified file and build Azure environment variable arguments
while IFS='=' read -r key value || [ -n "$key" ]; do
  # Remove inline comments
  key=$(echo $key | sed 's/#.*//')
  value=$(echo $value | sed 's/#.*//')

  # Trim whitespace
  key=$(echo $key | xargs)
  value=$(echo $value | xargs)

  # Debug Line
  # echo "Reading key: $key, value: $value"

  # Skip empty lines and lines starting with #
  [[ -z "$key" || "$key" == \#* ]] && continue

  # Append each key-value pair to azure_env_args, separated by space
  azure_env_args+="$key=$value "

done < "$file_path"

# Trim the trailing space
azure_env_args=$(echo "$azure_env_args" | xargs)

# Export azure_env_args for use in parent script
echo "azure_env_args: $azure_env_args"
export azure_env_args
