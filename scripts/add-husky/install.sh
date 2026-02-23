#!/bin/bash

set -e
source "$(dirname "$0")/theme.sh"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TARGET_DIR="$PWD"

if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}${LOGO} Error: Target directory '${CYAN}$TARGET_DIR${NC}' does not exist.${NC}"
    exit 1
fi

echo -e "${CYAN}${LOGO} Starting husky installation in '${UNDERLINE}$TARGET_DIR${NC}'...${NC}"

echo -e "${CYAN}${LOGO} Copying resources...${NC}"
if [ -d "$SCRIPT_DIR/resources" ]; then
    cp -r "$SCRIPT_DIR/resources/." "$TARGET_DIR"
else
    echo -e "${BYELLOW}${LOGO} Warning: 'resources' folder not found at $SCRIPT_DIR/resources${NC}"
fi

echo -e "${CYAN}${LOGO} Updating package.json via setup_husky.py...${NC}"
cd "$TARGET_DIR"
export PYTHONPATH="$SCRIPT_DIR:$PYTHONPATH"
python3 "$SCRIPT_DIR/setup_husky.py"

echo -e "${GREEN}----------------------------------------------------${NC}"
echo -e "${GREEN}${LOGO} Husky successfully installed in '${UNDERLINE}$TARGET_DIR${NC}'!${NC}"
echo -e "${GREEN}----------------------------------------------------${NC}"
echo -e "${TIP} Remember to run 'npm install' or 'pnpm install' in your project to install added dependencies.${NC}"
