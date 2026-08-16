#!/bin/bash
#=============================================================================
#  VT_Patcher - 𝓙𝓸𝓴𝓮𝓻丨𝓜4  |  @VT_YC
#  ██╗   ██╗████████╗     ██████╗  █████╗ ████████╗ ██████╗██╗  ██╗███████╗██████╗
#  ██║   ██║╚══██╔══╝    ██╔══██╗██╔══██╗╚══██╔══╝██╔════╝██║  ██║██╔════╝██╔══██╗
#  ██║   ██║   ██║       ██████╔╝███████║   ██║   ██║     ███████║█████╗  ██████╔╝
#  ██║   ██║   ██║       ██╔═══╝ ██╔══██║   ██║   ██║     ██╔══██║██╔══╝  ██╔══██╗
#  ╚██████╔╝   ██║       ██║     ██║  ██║   ██║   ╚██████╗██║  ██║███████╗██║  ██║
#   ╚═════╝    ╚═╝       ╚═╝     ╚═╝  ╚═╝   ╚═╝    ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
#=============================================================================
#  Automated Installer for Termux
#  Developer: 𝓙𝓸𝓴𝓮𝓻丨𝓜4
#  Channel:   @VT_YC
#=============================================================================

set -e

RED='\033[31;1m'; GREEN='\033[32;1m'; YELLOW='\033[33;1m'
BLUE='\033[34;1m'; PURPLE='\033[35;1m'; CYAN='\033[36;1m'
PINK='\033[38;5;213;1m'; ORANGE='\033[38;5;202;1m'; NC='\033[0m'

echo -e "${RED}"
echo '  ╔══════════════════════════════════════════════════════╗'
echo '  ║  ██╗   ██╗████████╗     ██████╗  █████╗ ████████╗  ║'
echo '  ║  ██║   ██║╚══██╔══╝    ██╔══██╗██╔══██╗╚══██╔══╝  ║'
echo '  ║  ██║   ██║   ██║       ██████╔╝███████║   ██║     ║'
echo '  ║  ╚██╗ ██╔╝   ██║       ██╔═══╝ ██╔══██║   ██║     ║'
echo '  ║   ╚████╔╝    ██║       ██║     ██║  ██║   ██║     ║'
echo '  ║    ╚═══╝     ╚═╝       ╚═╝     ╚═╝  ╚═╝   ╚═╝     ║'
echo '  ╠══════════════════════════════════════════════════════╣'
echo -e "  ║${CYAN}  𝓓𝓮𝓿𝓮𝓵𝓸𝓹𝓮𝓻: ${ORANGE}𝓙𝓸𝓴𝓮𝓻丨𝓜4${CYAN}          ${GREEN}𝓒𝓱𝓪𝓷𝓷𝓮𝓵: ${ORANGE}@VT_YC${RED}  ║"
echo '  ╚══════════════════════════════════════════════════════╝'
echo -e "${NC}"

# -- Configuration --
INSTALL_DIR="${HOME}/VT_Patcher"
VERSION="2.0.0"
# Change this URL after uploading to your GitHub release:
DOWNLOAD_URL="https://github.com/VT_YC/VT_Patcher/releases/download/v${VERSION}/VT_Patcher.zip"

# -- Dependencies check --
echo -e "${BLUE}[${GREEN}*${BLUE}]${CYAN} Checking dependencies...${NC}"

for pkg in openjdk-17 python radare2 aapt wget; do
    if ! command -v "$pkg" &>/dev/null && ! dpkg -l "$pkg" &>/dev/null 2>&1; then
        echo -e "${YELLOW}  ➜ Installing ${pkg}...${NC}"
        pkg install -y "$pkg" 2>/dev/null || true
    fi
done

# -- Python packages --
echo -e "${BLUE}[${GREEN}*${BLUE}]${CYAN} Installing Python modules...${NC}"
for mod in requests r2pipe asn1crypto; do
    python3 -c "import ${mod}" 2>/dev/null && continue
    echo -e "${YELLOW}  ➜ Installing ${mod}...${NC}"
    pip install "$mod" 2>/dev/null || true
done

# -- Download & Extract --
echo -e "${BLUE}[${GREEN}*${BLUE}]${CYAN} Downloading VT_Patcher v${VERSION}...${NC}"

mkdir -p "${INSTALL_DIR}"
cd "${INSTALL_DIR}"

if [ -f "APK_PATCHER.py" ]; then
    echo -e "${GREEN}  ✔ Already installed${NC}"

