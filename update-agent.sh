#!/bin/bash

set -e
source "$(dirname "$0")/theme.sh"

AGENT_DIR=".agent"
AGENT_DIR_VIEW="${UNDERLINE}${BOLD}${CYAN}$AGENT_DIR${NC}"

if [ ! -d "$AGENT_DIR" ]; then
    echo -e "${RED}${LOGO} Directory '${AGENT_DIR_VIEW}' not found."
    echo -e "${TIP} Make sure you are in the root of a Caffeine project."
    exit 1
fi

echo -e "${CYAN}${LOGO} Updating ${AGENT_DIR_VIEW} submodule to the latest commit..."
git submodule update --remote --merge "$AGENT_DIR"

echo -e "${GREEN}${LOGO} Agent updated successfully!"
