#!/bin/bash
set -e 

# Verify .npmrc file exists
npmrc_file_path="./.npmrc"
bash ./docker/utils/validate_file.sh $npmrc_file_path

# Compile Typescript
echo "Compiling Typescript"
rm -rf ./dist
tsc

# Dockerize
. ./docker/config.sh
docker build \
  -t $DOCKER_TAG \
  --secret id=npmrc,src=$npmrc_file_path \
  .