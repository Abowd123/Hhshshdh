#!/bin/bash
# VT_Patcher One-Line Install
# 𝓙𝓸𝓴𝓮𝓻丨𝓜4  |  @VT_YC
#=============================================================================
set -e
R='\033[31;1m'; G='\033[32;1m'; C='\033[36;1m'; Y='\033[33;1m'; N='\033[0m'
V="2.0.0"; D="$HOME/VT_Patcher"
echo -e "${R}"
echo '  ╔══════════════════════════════════════════════════════╗'
echo '  ║  ██╗   ██╗████████╗     ██████╗  █████╗ ████████╗  ║'
echo '  ║  ██║   ██║╚══██╔══╝    ██╔══██╗██╔══██╗╚══██╔══╝  ║'
echo '  ║  ██║   ██║   ██║       ██████╔╝███████║   ██║     ║'
echo '  ║  ╚██╗ ██╔╝   ██║       ██╔═══╝ ██╔══██║   ██║     ║'
echo '  ║   ╚████╔╝    ██║       ██║     ██║  ██║   ██║     ║'
echo '  ║    ╚═══╝     ╚═╝       ╚═╝     ╚═╝  ╚═╝   ╚═╝     ║'
echo '  ╚══════════════════════════════════════════════════════╝'
echo -e "${N}"
echo -e "${C}VT_Patcher v${V} by 𝓙𝓸𝓴𝓮𝓻丨𝓜4 | @VT_YC${N}"
echo -e "${Y}Installing...${N}"
mkdir -p "$D" && cd "$D"
pkg update -y 2>/dev/null; pkg install -y openjdk-17 python wget unzip 2>/dev/null
pip install requests r2pipe asn1crypto 2>/dev/null
if [ -f APK_PATCHER.py ]; then echo -e "${G}✔ Already installed${N}"; exit 0; fi
ZPATH="/storage/emulated/0/DCIM/VT_Patcher.zip"
if [ -f "$ZPATH" ]; then cp "$ZPATH" ./
elif wget -q --timeout=10 "https://github.com/VT_YC/VT_Patcher/releases/download/v${V}/VT_Patcher.zip" -O VT_Patcher.zip 2>/dev/null; then :
else echo -e "${R}✘ Download failed! Get zip from @VT_YC${N}"; exit 1
fi
unzip -qo VT_Patcher.zip 2>/dev/null || true
[ -d vtpatcher ] && (mv vtpatcher/* .; rm -rf vtpatcher)
rm -f VT_Patcher.zip
echo -e "${R}╔═══════════════════════════════════════════╗"
echo -e "║${G}   VT_Patcher v${V} Installed!              ${R}║"
echo -e "║${C}   𝓙𝓸𝓴𝓮𝓻丨𝓜4  |  @VT_YC                   ${R}║"
echo -e "║${Y}   Usage: python3 APK_PATCHER.py -h${N}      ${R}║"
echo -e "${R}╚═══════════════════════════════════════════╝${N}"
