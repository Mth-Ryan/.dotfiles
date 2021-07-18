export DOTFILES=$HOME/.dotfiles

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
. $HOME/.asdf/asdf.sh

# Starship
export STARSHIP_CONFIG=$HOME/.config/starship/config.toml
eval "$(starship init zsh)"
