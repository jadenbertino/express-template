#!/bin/bash
set -e

# Load environment variables
sh ./docker/utils/validate_env.sh
. ./docker/config.sh
. ./env/.env.$ENVIRONMENT

# Authenticate to the artifact registry
gcloud services enable artifactregistry.googleapis.com
gcloud auth configure-docker us-central1-docker.pkg.dev

# Deploy from artifact registry to cloud run
CONTAINER_NAME=$SERVICE_NAME-$ENVIRONMENT
echo "Deploying container app: $CONTAINER_NAME"
gcloud run deploy $CONTAINER_NAME \
  --image $DOCKER_TAG \
  --region us-central1 \
  --platform managed \
  --set-env-vars ENVIRONMENT=$ENVIRONMENT \
  --set-env-vars DOPPLER_TOKEN=$DOPPLER_TOKEN