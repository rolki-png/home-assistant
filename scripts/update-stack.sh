#!/usr/bin/env bash
set -euo pipefail

compose_file="/home/rolki/projects/home-assistant/docker-compose.yaml"

if [[ ! -f "${compose_file}" ]]; then
  echo "Compose file not found: ${compose_file}" >&2
  exit 1
fi

cd "$(dirname "${compose_file}")"

echo "==> Pulling latest images"
/usr/bin/docker compose -f "${compose_file}" pull

echo "==> Applying updates"
/usr/bin/docker compose -f "${compose_file}" up -d
