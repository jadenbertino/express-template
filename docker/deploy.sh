#!/bin/bash
set -e

bash ./docker/az/deploy-image.sh
bash ./docker/az/deploy-container.sh