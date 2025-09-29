#!/bin/bash
# Install script - Deploys dotfiles from repo to system

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Installing dotfiles to your system..."

# Backup existing configs
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
echo "📦 Backing up existing configs to $BACKUP_DIR..."

# Backup if files exist
[ -f ~/.zshrc ] && cp ~/.zshrc "$BACKUP_DIR/.zshrc"
[ -f ~/.tmux.conf ] && cp ~/.tmux.conf "$BACKUP_DIR/.tmux.conf"
[ -d ~/.config/nvim ] && cp -r ~/.config/nvim "$BACKUP_DIR/nvim"

# Install zsh config
echo "📝 Installing zsh config..."
cp "$REPO_DIR/.zshrc" ~/.zshrc

# Install tmux config
echo "📝 Installing tmux config..."
cp "$REPO_DIR/.tmux.conf" ~/.tmux.conf

# Install nvim config
echo "📝 Installing nvim config..."
mkdir -p ~/.config
rm -rf ~/.config/nvim
cp -r "$REPO_DIR/nvim" ~/.config/nvim

echo ""
echo "✅ Dotfiles installed successfully!"
echo "📦 Backup saved to: $BACKUP_DIR"
echo ""
echo "💡 Next steps:"
echo "   • Restart your terminal or run: source ~/.zshrc"
echo "   • For tmux changes: run 'tmux source ~/.tmux.conf' in an active session"
echo "   • For nvim changes: restart nvim"