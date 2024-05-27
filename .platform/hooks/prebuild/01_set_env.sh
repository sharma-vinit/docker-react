#!/bin/bash

echo "Setting REACT_APP_IMAGE_TAG environment variable"
REACT_APP_IMAGE_TAG="build-${TRAVIS_COMMIT}-$(date +'%Y%m%d%H%M%S')"
echo "REACT_APP_IMAGE_TAG=${REACT_APP_IMAGE_TAG}" >> /opt/elasticbeanstalk/deployment/env
echo "REACT_APP_IMAGE_TAG=${REACT_APP_IMAGE_TAG}" >> /var/log/eb-hooks.log
