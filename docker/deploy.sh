#!/bin/bash
set -e

# Load environment variables
sh ./docker/utils/validate_env.sh
. ./docker/config.sh
# if you have multiple .env files then do .env.$ENVIRONMENT
env_file=./env/.env
. ./docker/utils/get_gcloud_env_args.sh $env_file
echo "env args: $gcloud_env_args"

# Authenticate to the artifact registry
gcloud services enable artifactregistry.googleapis.com
gcloud auth configure-docker us-central1-docker.pkg.dev

# TODO: delete this line after the first run
gcloud artifacts repositories create $SERVICE_NAME --repository-format=docker --location=us-central1

# Push the image to the artifact registry
echo "Deploying $DOCKER_TAG docker image for $ENVIRONMENT environment"
docker push $DOCKER_TAG

# Deploy from artifact registry to cloud run
gcloud run deploy $SERVICE_NAME-$ENVIRONMENT \
  --image $DOCKER_TAG \
  --region us-central1 \
  --platform managed \
  --set-env-vars ENVIRONMENT=$ENVIRONMENT \
  $gcloud_env_args