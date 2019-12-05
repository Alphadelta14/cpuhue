#!/usr/bin/env bash

HUE_BRIDGE_BASE=""
HUE_APP_NAME="cpu_hue_app"

HUE_APP_USERNAME=""
HUE_LIGHT_ID="1"

# White < HUE_CPU_IDLE
HUE_CPU_IDLE=80
HUE_HUE_IDLE='"xy": [0.3103, 0.3287], "hue": 39750, "sat": 112'
# HUE_CPU_IDLE < Green < HUE_CPU_LOW
HUE_CPU_LOW=200
HUE_HUE_LOW='"xy": [0.2148, 0.7089], "hue": 25699, "sat": 254'
# HUE_CPU_LOW < Yellow < HUE_CPU_MED
HUE_CPU_MED=500
HUE_HUE_MED='"xy": [0.4757, 0.4884], "hue": 17357, "sat": 234'
# HUE_CPU_MED < Orange < HUE_CPU_HIGH
HUE_CPU_HIGH=1000
HUE_HUE_HIGH='"xy": [0.5852, 0.3955], "hue": 1172, "sat": 241'
# HUE_CPU_HIGH < Red
HUE_HUE_THRASH='"xy": [0.6809, 0.3093], "hue": 17357, "sat": 234'

# in 100ms (40=4s)
HUE_TRANSITION_TIME=40
