#!/bin/bash

set -eufo pipefail

osascript -e 'tell application "System Events" to tell every desktop to set picture to "/System/Library/Desktop Pictures/Solid Colors/Electric Blue.png" as POSIX file'
