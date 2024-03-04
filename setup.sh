brew install neovim tmux zsh
chsh -s /opt/homebrew/bin/zsh

# Install zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Link
ln -s $(pwd)/.tmux.conf $HOME/.tmux.conf

mkdir -p $HOME/.config/nvim
ln -F -s $(pwd)/nvim $HOME/.config/

ln -s $(pwd)/.zshrc $HOME/.zshrc
