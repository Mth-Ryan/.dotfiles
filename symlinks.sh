#! /bin/bash

# File: symlinks.sh
# Author: Mateus Ryan <mthryan@protonmailcom>
# Licence: MIT

# Dotfiles folder
BASEDIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
DOTFILES=$BASEDIR

# Colors
GRE="\033[0;32m"
NOC="\033[0m"

# Creating folders
FOLDERS=$(find $DOTFILES -not -wholename "*/.git*" -type d \
    | sed -e "s#${DOTFILES}##g")

echo -e "${GRE}[1] Creating Folders...${NOC}\n"
for i in $FOLDERS; do
    FOLDER=$HOME$i
    echo "Creating $FOLDER if not exits"
    mkdir -p $FOLDER
done

# Link files
FILES=$(find $DOTFILES -not -wholename "*/.git*" -type f \
    | sed -e "s#${DOTFILES}/##g" \
    | grep "^\.")

echo -e "\n${GRE}[2] Creating symbolic links...${NOC}\n"
for j in $FILES; do
    FILE=$DOTFILES/$j
    LINK=$HOME/$j
    echo "Linking $FILE to $LINK"
    ln -sf $FILE $LINK
done
