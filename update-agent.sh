#!/bin/bash

# Abort on any error
set -e

# Path to .agent directory
AGENT_DIR=".agent"

if [ ! -d "$AGENT_DIR" ]; then
    echo "Error: Directory '$AGENT_DIR' not found."
    echo "Make sure you are in the root of a Caffeine project."
    exit 1
fi

echo "Updating .agent submodule to the latest commit..."
git submodule update --remote --merge "$AGENT_DIR"

echo "----------------------------------------------------"
echo ".agent successfully updated!"
echo "----------------------------------------------------"
