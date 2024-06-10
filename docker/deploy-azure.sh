#!/bin/bash
set -e

# Env vars
sh ./docker/utils/validate_env.sh
. ./docker/config.sh
. ./env/.env.$ENVIRONMENT

# Pass all tests (and stop deploy script if any fail)
npm run jest

# Push Docker Image To Registry
echo "Pushing docker image $DOCKER_TAG"
az acr login --name ossauswest3
docker push $DOCKER_TAG

# Deploy Image From Registry To Azure Container App
echo "Updating container app"
az containerapp update \
  --name $SERVICE_NAME-$ENVIRONMENT \
  --resource-group $ENVIRONMENT \
  --image $DOCKER_TAG \
  --set-env-vars DOPPLER_TOKEN=$DOPPLER_TOKEN ENVIRONMENT=$ENVIRONMENT REVISION_TIMESTAMP=$(date +%s)