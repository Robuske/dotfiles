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
    # TODO: Add way to create ~/.gitconfig.local
    ln -fs ${DIR}/gitconfig ~/.gitconfig
}

move_gemrc() {
    ln -fs ${DIR}/gemrc ~/.gemrc
}

brew_bundle() {
    cd $DIR || exit
    brew bundle
    cd ~/
}

install_asdf_ruby_plugin() {
    ln -fs ${DIR}/tool-versions ~/.tool-versions
    asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
    asdf install
}

install() {
    # install_brew
    # install_oh_my_zsh
    # move_zsh
    # move_gitconfig
    # move_gemrc
    brew_bundle
    # install_asdf_ruby_plugin
}

install
