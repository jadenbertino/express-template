#!/bin/bash
set -e

# Env vars
sh ./docker/utils/validate_env.sh
. ./docker/config.sh
. ./env/.env.$ENVIRONMENT

# Pass all tests (and stop deploy script if any fail)
# npm run test

# Push Docker Image To Registry
echo "Pushing: $AZ_DOCKER_TAG"
az acr login --name ossauswest3
docker push $AZ_DOCKER_TAG
echo "Pushed: $AZ_DOCKER_TAG"