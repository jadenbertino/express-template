. ./docker/utils/get_version.sh

export SERVICE_NAME=PLZ-SET-SERVICE-NAME

# TODO: Delete this once SERVICE_NAME is set
# Check if the service name has been set properly
if [ "$SERVICE_NAME" = "PLZ-SET-SERVICE-NAME" ]; then
    echo "Error: SERVICE_NAME is set to the default vaule. Please update it in docker/config.sh before continuing."
    exit 1
fi

# for gcloud
export DOCKER_TAG=us-central1-docker.pkg.dev/ai-video-creation/$SERVICE_NAME/$VERSION

# for azure
export DOCKER_TAG=ossauswest3.azurecr.io/$SERVICE_NAME:$VERSION