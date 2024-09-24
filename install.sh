#!/usr/bin/env bash

DIR=~/.dotfiles

install_brew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_oh_my_zsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

move_zsh() {
    ln -fs ${DIR}/zsh/zshrc ~/.zshrc
    ln -fs ${DIR}/zsh/zprofile ~/.zprofile
}

move_gitconfig() {
    ln -fs ${DIR}/gitconfig ~/.gitconfig
}

install() {
    # install_brew
    # install_oh_my_zsh
    # move_zsh
    move_gitconfig
}

install
