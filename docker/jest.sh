rm -rf dist/__test__/

export ENVIRONMENT=testing
export GOOGLE_APPLICATION_CREDENTIALS=secret/GOOGLE_APPLICATION_CREDENTIALS.json
dotenv -e env/.env -- node --experimental-vm-modules node_modules/jest/bin/jest.js