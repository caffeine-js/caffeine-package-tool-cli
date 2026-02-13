#!/bin/bash

# Abort on any error
set -e

# 1. Argument validation
NEW_DIR=$1

if [ -z "$NEW_DIR" ]; then
    echo "Error: Please provide the project directory name."
    echo "Usage: caffeine:init <directory-name>"
    exit 1
fi

# 2. Check if directory already exists
if [ -d "$NEW_DIR" ]; then
    echo "Error: Directory '$NEW_DIR' already exists."
    exit 1
fi

# Get the absolute directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 3. Runtime Management (Mise)
# Ensure mise is in the PATH for the current script execution
export PATH="$HOME/.local/share/mise/bin:$PATH"

if ! command -v mise &> /dev/null; then
    echo "Mise not found. Installing..."
    curl https://mise.run | sh
fi

# Always activate mise for this shell session to enable tools
eval "$(mise activate bash)"

# 4. Linter Management (Biome/Brew)
if ! command -v biome &> /dev/null; then
    echo "Biome not found. Trying to install via Homebrew..."
    
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Adding brew to path for the current session (macOS Intel/Apple Silicon)
        if [[ -f /opt/homebrew/bin/brew ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -f /usr/local/bin/brew ]]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi
    
    brew install biome
fi

# 5. Project Initialization
echo "Creating project in '$NEW_DIR'..."
mkdir -p "$NEW_DIR"

# Copying resources from ./resources to the root of the new directory
cp -r "$SCRIPT_DIR/resources/." "$NEW_DIR/"

# Initializing git and adding .agent
cd "$NEW_DIR"
git init
git submodule add git@github.com:caffeine-js/agent-guide.git .agent

# Installing latest version of Bun locally in the project
echo "Using mise to configure Bun..."
mise use bun@latest

# 6. Configuration and Installation
echo "Running Biome migration..."
biome migrate --write || echo "Warning: 'biome migrate' failed or no files found to migrate."

echo "Installing dependencies with Bun..."
# Using mise exec to ensure the local bun version is used
mise exec -- bun i

# 7. Finalization
echo "----------------------------------------------------"
echo "Project '$NEW_DIR' successfully created!"
echo "IMPORTANT: Please update the project name in your 'package.json'."
echo "Location: $NEW_DIR/package.json"
echo "----------------------------------------------------"


