#!/bin/bash
set -e

# Env Vars
bash ./docker/utils/validate_env.sh
. ./docker/config.sh
. ./env/.env.$ENVIRONMENT

# Build
docker run \
  -p 8080:8080 \
  -e ENVIRONMENT=$ENVIRONMENT \
  -e DOPPLER_TOKEN=$DOPPLER_TOKEN \
  $DOCKER_TAG