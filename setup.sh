#!/bin/bash

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"  # dossier du script

echo_info() {
    echo "\033[1;34m[INFO]\033[0m $1"
}

echo_success() {
    echo "\033[1;32m[SUCCESS]\033[0m $1"
}

echo_error() {
    echo "\033[1;31m[ERROR]\033[0m $1"
}

install_dependencies() {
    echo_info "Install : fish, neovim, kitty"

    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install -y fish neovim kitty git curl
    elif command -v brew &> /dev/null; then
        brew install fish neovim kitty git curl
    elif command -v pacman &> /dev/null; then
        sudo pacman -Syu --noconfirm fish neovim kitty git curl
    else
        echo_error "Unknown package manager"
        exit 1
    fi

    # installation de starship
    echo_info "Install : starship"
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    if [ $? -eq 0 ]; then
        echo_success "Starship installed"
    else
        echo_error "Starship installation failed"
        exit 1
    fi
}

copy_configs() {
    echo_info "copying dotfiles"

    mkdir -p ~/.config

    # fish
    if [ -d "$REPO_DIR/fish" ]; then
        rm -rf ~/.config/fish
        cp -r "$REPO_DIR/fish" ~/.config/
        echo_success "fish config pasted"
    fi

    # nvim
    if [ -d "$REPO_DIR/nvim" ]; then
        rm -rf ~/.config/nvim
        cp -r "$REPO_DIR/nvim" ~/.config/
        echo_success "nvim config pasted"
    fi

    # kitty
    if [ -d "$REPO_DIR/kitty" ]; then
        rm -rf ~/.config/kitty
        cp -r "$REPO_DIR/kitty" ~/.config/
        echo_success "kitty config pasted"
    fi

    # starship
    if [ -d "$REPO_DIR/starship" ]; then
        rm -rf ~/.config/starship
        cp -r "$REPO_DIR/starship" ~/.config/
        echo_success "starship configs pasted"
    elif [ -f "$REPO_DIR/starship.toml" ]; then
        cp "$REPO_DIR/starship.toml" ~/.config/
        echo_success "starship file pasted"
    fi
}

main() {
    install_dependencies
    copy_configs
    clear
    echo_success "applied"
}

main

