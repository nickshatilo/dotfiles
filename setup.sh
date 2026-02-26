#!/usr/bin/env bash
set -e

OS="$(uname -s)"

# Install packages
if [[ "$OS" == "Darwin" ]]; then
	brew install neovim tmux zsh zsh-vi-mode cmake lsd btop ripgrep tmux-sessionizer fzf
	brew install --cask ghostty nikitabobko/tap/aerospace
elif [[ "$OS" == "Linux" ]]; then
	sudo apt-get update
	sudo apt-get install -y zsh tmux fzf ripgrep curl git gcc g++

	# Install neovim 0.10+ from GitHub release (apt version is often too old)
	if ! nvim --version 2>/dev/null | head -1 | grep -qE 'v0\.(1[0-9]|[2-9])'; then
		echo "Installing Neovim 0.10 from GitHub..."
		curl -Lo /tmp/nvim.tar.gz https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz
		sudo tar -C /opt -xzf /tmp/nvim.tar.gz
		sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
		rm /tmp/nvim.tar.gz
	fi

	# Install lsd from GitHub release if not present
	if ! command -v lsd &>/dev/null; then
		echo "Installing lsd..."
		LSD_VERSION="v1.1.5"
		curl -Lo /tmp/lsd.deb "https://github.com/lsd-rs/lsd/releases/download/${LSD_VERSION}/lsd_${LSD_VERSION#v}_amd64.deb"
		sudo dpkg -i /tmp/lsd.deb
		rm /tmp/lsd.deb
	fi
fi

# chsh to zsh if not already
if [[ "$SHELL" != */zsh ]]; then
	chsh -s "$(which zsh)"
fi

# Install oh-my-zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
	echo "oh-my-zsh already installed"
fi

# Install zsh-vi-mode as oh-my-zsh custom plugin (Linux only; macOS uses brew)
if [[ "$OS" == "Linux" ]]; then
	ZVM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-vi-mode"
	if [ ! -d "$ZVM_DIR" ]; then
		git clone https://github.com/jeffreytse/zsh-vi-mode "$ZVM_DIR"
	else
		echo "zsh-vi-mode already installed"
	fi
fi

# Link .zshrc
if [ ! -L "$HOME/.zshrc" ]; then
	rm -f "$HOME/.zshrc"
	ln -s "$(pwd)/.zshrc" "$HOME/.zshrc"
else
	echo ".zshrc already linked"
fi

# Install TPM if not installed
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
	echo "TPM already installed"
fi

# Link .tmux.conf
if [ ! -L "$HOME/.tmux.conf" ]; then
	ln -s "$(pwd)/.tmux.conf" "$HOME/.tmux.conf"
else
	echo ".tmux.conf already linked"
fi

# Link nvim config
mkdir -p "$HOME/.config"
if [ ! -L "$HOME/.config/nvim" ]; then
	rm -rf "$HOME/.config/nvim"
	ln -s "$(pwd)/nvim" "$HOME/.config/nvim"
else
	echo "nvim already linked"
fi

# Link ghostty config
mkdir -p "$HOME/.config/ghostty"
if [ ! -L "$HOME/.config/ghostty/config" ]; then
	ln -s "$(pwd)/ghostty" "$HOME/.config/ghostty/config"
else
	echo "ghostty config already linked"
fi

# macOS-only: aerospace
if [[ "$OS" == "Darwin" ]]; then
	if [ ! -L "$HOME/.aerospace.toml" ]; then
		ln -s "$(pwd)/aerospace.toml" "$HOME/.aerospace.toml"
	else
		echo ".aerospace.toml already linked"
	fi
fi

# Install tmux plugins
if [ -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
	"$HOME/.tmux/plugins/tpm/bin/install_plugins"
fi

echo "Done! Restart your shell or run: exec zsh"
