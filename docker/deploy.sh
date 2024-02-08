#!/bin/bash
set -e

# Load environment variables
sh ./docker/utils/validate_env.sh
. ./docker/config.sh
# if you only have a single .env file then change the line below
env_file=./env/.env.$ENVIRONMENT
. ./docker/utils/get_gcloud_env_args.sh $env_file
echo "env args: $gcloud_env_args"

# Authenticate to the artifact registry
gcloud auth configure-docker us-central1-docker.pkg.dev
# gcloud artifacts repositories create $SERVICE_NAME --repository-format=docker --location=us-central1

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