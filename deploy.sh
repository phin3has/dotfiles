#!/bin/bash
# Deploy script - Updates the repo with current system configurations

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Deploying current system configs to dotfiles repo..."

# Copy zsh config
echo "📝 Copying zsh config..."
cp ~/.zshrc "$REPO_DIR/.zshrc"

# Copy tmux config
echo "📝 Copying tmux config..."
cp ~/.tmux.conf "$REPO_DIR/.tmux.conf"

# Copy nvim config
echo "📝 Copying nvim config..."
rm -rf "$REPO_DIR/nvim"
cp -r ~/.config/nvim "$REPO_DIR/nvim"

echo "✅ All configs copied to repo!"
echo ""
echo "📋 Git status:"
git -C "$REPO_DIR" status --short

echo ""
echo "💡 To commit changes, run:"
echo "   cd $REPO_DIR"
echo "   git add ."
echo "   git commit -m 'Update dotfiles'"
echo "   git push"