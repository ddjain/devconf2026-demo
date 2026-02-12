#!/usr/bin/env bash
# Build and push image for linux/amd64 (for typical K8s clusters).
# Pushes two tags: latest and current timestamp (YYYYMMDD-HHMMSS).
# Run from this directory (devconf2026-demo).

set -e
IMAGE="${IMAGE:-darshanjain/devconf2026-webapp:demo}"
REPO="${IMAGE%:*}"
TS=$(date -u +%Y%m%d-%H%M%S)

# Ensure buildx exists and use it for amd64
docker buildx create --use --name devconf-builder 2>/dev/null || true
docker buildx build \
  --platform linux/amd64 \
  -t "${REPO}:latest" \
  -t "${REPO}:${TS}" \
  --push \
  -f dockerfile \
  .

echo "Pushed ${REPO}:latest and ${REPO}:${TS} (linux/amd64)"
