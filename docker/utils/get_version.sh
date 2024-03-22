#!/bin/bash

# Check if file containing the version exists
SOURCE_FILE="changelog.md"
if [ ! -f "$SOURCE_FILE" ]; then
    echo "$SOURCE_FILE not found"
    exit 1
fi

# Read the first line of the $SOURCE_FILE file
VERSION=$(head -n 1 $SOURCE_FILE | tr -d ' ')

# Check if the version is not in the correct format (e.g., 2.1.0)
if ! [[ $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "The first line of $SOURCE_FILE does not contain a valid version"
    exit 1
fi

# Export the version
export VERSION
echo "Current version is $VERSION"