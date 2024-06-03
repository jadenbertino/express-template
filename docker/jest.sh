rm -rf dist/__test__/

export ENVIRONMENT=testing
export GOOGLE_APPLICATION_CREDENTIALS=secret/GOOGLE_APPLICATION_CREDENTIALS.json
TEST_FILEPATH=$1
COMMAND="dotenv -e env/.env -- node --experimental-vm-modules node_modules/jest/bin/jest.js"

# Append the test file path if it is not empty
if [ -n "$TEST_FILEPATH" ]; then
  echo "Running test file: $TEST_FILEPATH"
  COMMAND="$COMMAND $TEST_FILEPATH"
fi

COMMAND="$COMMAND --passWithNoTests"

eval $COMMAND
