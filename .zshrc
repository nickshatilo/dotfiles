export ZVM_INIT_MODE=sourcing

export ZSH="$HOME/.oh-my-zsh"
export LC_ALL=en_US.UTF-8
export LC_LANG=en_US.UTF-8

ZSH_THEME="robbyrussell"

plugins=(
	git
	colorize
	pip
	python
	brew
	macos
	# docker
	# docker-compose
	tmux
	extract
	zsh-vi-mode
	yarn
	dotenv
	1password
	fzf
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
export SSH_KEY_PATH="~/.ssh/id_rsa.pub"
export COLORTERM=truecolor

alias vim="nvim"
alias n="nvim"

eval "$(rbenv init -)"
eval "$(nodenv init -)"

export PATH="/usr/local/sbin:$PATH"
export PATH="/Users/nick/Library/Python/3.9/bin:$PATH"

[ -f ~/.env ] && source ~/.env
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
