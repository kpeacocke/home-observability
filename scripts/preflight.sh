#!/usr/bin/env bash
set -euo pipefail

echo "[preflight] Checking required commands"
for cmd in docker; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Missing command: $cmd"
    exit 1
  fi
done

echo "[preflight] Checking compose env file"
if [[ ! -f compose/.env ]]; then
  echo "compose/.env missing. Copy compose/.env.example first."
  exit 1
fi

echo "[preflight] Validating compose file"
(cd compose && docker compose config >/dev/null)

echo "[preflight] OK"