else
    # Try multiple sources
    FOUND=0

    # 1. Check local DCIM folder
    for path in /sdcard/DCIM/VT_Patcher.zip /storage/emulated/0/DCIM/VT_Patcher.zip /sdcard/Download/VT_Patcher.zip; do
        if [ -f "$path" ]; then
            echo -e "${GREEN}  ✔ Found zip at ${path}${NC}"
            cp "$path" VT_Patcher.zip
            FOUND=1
            break
        fi
    done

    # 2. Try download from GitHub releases
    if [ "$FOUND" = "0" ]; then
        echo -e "${CYAN}  ➜ Trying GitHub download...${NC}"
        if wget -q --timeout=10 "${DOWNLOAD_URL}" -O VT_Patcher.zip 2>/dev/null; then
            FOUND=1
        fi
    fi

    # 3. Try alternative URL
    if [ "$FOUND" = "0" ]; then
        echo -e "${CYAN}  ➜ Trying alternative URL...${NC}"
        ALT_URL="https://github.com/VT_YC/VT_Patcher/archive/refs/heads/main.zip"
        if wget -q --timeout=10 "${ALT_URL}" -O VT_Patcher.zip 2>/dev/null; then
            mkdir -p tmp_extract && cd tmp_extract
            unzip -qo ../VT_Patcher.zip && mv VT_Patcher-main/* ../ 2>/dev/null
            cd .. && rm -rf tmp_extract VT_Patcher.zip
            FOUND=2
        fi
    fi

    if [ "$FOUND" = "0" ]; then
        echo -e "${RED}  ✘ Cannot reach download source.${NC}"
        echo -e "${YELLOW}  ➜ Download from: ${CYAN}https://t.me/VT_YC${NC}"
        echo -e "${YELLOW}  ➜ Or manually copy VT_Patcher.zip to ${INSTALL_DIR}${NC}"
        echo -e "${YELLOW}  ➜ Then run: cd ${INSTALL_DIR} && unzip -o VT_Patcher.zip${NC}"
        exit 1
    fi

    # Extract if needed (method 1&2 use zip, method 3 extracts inline)
    if [ "$FOUND" = "1" ]; then
        unzip -qo VT_Patcher.zip && rm -f VT_Patcher.zip 2>/dev/null
        # Handle nested vtpatcher/ directory
        if [ -d "vtpatcher" ]; then
            mv vtpatcher/* . && rm -rf vtpatcher
        fi
        echo -e "${GREEN}  ✔ Extracted successfully${NC}"
    fi
fi

# -- Final setup --
chmod +x start.sh 2>/dev/null || true

# Create termux shortcut
mkdir -p "${HOME}/.shortcuts"
cat > "${HOME}/.shortcuts/VT_Patcher" << 'SHORTCUT'
#!/bin/bash
cd ~/VT_Patcher && python3 VT_Patcher/APK_PATCHER.py "$@"
SHORTCUT
chmod +x "${HOME}/.shortcuts/VT_Patcher"

# Create aliases in bashrc
if ! grep -q "VT_Patcher" "${HOME}/.bashrc" 2>/dev/null; then
    cat >> "${HOME}/.bashrc" << 'BASHRC'
alias vtpatcher='cd ~/VT_Patcher && python3 VT_Patcher/APK_PATCHER.py'
alias vtpatch='cd ~/VT_Patcher && python3 VT_Patcher/APK_PATCHER.py'
BASHRC
    echo -e "${GREEN}  ✔ Aliases added to .bashrc${NC}"
fi

source "${HOME}/.bashrc" 2>/dev/null || true

# -- Show finish --
echo ""
echo -e "${RED}  ╔══════════════════════════════════════════════════╗"
echo -e "  ║${GREEN}  ✔ VT_Patcher v${VERSION} Installed Successfully  ${RED}║"
echo -e "  ╠══════════════════════════════════════════════════╣"
echo -e "  ║${CYAN}  𝓓𝓮𝓿𝓮𝓵𝓸𝓹𝓮𝓻: ${ORANGE}𝓙𝓸𝓴𝓮𝓻丨𝓜4${RED}                        ║"
echo -e "  ║${CYAN}  𝓒𝓱𝓪𝓷𝓷𝓮𝓵:  ${ORANGE}@VT_YC${RED}                           ║"
echo -e "  ╠══════════════════════════════════════════════════╣"
echo -e "  ║${YELLOW}  Usage:${NC}                                                        ║"
echo -e "  ║${GREEN}  vtpatcher -i YourApp.apk ${NC}                                      ║"
echo -e "  ║${GREEN}  vtpatcher -i YourApp.apk -c cert.pem ${NC}                          ║"
echo -e "  ║${GREEN}  vtpatcher -h ${NC}                                                   ║"
echo -e "  ║${GREEN}  vtpatcher -C ${NC}  (Credits)                                       ║"
echo -e "  ║${YELLOW}                                                                    ${RED}║"
echo -e "  ║${CYAN}  Or: cd ~/VT_Patcher && bash start.sh -i YourApp.apk ${NC}            ║"
echo "  ╚══════════════════════════════════════════════════╝"
echo -e "${NC}"
