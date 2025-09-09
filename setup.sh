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
        sudo apt install -y fish neovim kitty git curl unzip
    elif command -v brew &> /dev/null; then
        brew install fish neovim kitty git curl
    elif command -v pacman &> /dev/null; then
        sudo pacman -Syu --noconfirm fish neovim kitty git curl unzip
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

install_nerdfont() {
    echo_info "Install: Nerd Font (FiraCode)"

    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"
    cd "$FONT_DIR" || exit 1

    # Download the latest FiraCode Nerd Font directly
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"

    echo_info "Downloading FiraCode Nerd Font..."
    curl -LO "$FONT_URL"
    if [ $? -ne 0 ]; then
        echo_error "Failed to download Nerd Font"
        return 1
    fi

    echo_info "Extracting..."
    unzip -o FiraCode.zip
    rm FiraCode.zip

    # update font cache (Linux)
    if command -v fc-cache &> /dev/null; then
        fc-cache -fv
    fi

    echo_success "Nerd Font installed"
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
    install_nerdfont
    copy_configs
    clear
    echo_success "Setup applied, run starp -l to see the available profiles"
}

main

