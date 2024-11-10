#!/bin/bash

# Enable exit on error
set -e

# Define the target directory relative to the script
TARGET_DIR="./flakes/home-manager/"

# Navigate to the target directory
cd "$TARGET_DIR"

# Execute the home-manager command
home-manager switch --impure --flake .#wsl

echo "home-manager switch executed successfully."
