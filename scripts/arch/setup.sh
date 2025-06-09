#!/usr/bin/env bash

mkdir -p $HOME/dev
mkdir -p $HOME/work
mkdir -p $HOME/Downloads
mkdir -p $HOME/Documents
mkdir -p $HOME/Pictures/screenshots

sudo pacman -Syu \
	yay \
	base-devel \
	coreutils \
	man-db \
	unzip \
	git \
	lazygit \
	zsh \
	ripgrep \
	fd \
	neovim \
	hyprpaper \
	hypridle \
	hyprlock \
	waybar \
	brightnessctl
	
	
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

cargo install fnm
cargo install stylua

fnm install 24




