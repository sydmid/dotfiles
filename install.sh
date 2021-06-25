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

stow --adopt -vSt "$HOME"              kitty
stow --adopt -vSt "$HOME"              picom
stow --adopt -vSt "$HOME"              dunst
stow --adopt -vSt "$HOME"              git
stow --adopt -vSt "$HOME"              i3
stow --adopt -vSt "$HOME" --no-folding nvim
stow --adopt -vSt "$HOME"              rofi
stow --adopt -vSt "$HOME"              vscode
stow --adopt -vSt "$HOME"              xdg
stow --adopt -vSt "$HOME" --no-folding zsh
stow --adopt -vSt "$HOME" --no-folding sublime3
stow --adopt -vSt "$HOME"              sxhkd
stow --adopt -vSt "$HOME"              mpv
stow --adopt -vSt "$HOME"              dolphin
stow --adopt -vSt "$HOME"              HOME
