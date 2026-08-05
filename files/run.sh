#!/usr/bin/env bash
set -e -o pipefail

exec hass --config /media/home-assistant/configuration --skip-pip
