#!/usr/bin/env bash
set -euo pipefail
# One-line installer for init-toolkit
# Usage: curl -fsSL https://raw.githubusercontent.com/fabiocicerchia/init-toolkit/main/install.sh | bash

IMAGE="ghcr.io/fabiocicerchia/init-toolkit:latest"

echo "Pulling init-toolkit from GHCR..."
docker pull "$IMAGE"
echo ""
echo "init-toolkit ready. Use it as a Kubernetes initContainer, Compose"
echo "entrypoint, or COPY --from= source for wait-for/dockerize/healthcheck-*."
echo "See https://github.com/fabiocicerchia/init-toolkit for usage."
