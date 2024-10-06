#!/bin/bash
set -e

# Load environment variables
sh ./docker/utils/validate_env.sh
. ./docker/config.sh
. ./env/.env.$ENVIRONMENT

# Pass all tests (and stop deploy script if any fail)
# npm run test

# Authenticate to the artifact registry
gcloud services enable artifactregistry.googleapis.com
gcloud auth configure-docker us-central1-docker.pkg.dev

# TODO: Comment out this line after the first run
gcloud artifacts repositories create $SERVICE_NAME --repository-format=docker --location=us-central1

# Push the image to the artifact registry
echo "Pushing: $DOCKER_TAG"
docker push $DOCKER_TAG
echo "Pushed: $DOCKER_TAG"