#!/bin/bash

set -eufo pipefail

oh-my-posh font install Meslo

podman machine init
podman machine start