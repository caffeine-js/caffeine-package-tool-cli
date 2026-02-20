#!/bin/bash

# Abort on any error
set -e
source "$(dirname "$0")/theme.sh"

echo -e "${CYAN}${LOGO}${NC}"
echo -e "${GREEN}Usage:${NC}"
echo -e "  caffeine <command> [options]"
echo -e ""
echo -e "${GREEN}Commands:${NC}"
echo -e "  ${CYAN}init${NC}               Initialize a new Caffeine project."
echo -e "  ${CYAN}add husky${NC}          Install and configure Husky for Git hooks."
echo -e "  ${CYAN}update${NC}             Update all submodules to the latest commit."
echo -e "  ${CYAN}update agent${NC}       Update the AI Agent Guide."
echo -e "  ${CYAN}help, -h${NC}           Show this help message."
echo -e ""
