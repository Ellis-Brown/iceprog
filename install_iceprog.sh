#!/bin/bash

# Check the system architecture
ARCH=$(uname)
echo "System architecture: $ARCH"
if [ "$ARCH" == "Linux" ]; then
  # Linux system
  URL="https://raw.githubusercontent.com/Ellis-Brown/iceprog/main/linux-iceprog"
else
  # Mac system
  URL="https://raw.githubusercontent.com/Ellis-Brown/iceprog/main/iceprog"
fi

# Download the appropriate binary file
echo "Downloading iceprog binary file..."
curl -L $URL -o iceprog

# Make the file executable
echo "Making iceprog file executable..."
chmod +x iceprog

# Add the file to the PATH environment variable
echo "Adding iceprog to PATH..."

# Determine the current shell, and add to path accordingly
if [ -n "$BASH_VERSION" ]; then
  # Bash shell
  SHELL="bash"
elif [ -n "$ZSH_VERSION" ]; then
  # Zsh shell
  SHELL="zsh"
else
  # Unknown shell
  echo "Unknown shell"
  exit 1
fi

