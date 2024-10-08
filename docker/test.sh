#!/bin/bash
set -e

# set ENVIRONMENT to staging if undefined
if [ -z "$ENVIRONMENT" ]; then
  export ENVIRONMENT=staging
fi

# Load env vars
. ./docker/utils/validate_env.sh
. env/.env.$ENVIRONMENT
export DOPPLER_TOKEN=$DOPPLER_TOKEN
. ./docker/utils/get_version.sh
export VERSION=$VERSION

# overwrite environment variable
export ENVIRONMENT=testing

# Run Tests
rm -rf dist/__test__/
COMMAND="doppler run -- node --experimental-vm-modules node_modules/jest/bin/jest.js"
TEST_FILEPATH=$1
if [ -n "$TEST_FILEPATH" ]; then
  echo "Running test file: src/__test__/$TEST_FILEPATH"
  COMMAND="$COMMAND src/__test__/$TEST_FILEPATH"
fi

eval $COMMAND