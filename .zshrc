export DOTFILES=$(dirname "$(readlink -f $HOME/.zshrc)")

export ZSH=$HOME/.zsh
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt prompt_subst

# Theme
source $ZSH/themes/code.zsh

# Plugins
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration

# Aliases
source $HOME/.aliases

# Rustup
# WARNING: Currently using arch's rustup
#source $HOME/.cargo/env

# Go
export GOPATH=$HOME/.go
export GOBIN=$GOPATH/bin

# less command highlight
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '
