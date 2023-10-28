#!/usr/bin/env bash
set -e

mkdir --parents /media/home-assistant/configuration

if [[ ! -f /media/home-assistant/configuration/cofiguration.yaml ]]; then
    cp /opt/home-assistant/template/* /media/home-assistant/configuration
fi

exec "$@"
