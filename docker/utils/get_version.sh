#!/bin/bash

# Check if the changelog.md file exists
if [ ! -f "changelog.md" ]; then
    echo "changelog.md not found"
    exit 1
fi

# Read the first line of the changelog.md file
VERSION=$(head -n 1 changelog.md | tr -d ' ')

# Check if the version is not in the correct format (e.g., 2.1.0)
if ! [[ $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "The first line of changelog.md does not contain a valid version"
    exit 1
fi

# Export the version
export VERSION
echo "Current version is $VERSION"