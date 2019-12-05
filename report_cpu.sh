#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"

# Show an ERROR: message on stderr
_error() {
    echo "\\033[1;91mERROR: $*\\033[0m" >&2
}

source defaults.sh

# Get local configuration
if [ ! -s config.sh ]; then
    _error "Run ./setup.sh to configure this app, first."
    exit 2
fi

source config.sh

# Get CPU fixed point (100 = 1.0) for 5m
_get_cpu_5m() {
    local cpu=0
    cpu=$(uptime | uptime | awk '{print $(NF-1)}' | tr -d ",")
    echo "$cpu * 100 /1" | bc
}

# Get CPU fixed point (100 = 1.0) for 1m
_get_cpu_1m() {
    local cpu=0
    cpu=$(uptime | uptime | awk '{print $(NF-2)}' | tr -d ",")
    echo "$cpu * 100 /1" | bc
}

# Set state of light
# $1 color definition (HUE_HUE_*)
_set_state() {
    local payload='{'"$1"', "transition": '"$HUE_TRANSITION_TIME"', "bri": 254, "colormode": "xy", "on": true}'
    curl -s -X PUT -d "$payload" "$HUE_BRIDGE_BASE/api/$HUE_APP_USERNAME/lights/$HUE_LIGHT_ID/state" > /dev/null
}


_main() {
    local cpu
    local colordef='"xy": [0.3103, 0.3287], "hue": 39750, "sat": 112'
    _set_state "$colordef"
    while true; do
        cpu=$(_get_cpu_1m)
        if [ "$cpu" -le "$HUE_CPU_IDLE" ]; then
            colordef=$HUE_HUE_IDLE
        elif [ "$cpu" -le "$HUE_CPU_LOW" ]; then
            colordef=$HUE_HUE_LOW
        elif [ "$cpu" -le "$HUE_CPU_MED" ]; then
            colordef=$HUE_HUE_MED
        elif [ "$cpu" -le "$HUE_CPU_HIGH" ]; then
            colordef=$HUE_HUE_HIGH
        else
            colordef=$HUE_HUE_THRASH
        fi
        _set_state "$colordef"
        sleep 15
    done
}

# Start the main loop!
_main
