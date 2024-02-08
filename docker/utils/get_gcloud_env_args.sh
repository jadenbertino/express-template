#!/bin/bash
set -e

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

# Initialize gcloud_env_args
gcloud_env_args=""

# Read the specified file and build GCloud environment variable arguments
while IFS='=' read -r key value || [ -n "$key" ]; do
  # Debug Line
  echo "Reading key: $key, value: $value"

  # Skip empty lines and lines starting with #
  [[ -z "$key" || "$key" == \#* ]] && continue

  # Append each key-value pair to gcloud_env_args
  gcloud_env_args+="--set-env-vars $key=$value "
done < "$file_path"

# Export gcloud_env_args for use in parent script
export gcloud_env_args