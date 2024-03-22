#!/bin/bash
set -e 

# Verify that package.json files are in sync
npm install

# Compile Typescript
echo "Compiling Typescript"
rm -rf ./dist
tsc

# Dockerize
npmrc_file_path="$HOME/.npmrc"
. ./docker/config.sh
docker build \
  -t $DOCKER_TAG \
  --secret id=npmrc,src=$npmrc_file_path \
  .
