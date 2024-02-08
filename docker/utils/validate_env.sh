#!/bin/bash
set -e

# Check if ENVIRONMENT variable is set
if [ -z "$ENVIRONMENT" ]; then
  echo "Error: ENVIRONMENT variable is not set."
  exit 1
fi

# Validate that ENVIRONMENT is 'production', 'staging', 'testing', or 'development'
case "$ENVIRONMENT" in
  "production"|"staging"|"testing"|"development")
    # echo "ENVIRONMENT is set to a valid value: $ENVIRONMENT"
    ;;
  *)
    echo "Error: ENVIRONMENT is set to an invalid value: $ENVIRONMENT"
    echo "Valid values are: production, staging, testing, development"
    exit 1
    ;;
esac