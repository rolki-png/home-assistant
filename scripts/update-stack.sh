#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(dirname "${script_dir}")"
compose_file="${COMPOSE_FILE:-${repo_dir}/docker-compose.yaml}"

if [[ ! -f "${compose_file}" ]]; then
  echo "Compose file not found: ${compose_file}" >&2
  exit 1
fi

cd "$(dirname "${compose_file}")"

echo "==> Pulling latest images"
docker compose -f "${compose_file}" pull

echo "==> Applying updates"
docker compose -f "${compose_file}" up -d
