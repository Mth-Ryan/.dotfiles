export DOTFILES=$(dirname "$(readlink -f $HOME/.zshrc)")

export ZSH=$HOME/.zsh

# Theme
source $ZSH/themes/code.zsh

# Plugins
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

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
