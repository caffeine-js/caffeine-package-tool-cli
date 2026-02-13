#!/bin/bash

# Get the absolute directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INIT_SCRIPT="$SCRIPT_DIR/run.sh"
UPDATE_SCRIPT="$SCRIPT_DIR/update-agent.sh"

# Ensure scripts are executable
chmod +x "$INIT_SCRIPT"
chmod +x "$UPDATE_SCRIPT"

# Path to zsh configuration file
ZSHRC="$HOME/.zshrc"

# Function to add alias if it doesn't exist
add_alias() {
    local name=$1
    local script=$2
    if ! grep -q "alias $name=" "$ZSHRC"; then
        echo "" >> "$ZSHRC"
        echo "# Caffeine CLI: $name" >> "$ZSHRC"
        echo "alias $name='$script'" >> "$ZSHRC"
        echo "Alias '$name' added to $ZSHRC"
    else
        echo "Command '$name' is already defined in $ZSHRC"
    fi
}

add_alias "caffeine:init" "$INIT_SCRIPT"
add_alias "caffeine:update@agent" "$UPDATE_SCRIPT"

echo "Installation complete. To use the new commands, run: source ~/.zshrc"