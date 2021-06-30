#!/usr/bin/env bash

function check_prog() {
    if ! hash "$1" > /dev/null 2>&1; then
        echo "Command not found: $1. Aborting..."
        exit 1
    fi
}

check_prog stow
check_prog curl

mkdir -p "$HOME/.config"

stow --adopt -vSt "$HOME"              HOME
stow --adopt -vSt "$HOME"              imwheel
stow --adopt -vSt "$HOME" --no-folding zsh
stow --adopt -vSt "$HOME" --no-folding i3
stow --adopt -vSt "$HOME" --no-folding kitty
stow --adopt -vSt "$HOME" --no-folding picom
stow --adopt -vSt "$HOME" --no-folding dunst
stow --adopt -vSt "$HOME" --no-folding nvim
stow --adopt -vSt "$HOME" --no-folding rofi
stow --adopt -vSt "$HOME" --no-folding git
stow --adopt -vSt "$HOME" --no-folding vscode
stow --adopt -vSt "$HOME" --no-folding scripts
stow --adopt -vSt "$HOME" --no-folding sublime3
stow --adopt -vSt "$HOME" --no-folding sxhkd
stow --adopt -vSt "$HOME" --no-folding mpv
stow --adopt -vSt "$HOME" --no-folding dolphin
stow --adopt -vSt "$HOME" --no-folding xdg
