#!/bin/bash

set -e
source "$(dirname "$0")/theme.sh"

NEW_DIR=$1

if [ -z "$NEW_DIR" ]; then
    echo -e "${RED}${LOGO} Error: Please provide the project directory name.${NC}"
    echo -e "${TIP} Usage: ${CYAN}caffeine init <directory-name>${NC}"
    exit 1
fi

if [ -d "$NEW_DIR" ]; then
    echo -e "${RED}${LOGO} Error: Directory '${CYAN}$NEW_DIR${NC}' already exists.${NC}"
    exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

"$SCRIPT_DIR/install-environment.sh"

echo -e "${CYAN}${LOGO} Creating project in '${UNDERLINE}$NEW_DIR${NC}'...${NC}"
mkdir -p "$NEW_DIR"

cp -r "$SCRIPT_DIR/resources/." "$NEW_DIR/"

cd "$NEW_DIR"
git init
echo -e "${CYAN}${LOGO} Adding agent-guide submodule...${NC}"
git submodule add git@github.com:caffeine-js/agent-guide.git .agent

echo -e "${CYAN}${LOGO} Setting up package.json details...${NC}"
python3 "$SCRIPT_DIR/setup_project.py" "./package.json" "$NEW_DIR"

"$SCRIPT_DIR/install-dependencies.sh"

echo -e "${GREEN}----------------------------------------------------${NC}"
echo -e "${GREEN}${LOGO} Project '${UNDERLINE}$NEW_DIR${NC}' successfully created!${NC}"
echo -e "${GREEN}----------------------------------------------------${NC}"


