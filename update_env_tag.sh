#!/bin/bash

# The path to the environment config file
ENV_CONFIG_FILE=".ebextensions/environment.config"

echo "Before updating REACT_APP_IMAGE_TAG"
cat "$ENV_CONFIG_FILE"

# The environment variable and its new value
ENV_VAR="REACT_APP_IMAGE_TAG"
NEW_VALUE="build-${TRAVIS_COMMIT}-$(date +'%Y%m%d%H%M%S')"

# Temporary file to store the updated content
TEMP_FILE=$(mktemp)

# Flag to check if the variable was updated
UPDATED=false

# Read the config file line by line
while IFS= read -r line; do
  if [[ "$line" =~ ^\ {4}${ENV_VAR}: ]]; then
    echo "    $ENV_VAR: $NEW_VALUE" >> "$TEMP_FILE"
    UPDATED=true
  else
    echo "$line" >> "$TEMP_FILE"
  fi
done < "$ENV_CONFIG_FILE"

# If the variable was not found, add it at the end
if [ "$UPDATED" = false ]; then
  echo "    $ENV_VAR: $NEW_VALUE" >> "$TEMP_FILE"
fi

# Replace the original file with the updated content
mv "$TEMP_FILE" "$ENV_CONFIG_FILE"

echo "Updated environment variable in $ENV_CONFIG_FILE:"
cat "$ENV_CONFIG_FILE"
