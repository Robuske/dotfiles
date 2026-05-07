#!/usr/bin/env bash

set -e  # Exit immediately if a command exits with a non-zero status
set -u  # Treat unset variables as an error

DIR=$HOME/dotfiles

log() {
    echo "[INFO] $1"
}

create_symlink() {
    ln -fs "$1" "$2"
}

install_brew() {
    if ! command -v brew &>/dev/null; then
        log "Installing Homebrew..."

        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        log "Finished Homebrew installation."
    else
        log "Homebrew is already installed. Skipping."
    fi
}

install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        log "Installing Oh My Zsh..."

        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

        log "Finished Oh My Zsh installation."
    else
        log "Oh My Zsh is already installed. Skipping."
    fi
}

move_zsh() {
    log "Setting up Zsh configuration..."

    create_symlink "${DIR}/zsh/zshrc" "$HOME/.zshrc"
    create_symlink "${DIR}/zsh/zprofile" "$HOME/.zprofile"

    log "Finished setting up Zsh configuration."
}

move_gitconfig() {
    log "Setting up Git configuration..."

    # TODO: Add way to create $HOME/.gitconfig.local
    create_symlink "${DIR}/gitconfig" "$HOME/.gitconfig"

    log "Finished setting up Git configuration."
}

move_gemrc() {
    log "Setting up Gem configuration..."

    create_symlink "${DIR}/gemrc" "$HOME/.gemrc"

    log "Finished setting up Gem configuration."
}

brew_bundle() {
    log "Running Homebrew bundle..."

    brew bundle --file="${DIR}/Brewfile"

    log "Finished Homebrew bundle."
}

install_asdf_plugins() {
    log "Setting up ASDF plugins..."

    create_symlink "${DIR}/tool-versions" "$HOME/.tool-versions"
    create_symlink "${DIR}/asdfrc" "$HOME/.asdfrc"

    asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
    asdf plugin add java https://github.com/halcyon/asdf-java.git
    asdf install

    log "Finished setting up ASDF plugins."
}

install() {
    log "Starting install..."

    install_brew
    install_oh_my_zsh
    # Needs way to reload shell
    move_zsh
    move_gitconfig
    move_gemrc
    # Needs way to reload shell
    brew_bundle
    # Needs way to reload shell
    install_asdf_plugins
    # Needs way to reload shell

    log "Instalation completed successfully!"
}

install
