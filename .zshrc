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
	brew
	macos
	docker
	docker-compose
	tmux
	extract
	yarn
	dotenv
	1password
	fzf
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
export COLORTERM=truecolor

alias vim="nvim"
alias n="nvim"
alias l="lsd"
alias ls="lsd"

export PATH="/usr/local/sbin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:$PATH"

[ -f ~/.env ] && source ~/.env
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

source <(fzf --zsh)
source <(tms --generate zsh)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/nick/.google-cloud-sdk/path.zsh.inc' ]; then . '/Users/nick/.google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/nick/.google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/nick/.google-cloud-sdk/completion.zsh.inc'; fi

bindkey -s ^f "tms\n"
