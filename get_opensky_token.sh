#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Error: .env file not found in $SCRIPT_DIR" >&2
  exit 1
fi

# Load credentials from .env
# shellcheck disable=SC1090
source "$ENV_FILE"

if [[ -z "${OPENSKY_CLIENT_ID:-}" || -z "${OPENSKY_CLIENT_SECRET:-}" ]]; then
  echo "Error: OPENSKY_CLIENT_ID and OPENSKY_CLIENT_SECRET must be set in .env" >&2
  exit 1
fi

TOKEN=$(curl -s -X POST "https://auth.opensky-network.org/auth/realms/opensky-network/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials" \
  -d "client_id=$OPENSKY_CLIENT_ID" \
  -d "client_secret=$OPENSKY_CLIENT_SECRET" | jq -r .access_token)

if [[ -z "$TOKEN" || "$TOKEN" == "null" ]]; then
  echo "Error: failed to retrieve OpenSky access token" >&2
  exit 1
fi

printf '%s\n' "$TOKEN"
