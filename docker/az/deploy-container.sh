#!/bin/bash
set -e

# Env vars
sh ./docker/utils/validate_env.sh
. ./docker/config.sh
. ./env/.env.$ENVIRONMENT

# Deploy Image From Registry To Azure Container App
echo "Updating container app"
az containerapp update \
  --name $SERVICE_NAME-$ENVIRONMENT \
  --resource-group $ENVIRONMENT \
  --image $DOCKER_TAG \
  --set-env-vars DOPPLER_TOKEN=$DOPPLER_TOKEN ENVIRONMENT=$ENVIRONMENT REVISION_TIMESTAMP=$(date +%s)