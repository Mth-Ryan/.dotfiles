export DOTFILES=$(dirname "$(readlink -f $HOME/.zshrc)")

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="macovsky"

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Aliases
source $HOME/.aliases

# Rustup
source $HOME/.cargo/env

# Go
export GOPATH=$HOME/.go
export GOBIN=$GOPATH/bin

# less command highlight
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '
