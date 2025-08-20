#!/usr/bin/sh
hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .layout'
