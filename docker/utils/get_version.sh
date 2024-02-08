#!/bin/bash
set -e

# Verify that jq is installed
if ! command -v jq &> /dev/null
then
    echo "jq could not be found. Please install jq with 'sudo apt-get install jq' to continue."
    exit 1
fi

# Read version from package.json
VERSION=$(jq -r '.version' package.json 2> /dev/null)
if [ $? -ne 0 ]; then
    echo "Failed to extract version from package.json. Please check your package.json file."
    exit 1
fi
export VERSION
echo "Version set to $VERSION"