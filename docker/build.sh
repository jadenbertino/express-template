#!/bin/bash
set -e 

# Verify that package.json files are in sync
npm install

# Compile Typescript
echo "Compiling Typescript"
rm -rf ./dist
npx tsc
npx tsc-alias

# Dockerize
npmrc_file_path="$HOME/.npmrc"
. ./docker/config.sh
echo "Building image: $DOCKER_TAG"
docker build \
  -t $DOCKER_TAG \
  --secret id=npmrc,src=$npmrc_file_path \
  .
echo ""
echo "Built image: $DOCKER_TAG"