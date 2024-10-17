. ./docker/utils/get_version.sh

export SERVICE_NAME='PLZ-SET-SERVICE-NAME'
export GCP_DOCKER_TAG=us-central1-docker.pkg.dev/ai-video-creation/$SERVICE_NAME/$VERSION
export AZ_DOCKER_TAG=ossauswest3.azurecr.io/$SERVICE_NAME:$VERSION
export DOCKER_TAG='PLZ-SET-DOCKER-TAG'

# TODO: Delete this once SERVICE_NAME is set
# Check if the service name has been set properly
if [ "$SERVICE_NAME" = "PLZ-SET-SERVICE-NAME" ]; then
    echo "Error: SERVICE_NAME is set to the default vaule. Please update it in docker/config.sh before continuing."
    exit 1
fi

# TODO: Set DOCKER_TAG to AZ_DOCKER_TAG or GCP_DOCKER_TAG
# Delete this once DOCKER_TAG is set
# Check if the docker tag has been set properly
if [ "$DOCKER_TAG" = "PLZ-SET-DOCKER-TAG" ]; then
    echo "Error: DOCKER_TAG is set to the default vaule. Please update it in docker/config.sh before continuing."
    exit 1
fi