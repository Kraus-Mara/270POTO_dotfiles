#!/bin/bash

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo_info() {
  echo "\033[1;34m[INFO]\033[0m $1"
}

echo_success() {
  echo "\033[1;32m[SUCCESS]\033[0m $1"
}

echo_error() {
  echo "\033[1;31m[ERROR]\033[0m $1"
}

install_dependencies_on_ubuntu() {
  echo_info "Installing fish and kitty from apt and neovim from snap"

  if command -v apt &>/dev/null; then
    sudo apt update
    sudo apt install -y fish kitty git curl unzip
    sudo snap install neovim --classic
  elif command -v brew &>/dev/null; then
    brew install fish neovim kitty git curl
  elif command -v pacman &>/dev/null; then
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

install_dependencies_on_wsl() {
  echo_info "Installing fish and wezterm from apt and neovim from snap"
  if command -v apt &>/dev/null; then
    sudo apt update
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
    sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
    sudo apt install -y fish wezterm git curl unzip
    sudo snap install neovim --classic
  elif command -v brew &>/dev/null; then
    brew install fish neovim kitty git curl
  elif command -v pacman &>/dev/null; then
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
  echo_info "Installing the FiraCode Nerd Font"

  FONT_DIR="$HOME/.local/share/fonts"
  mkdir -p "$FONT_DIR"
  cd "$FONT_DIR" || exit 1

  # FiraCode NF
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
  if command -v fc-cache &>/dev/null; then
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

  if wsl {
    # wezterm
    if [ -d "$REPO_DIR/wezterm" ]; then
      rm -rf ~/.wezterm.lua
      cp -r "$REPO_DIR/wezterm" ~/
      echo_success "wezterm config pasted"
    fi
  }
  else {
    # kitty
    if [ -d "$REPO_DIR/kitty" ]; then
      rm -rf ~/.config/kitty
      cp -r "$REPO_DIR/kitty" ~/.config/
      echo_success "kitty config pasted"
    fi
  }

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
  if choice "Are you running this script on WSL? y/N" N; then
  install_dependencies_on_ubuntu
  else { install_dependencies_on_wsl }
  fi
  install_nerdfont
  copy_configs
  clear
  echo_success "Setup applied, run starp -l to see the available profiles"
}

main
