
# install stuff if not installed
brew install neovim tmux zsh alacritty zsh-vi-mode

# chsh to zsh if not already
if [ $SHELL != '/bin/zsh' ]; then
	chsh -s /bin/zsh
fi

# Install oh-my-zsh if not installed
if [ ! -d $HOME/.oh-my-zsh ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
	echo "oh-my-zsh already installed"
fi

git clone https://github.com/jeffreytse/zsh-vi-mode \
  $ZSH_CUSTOM/plugins/zsh-vi-mode

if [ ! -L $HOME/.zshrc ]; then
	ln -s $(pwd)/.zshrc $HOME/.zshrc
else
	echo ".zshrc already linked"
fi

# Install TPM if not installed 
if [ ! -d $home/.tmux/plugins/tpm ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
	echo "TPM already installed"
fi

# Link if not already linked
if [ ! -L $HOME/.tmux.conf ]; then
	ln -s $(pwd)/.tmux.conf $HOME/.tmux.conf
else
	echo ".tmux.conf already linked"
fi

mkdir -p $HOME/.config
mkdir -p $HOME/.config/nvim

if [ ! -L $HOME/.config/nvim ]; then
	ln -F -s $(pwd)/nvim $HOME/.config
else
	echo "nvim already linked"
fi

if [ ! -L $HOME/.config/.alacritty.toml ]; then
	mkdir -p $HOME/.config/alacritty
	ln -s $(pwd)/alacritty.toml $HOME/.config/alacritty/alacritty.toml
else
	echo ".alacritty.yml already linked"
fi
