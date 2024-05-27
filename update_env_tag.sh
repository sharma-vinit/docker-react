#!/bin/bash

# The path to the environment config file
ENV_CONFIG_FILE=".ebextensions/environment.config"

echo "Before updating REACT_APP_IMAGE_TAG"
cat "$ENV_CONFIG_FILE"

# The environment variable and its new value
ENV_VAR="REACT_APP_IMAGE_TAG"
NEW_VALUE="build-${TRAVIS_COMMIT}-$(date +'%Y%m%d%H%M%S')"

# Check if the environment config file exists
if [ ! -f "$ENV_CONFIG_FILE" ]; then
  echo "Environment config file not found!"
  exit 1
fi

# Check if the environment variable exists in the config file
if grep -q "$ENV_VAR:" "$ENV_CONFIG_FILE"; then
  # Update the existing environment variable value
  sed -i "s/^  $ENV_VAR:.*/  $ENV_VAR: $NEW_VALUE/" "$ENV_CONFIG_FILE"
else
  # Append the new environment variable with correct indentation
  echo "  $ENV_VAR: $NEW_VALUE" >> "$ENV_CONFIG_FILE"
fi

echo "Updated environment variable in $ENV_CONFIG_FILE:"
cat "$ENV_CONFIG_FILE"