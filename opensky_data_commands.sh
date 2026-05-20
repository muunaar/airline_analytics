#!/usr/bin/env bash
# OpenSky API data extraction commands for the airlines_analytics project.
# Usage: run these commands from the repository root.

# 1) Retrieve an OpenSky access token and show it.
cd /Users/mouna/Desktop/analytics_engineer/portfolio/airlines_analytics
export TOKEN="$(./get_opensky_token.sh)"
echo "$TOKEN"

# 2) Fetch aircraft state data for the Frankfurt area using the bearer token.
cd /Users/mouna/Desktop/analytics_engineer/portfolio/airlines_analytics
export TOKEN="$(./get_opensky_token.sh)"
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://opensky-network.org/api/states/all?lamin=49.5&lomin=8.0&lamax=50.5&lomax=9.0" | jq '.'
