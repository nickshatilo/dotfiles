export ZVM_INIT_MODE=sourcing

export ZSH="$HOME/.oh-my-zsh"
export LC_ALL=en_US.UTF-8
export LC_LANG=en_US.UTF-8

ZSH_THEME="gnzh"

plugins=(
	git
	colorize
	pip
	python
	docker
	docker-compose
	tmux
	extract
	yarn
	dotenv
	1password
	fzf
)

if [[ "$OSTYPE" == darwin* ]]; then
	plugins+=(brew macos)
else
	plugins+=(zsh-vi-mode)
fi

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
export COLORTERM=truecolor

alias vim="nvim"
alias n="nvim"
alias l="lsd"
alias ls="lsd"

export PATH="/usr/local/sbin:$PATH"

if [[ "$OSTYPE" == darwin* ]]; then
	export PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:$PATH"
fi

[ -f ~/.env ] && source ~/.env
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ "$OSTYPE" == darwin* ]]; then
	source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
fi

export PATH="$HOME/.local/bin:$PATH"
alias c="claude --dangerously-skip-permissions"
