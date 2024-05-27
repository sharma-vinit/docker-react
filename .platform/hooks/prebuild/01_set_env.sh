#!/bin/bash
echo "REACT_APP_IMAGE_TAG=build-${TRAVIS_COMMIT}-$(date +'%Y%m%d%H%M%S')" >> /opt/elasticbeanstalk/deployment/env