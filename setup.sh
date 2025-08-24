#!/bin/bash

# Setup script for Vibe Terminal Screensaver
echo "🚀 Setting up your coding vibe screensaver..."

# Create directory for the script
INSTALL_DIR="$HOME/.local/bin"
SCRIPT_NAME="vibe"

# Create the directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Download or copy the vibe script
echo "📥 Installing vibe script to $INSTALL_DIR/$SCRIPT_NAME"

# Copy the script (assuming it's in the same directory)
if [ -f "./vibe.sh" ]; then
    cp "./vibe.sh" "$INSTALL_DIR/$SCRIPT_NAME"
else
    echo "❌ vibe.sh not found in current directory"
    echo "Please make sure vibe.sh is in the same directory as this setup script"
    exit 1
fi

# Make it executable
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# Check if .local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo "📝 Adding $HOME/.local/bin to your PATH in .zshrc"
    
    # Backup existing .zshrc
    if [ -f "$HOME/.zshrc" ]; then
        cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
        echo "💾 Backed up existing .zshrc"
    fi
    
    # Add to PATH
    echo "" >> "$HOME/.zshrc"
    echo "# Added by vibe screensaver setup" >> "$HOME/.zshrc"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
    
    echo "✅ Added to PATH. Please restart your terminal or run: source ~/.zshrc"
else
    echo "✅ $HOME/.local/bin is already in your PATH"
fi

echo ""
echo "🎉 Installation complete!"
echo ""
echo "Usage:"
echo "  Type 'vibe' in your terminal to start the screensaver"
echo "  Press Ctrl+C to exit"
echo ""
echo "If the command doesn't work immediately, try:"
echo "  source ~/.zshrc"
echo "  or restart your terminal"