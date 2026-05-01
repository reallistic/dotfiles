#!/bin/zsh -euf

set -euo pipefail

if [[ -d "$HOME/.dotfiles_public" ]]; then
    INSTALL_DIR="$HOME/.dotfiles_public/bin"
else
    INSTALL_DIR="$HOME/.dotfiles/bin"
fi
BINARY_NAME="diff-so-fancy"
REPO="so-fancy/diff-so-fancy"
INSTALL_PATH="$INSTALL_DIR/$BINARY_NAME"

LATEST=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
  | grep '"tag_name"' | sed 's/.*"tag_name": *"v\?\(.*\)".*/\1/')

if [[ -x "$INSTALL_PATH" ]]; then
  CURRENT=$("$INSTALL_PATH" --version 2>&1 | awk 'NR==2 {print $3}')
  if [[ "$CURRENT" == "$LATEST" ]]; then
    echo "$BINARY_NAME $CURRENT is already up to date"
    exit 0
  fi
fi

echo "Installing $BINARY_NAME $LATEST..."

curl -fsSL "https://github.com/$REPO/releases/latest/download/$BINARY_NAME" \
  -o "/tmp/$BINARY_NAME"

chmod +x "/tmp/$BINARY_NAME"

mkdir -p "$INSTALL_PATH"
sudo cp "/tmp/$BINARY_NAME" "$INSTALL_PATH"

echo "$BINARY_NAME $LATEST installed to $INSTALL_PATH"

if command -v brew &> /dev/null && command -v brew list diff-so-fancy &> /dev/null; then
    brew uninstall diff-so-fancy
fi
