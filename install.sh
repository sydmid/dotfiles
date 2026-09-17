#!/usr/bin/env bash

function check_prog() {
    if ! hash "$1" > /dev/null 2>&1; then
        echo "Command not found: $1. Aborting..."
        exit 1
    fi
}

check_prog stow
check_prog curl
check_prog git

echo "Setting up dotfiles..."
mkdir -p "$HOME/.config"

# Submodules
echo "Updating git submodules (nvim)..."
git submodule update --init --recursive

# OS Detection
OS="$(uname -s)"
echo "Detected OS: $OS"

# Packages common to both Linux and macOS
COMMON_PACKAGES=(
    "git"
    "mpv"
    "nvim"
    "scripts"
    "zsh"
)

# Packages that are mostly for Linux graphical environments (you can adjust as needed)
LINUX_PACKAGES=(
    "dolphin"
    "dunst"
    "i3"
    "imwheel"
    "kitty"
    "picom"
    "rofi"
    "sublime3"
    "sxhkd"
    "vscode"
    "windows"
    "xdg"
)

# Install common packages
for pkg in "${COMMON_PACKAGES[@]}"; do
    if [ -d "$pkg" ]; then
        echo "Stowing $pkg..."
        stow --adopt -vSt "$HOME" --no-folding "$pkg"
    fi
done

# Install OS-specific packages
if [ "$OS" = "Linux" ]; then
    echo "Installing Linux-specific dotfiles..."
    # Legacy HOME folder
    if [ -d "HOME" ]; then
        echo "Stowing HOME..."
        stow --adopt -vSt "$HOME" "HOME"
    fi
    for pkg in "${LINUX_PACKAGES[@]}"; do
        if [ -d "$pkg" ]; then
            echo "Stowing $pkg..."
            if [ "$pkg" = "imwheel" ]; then
                stow --adopt -vSt "$HOME" "$pkg"
            else
                stow --adopt -vSt "$HOME" --no-folding "$pkg"
            fi
        fi
    done
fi

echo "Done!"
