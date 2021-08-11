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

# Ubuntu version
SYSTEM=$(cat /etc/os-release | grep "^ID=" | cut -d '=' -f 2)
VERSION=$(cat /etc/lsb-release | grep "RELEASE" | cut -d '=' -f 2)

if [ $SYSTEM = "ubuntu" ]; then
    UBVERSION=$VERSION
elif [ $SYSTEM = "elementary" ]; then
    if [ $VERSION = 6 ]; then
        UBVERSION=20.04
    else
        UBVERSION=18.04
    fi
fi


# System dependencies
PACKAGES=$(sed ':a;N;$!ba;s/\n/ /g' $DOTFILES/packages)

echo -e "${GRE}[1] Installing System the dependencies...${NOC}\n"
sudo apt update
sudo apt install -y $PACKAGES

echo -e "\n${BLU}[1.1] PowerShell repository${NOC}\n"
wget -O "/tmp/microsoftrepo.deb" \
    "https://packages.microsoft.com/config/ubuntu/$UBVERSION/packages-microsoft-prod.deb"
sudo dpkg -i "/tmp/microsoftrepo.deb"

echo -e "\n${BLU}[1.2] Installing PowerShell${NOC}\n"
sudo apt update
sudo add-apt-repository -y universe
sudo apt install -y powershell

echo -e "\n${BLU}[1.3] Installing Hyper terminal${NOC}\n"
curl -s "https://api.github.com/repos/vercel/hyper/releases/latest" \
| grep "browser_download_url.*amd64.deb" \
| cut -d '"' -f 4 \
| wget -O "/tmp/hyper.deb" -i -
sudo dpkg -i "/tmp/hyper.deb"

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

# Vim Plug
echo -e "\n${GRE}[4] Installing Vim Plug...${NOC}\n"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#Neovim
echo -e "\n${GRE}[5] Building Neovim...${NOC}\n"
git clone https://github.com/neovim/neovim /tmp/neovim
cd /tmp/neovim
make -j4
sudo make install
pip3 install neovim
cd $DOTFILES
