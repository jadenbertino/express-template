#!/bin/bash
set -e

# Env vars
sh ./docker/utils/validate_env.sh
. ./docker/utils/get_version.sh
. ./docker/config.sh
. ./env/.env.$ENVIRONMENT

# Deploy Image From Registry To Azure Container App
CONTAINER_APP_NAME=$SERVICE_NAME-$ENVIRONMENT
echo "Updating container app: $CONTAINER_APP_NAME"
# https://learn.microsoft.com/en-us/cli/azure/containerapp?view=azure-cli-latest#az-containerapp-update
az containerapp update \
  --name $CONTAINER_APP_NAME \
  --resource-group $ENVIRONMENT \
  --image $DOCKER_TAG \
  --set-env-vars DOPPLER_TOKEN=$DOPPLER_TOKEN ENVIRONMENT=$ENVIRONMENT VERSION=$VERSION REVISION_TIMESTAMP=$(date +%s)