#!/bin/bash
PRIVACY_EMAIL="${PRIVACY_EMAIL:-user@example.com}"  # Allow override via environment
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CACHE_DIR="${SCRIPT_DIR}/../../_isaac_cache"

xhost +local:docker &>/dev/null || true

docker run --name isaac-sim --entrypoint bash -it --gpus all -e "ACCEPT_EULA=Y" --rm \
 --network=host -e "PRIVACY_CONSENT=Y" -e "PRIVACY_USERID=${PRIVACY_EMAIL}" \
 -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
 -v "${CACHE_DIR}:/isaac-sim/.local/share/ov/data" \
 isaac-sim-docker:latest "$@"
