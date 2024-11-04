#!/bin/bash
set -e 

# Verify that package.json files are in sync
npm install

# Compile Typescript
echo "Compiling Typescript"
rm -rf ./dist
npx tsc
npx tsc-alias

# Set Build Config
. ./docker/config.sh
if [ -z "$NPMRC_FILE_PATH" ]; then
  NPMRC_FILE_PATH="$HOME/.npmrc"
fi

# Build Docker Image
echo "Building image: $DOCKER_TAG"
docker build \
  -t $DOCKER_TAG \
  --secret id=npmrc,src=$NPMRC_FILE_PATH \
  .
echo ""
echo "Built image: $DOCKER_TAG"
