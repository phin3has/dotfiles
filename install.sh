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

# Install oh-my-zsh plugins if oh-my-zsh is installed
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 Installing oh-my-zsh plugins..."

    # Install zsh-syntax-highlighting
    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
        echo "   • Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" --quiet
    else
        echo "   • zsh-syntax-highlighting already installed"
    fi

    # Install zsh-autosuggestions
    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
        echo "   • Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" --quiet
    else
        echo "   • zsh-autosuggestions already installed"
    fi
fi

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