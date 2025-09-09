#!/bin/bash

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"  # dossier du script

echo_info() {
    echo -e "\033[1;34m[INFO]\033[0m $1"
}

echo_success() {
    echo -e "\033[1;32m[SUCCESS]\033[0m $1"
}

echo_error() {
    echo -e "\033[1;31m[ERROR]\033[0m $1"
}

install_dependencies() {
    echo_info "Installation des packages fish, neovim, kitty, starship"

    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install -y fish neovim kitty starship git
    elif command -v brew &> /dev/null; then
        brew install fish neovim kitty starship git
    elif command -v pacman &> /dev/null; then
        sudo pacman -Syu --noconfirm fish neovim kitty starship git
    else
        echo_error "Gestionnaire de paquets non supporté. Installe les dépendances manuellement."
        exit 1
    fi

    echo_success "Dépendances installées."
}

copy_configs() {
    echo_info "Copie des dotfiles"

    mkdir -p ~/.config

    # fish
    if [ -d "$REPO_DIR/fish" ]; then
        rm -rf ~/.config/fish
        cp -r "$REPO_DIR/fish" ~/.config/
        echo_success "Configuration fish copiée."
    fi

    # nvim
    if [ -d "$REPO_DIR/nvim" ]; then
        rm -rf ~/.config/nvim
        cp -r "$REPO_DIR/nvim" ~/.config/
        echo_success "Configuration nvim copiée."
    fi

    # kitty
    if [ -d "$REPO_DIR/kitty" ]; then
        rm -rf ~/.config/kitty
        cp -r "$REPO_DIR/kitty" ~/.config/
        echo_success "Configuration kitty copiée."
    fi

    # starship
    if [ -d "$REPO_DIR/starship" ]; then
        rm -rf ~/.config/starship
        cp -r "$REPO_DIR/starship" ~/.config/
        echo_success "Configurations starship copiées."
    elif [ -f "$REPO_DIR/starship.toml" ]; then
        cp "$REPO_DIR/starship.toml" ~/.config/
        echo_success "Fichier starship.toml copié."
    fi
}

main() {
    install_dependencies
    copy_configs
    echo_success "Config appliquée"
}

main

