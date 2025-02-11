#!/usr/bin/env bash
set -e -o pipefail

source /opt/home-assistant/venv/bin/activate
hass --config /media/home-assistant/configuration
