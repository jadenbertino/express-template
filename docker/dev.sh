export ENVIRONMENT=staging

# npm i -g dotenv-cli
# https://www.npmjs.com/package/dotenv-cli
# Avoid loading .env file from source code because that would you require you to copy the .env file into the docker image
dotenv -e env/.env -- ts-node src/index.ts