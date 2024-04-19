#!/usr/bin/env bash
set -e

mkdir --parents /media/home-assistant/configuration
ln --force --no-target-directory --symbolic /opt/home-assistant/custom_components \
    /media/home-assistant/configuration/custom_components

if [[ ! -f /media/home-assistant/configuration/configuration.yaml ]]; then
    cp /opt/home-assistant/template/* /media/home-assistant/configuration
fi

exec "$@"
