#!/bin/bash

# Abort on any error
set -e
source "$(dirname "$0")/theme.sh"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CURRENT_DIR=$(pwd)

echo -e "${CYAN}${LOGO} Updating caffeine CLI...${NC}"
cd "$SCRIPT_DIR" || exit
git pull
echo -e "${GREEN}${LOGO} Caffeine CLI updated successfully!${NC}"

echo -e "${CYAN}${LOGO} Updating all submodules in current project...${NC}"
cd "$CURRENT_DIR" || exit
git submodule update --remote --merge
echo -e "${GREEN}${LOGO} All project submodules updated successfully!${NC}"
