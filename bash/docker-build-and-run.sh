#!/bin/bash

set -euxo pipefail

_label_name="label:bash:trial"
_image_name="bash:trial"

# Build
docker build \
  --label ${_label_name} \
  --tag ${_image_name} \
  .

# Prune any intermediate images
docker image ls
docker image prune

# Run
docker run \
  --interactive \
  --tty \
  --rm \
  ${_image_name}
