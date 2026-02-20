#!/bin/bash

# Abort on any error
set -e
source "$(dirname "$0")/theme.sh"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CAFFEINE_SCRIPT="$SCRIPT_DIR/caffeine.sh"
INIT_SCRIPT="$SCRIPT_DIR/init.sh"
UPDATE_DEPS_SCRIPT="$SCRIPT_DIR/install-dependencies.sh"
SETUP_ENV_SCRIPT="$SCRIPT_DIR/install-environment.sh"
UPDATE_SCRIPT="$SCRIPT_DIR/update.sh"

chmod +x "$CAFFEINE_SCRIPT"
chmod +x "$INIT_SCRIPT"
chmod +x "$UPDATE_DEPS_SCRIPT"
chmod +x "$SETUP_ENV_SCRIPT"
chmod +x "$UPDATE_SCRIPT"

ZSHRC="$HOME/.zshrc"

# Function to add alias if it doesn't exist
add_alias() {
    local name=$1
    local script=$2
    if ! grep -q "alias $name=" "$ZSHRC"; then
        echo "" >> "$ZSHRC"
        echo "# Caffeine CLI: $name" >> "$ZSHRC"
        echo "alias $name='$script'" >> "$ZSHRC"
        echo -e "${GREEN}${LOGO} Alias '${CYAN}$name${NC}' added to ${UNDERLINE}$ZSHRC${NC}."
    else
        echo -e "${YELLOW}${LOGO} Command '${CYAN}$name${NC}' is already defined in ${UNDERLINE}$ZSHRC${NC}."
    fi
}

add_alias "caffeine" "$CAFFEINE_SCRIPT"

echo -e "${GREEN}${LOGO} Installation complete!${NC}"
echo -e "${TIP} To use the new commands, run: ${CYAN}source ~/.zshrc${NC}"