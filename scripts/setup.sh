#!/bin/bash

sudo apt update
sudo apt upgrade
sudo apt install build-essential git file wget curl gcc openssl htop playerctl
sudo apt install zsh
sudo apt autoremove

# Configure GIT
echo 'Configuring Git'
echo '---------------'
git config --global user.name "Sam Walker"
git config --global --add --bool push.autoSetupRemote true

# Related deps
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz

echo 'Starship (better shell experience)'
echo '----------------------------------'
curl -sS https://starship.rs/install.sh | sh

# Install Rust
echo 'Installing Rust'
echo '---------------'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# TODO:
# resource bashrc (for cargo to be available)
# create and source .bash_profile

# Install wezterm terminal emulator
echo 'Installing Wezterm'
echo '------------------'
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update
sudo apt install wezterm

# Install Node
echo 'Installing Node'
echo '---------------'
cargo install fnm
fnm completions --shell
fnm install 21
npm install -g eslint @volar/vue-language-server # Required for neovim volar LSP plugin

# Install and configure neovim
echo 'Installing neovim'
echo '-----------------'
sudo apt install ripgrep fd-find xclip

# Install bob version manager for neovim
cargo install --git https://github.com/MordechaiHadad/bob.git
mkdir -p ~/.local/share/bash-completion/completions
bob complete bash >>~/.local/share/bash-completion/completions/bob
bob install nightly
bob use nightly

# Neovim LSP dependencies
cargo install stylua
