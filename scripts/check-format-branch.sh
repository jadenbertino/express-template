#!/bin/bash

# Usage: ./check-format-branch.sh [--write] <base_branch_name>
#
# Options:
#   --write            Apply formatting changes to the files (optional)
#
# Arguments:
#   <base_branch_name> Name of the base branch to compare against (required)
#
# This script checks the formatting of JavaScript and TypeScript files that have been
# changed in the current branch compared to a specified base branch. It identifies
# changed .js, .ts, .jsx, and .tsx files, and if any are found, it passes them to the
# check-format-files.sh script for formatting verification. If the --write flag is
# provided, it will be passed to check-format-files.sh to apply formatting changes.

# Initialize variables
write_flag=""
base_branch=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --write)
            write_flag="--write"
            shift
            ;;
        *)
            if [ -z "$base_branch" ]; then
                base_branch=$1
            else
                echo "Error: Unexpected argument '$1'"
                echo "Usage: $0 [--write] <base_branch_name>"
                exit 1
            fi
            shift
            ;;
    esac
done

# Check if base branch name is provided
if [ -z "$base_branch" ]; then
    echo "Error: Base branch name is required."
    echo "Usage: $0 [--write] <base_branch_name>"
    exit 1
fi

# Get changed files
changed_files=$(git diff --name-only --diff-filter=ACMRT origin/$base_branch HEAD | grep '\.js\|\.ts\|\.jsx\|\.tsx$' | xargs)

# Check formatting
if [ -n "$changed_files" ]; then
    echo "Files to be checked:"
    echo "$changed_files"
    bash ./scripts/check-format-files.sh $write_flag $changed_files
else
    echo "No relevant files changed."
fi