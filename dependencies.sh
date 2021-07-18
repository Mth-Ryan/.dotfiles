#! /bin/bash

# File: dependencies.sh
# Author: Mateus Ryan <mthryan@protonmailcom>
# Args: $1 Dotfiles folder
# Licence: MIT

# Dotfiles folder
DOTFILES=$1

# Colors
GRE='\033[0;32m'
BLU='\033[0;34m'
NOC='\033[0m'

# System dependencies
PACKAGES=$(sed ':a;N;$!ba;s/\n/ /g' $DOTFILES/packages)

echo -e "${GRE}[1] Installing System the dependencies...${NOC}\n"
sudo apt install -y $PACKAGES

echo -e "\n${GRE}[2] Cloning Oh-my-zsh and Asdf...${NOC}\n"

# Oh my Zsh
echo -e "\n${BLU}[2.1] Installing Oh My Zsh${NOC}\n"
curl -fsSL "https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh" | sh

# Zsh syntax highlighting
echo -e "\n${BLU}[2.2] Cloning Zsh syntax highlighting${NOC}\n"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# Zsh autosuggestions
echo -e "\n${BLU}[2.3] Cloning Zsh autosuggestions${NOC}\n"
git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Asdf
echo -e "\n${BLU}[2.4] Cloning Asdf${NOC}\n"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
git -C ~/.asdf checkout \
    "$(git -C ~/.asdf describe --abbrev=0 --tags)"

# Starship Prompt
echo -e "\n${GRE}[3] Installing Starship Prompt...${NOC}\n"
curl -fsSL https://starship.rs/install.sh | sh

# Vim Plug
echo -e "\n${GRE}[4] Installing Vim Plug...${NOC}\n"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

