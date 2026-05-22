#!/usr/bin/env bash

volume_info="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"

volume_percent=$(
    awk '{printf "%.0f\n", $2 * 100}' <<< "$volume_info"
)

volume_muted="$(awk '{print $3}' <<< "$volume_info")"

volume_string="$volume_percent%"

category="volume"

if [ -n "$volume_muted" ]; then
    category="volume-muted"
    volume_string="$volume_string muted"
fi

notify-send \
    --app-name sway \
    --expire-time 800 \
    --hint string:x-canonical-private-synchronous:volume \
    --hint "int:value:$volume_percent" \
    --hint "string:category:$category" \
    --transient \
    "Volume" "$volume_string"
