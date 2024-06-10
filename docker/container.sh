#!/bin/bash
set -e

# Env Vars
bash ./docker/utils/validate_env.sh
. ./docker/config.sh
env_file=./env/.env
# If you have multiple .env files then do ./env/.env.$ENVIRONMENT

# Build
docker run \
  -p 8080:8080 \
  -e ENVIRONMENT=$ENVIRONMENT \
  --env-file $env_file \
  $DOCKER_TAG