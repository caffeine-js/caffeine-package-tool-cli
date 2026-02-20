#!/bin/bash

# Abort on any error
set -e
source "$(dirname "$0")/theme.sh"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

case "$1" in
    init)
        "$SCRIPT_DIR/init.sh" "${@:2}"
        ;;
    help|-h|"")
        "$SCRIPT_DIR/help.sh"
        ;;
    add)
        if [ "$2" == "husky" ]; then
            "$SCRIPT_DIR/scripts/install-husky/install.sh" "${@:3}"
        else
            echo -e "${RED}Unknown add target: $2${NC}"
            echo -e "Run '${CYAN}caffeine help${NC}' for usage information."
            exit 1
        fi
        ;;
    update)
        if [ "$2" == "agent" ]; then
            "$SCRIPT_DIR/scripts/update-agent/update-agent.sh" "${@:3}"
        elif [ -z "$2" ]; then
            "$SCRIPT_DIR/update.sh"
        else
            echo -e "${RED}Unknown update target: $2${NC}"
            echo -e "Run '${CYAN}caffeine help${NC}' for usage information."
            exit 1
        fi
        ;;
    *)
        echo -e "${RED}${LOGO} Invalid command: $1${NC}"
        echo -e "Run '${CYAN}caffeine help${NC}' for usage information."
        exit 1
        ;;
esac
