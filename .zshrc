export DOTFILES=$HOME/.dotfiles

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# Aliases
source $HOME/.aliases

# Asdf
. $HOME/.asdf/asdf.sh
