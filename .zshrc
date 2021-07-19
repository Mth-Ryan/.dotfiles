export DOTFILES=$(dirname "$(readlink -f $HOME/.zshrc)")

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Aliases
source $HOME/.aliases

# Asdf
source $HOME/.asdf/asdf.sh

# Rustup
source $HOME/.cargo/env

# Go
export GOPATH=$HOME/.go
export GOBIN=$GOPATH/bin

# Starship
export STARSHIP_CONFIG=$HOME/.config/starship/config.toml
eval "$(starship init zsh)"
