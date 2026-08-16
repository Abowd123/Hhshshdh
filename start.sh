#!/bin/bash
# VT_Patcher - APK Patching Tool by 𝓙𝓸𝓴𝓮𝓻丨𝓜4
# Channel: @VT_YC
# Run: bash start.sh [options]

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

python3 vtpatcher/APK_PATCHER.py "$@"
