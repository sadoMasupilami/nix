#!/usr/bin/env bash

# Enable exit on error
set -e

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define the target directory relative to the script's location
TARGET_DIR="$SCRIPT_DIR/flakes/home-manager/"

# Navigate to the target directory
cd "$TARGET_DIR"

# Execute the home-manager command
export NIXPKGS_ALLOW_UNFREE=1
home-manager switch --impure --flake .#wsl

echo "home-manager switch executed successfully."
