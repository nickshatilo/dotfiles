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
	docker
	docker-compose
	tmux
	extract
	vi-mode
	yarn
	dotenv
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

[ -f ~/.env ] && source ~/.env
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/nick/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/nick/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/nick/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/nick/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
