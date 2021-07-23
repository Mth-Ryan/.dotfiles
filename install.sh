#! /bin/bash

# File: install.sh
# Author: Mateus Ryan <mthryan@protonmailcom>
# Licence: MIT

BASEDIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
DOTFILES=$BASEDIR

# Colors
CYA='\033[1;36m'
NOC='\033[0m'

echo -e "\n${CYA}Installing Dependencies${NOC}\n"
source $DOTFILES/dependencies.sh $DOTFILES

echo -e "\n${CYA}Creating the Symbolic Links${NOC}\n"
source $DOTFILES/symlinks.sh $DOTFILES