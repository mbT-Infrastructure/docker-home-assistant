#!/usr/bin/env bash
set -e -o pipefail

curl --fail --location http://localhost:8123/ || exit 1
