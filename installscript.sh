#!/bin/bash

MACOS=false
if [ $OSTYPE = "darwin" ] ; then
    $MACOS=true
fi

if $MACOS; then
    echo 'MacOS Setup'
    # Hide "last login" line when starting a new terminal session
    touch $HOME/.hushlogin
    # Install homebrew
    # Install xcode
else 
    echo 'Linux Setup'
    sudo apt update
    sudo apt upgrade
    sudo apt install build-essential git file wget curl gcc
    sudo apt install zsh
    sudo apt autoremove
fi

# Configure GIT
echo 'Configuring Git'
echo '-------------'
git config --global user.name "Sam Walker"
git config --global --add --bool push.autoSetupRemote true


# Starship (Better Bash Experience)
curl -sS https://starship.rs/install.sh | sh

# Instal KIITY
echo 'Installing Kitty'
echo '----------------'
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
source ./kitty/dev

# Install Deno
echo 'Installing Deno'
echo '---------------'
curl -fsSL https://deno.land/x/install/install.sh | sh


# Install Node
echo 'Installing Node'
echo '---------------'
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell --force-install
fnm install
npm install -g yarn
npm install -g @volar/vue-language-server # Required for neovim volar LSP plugin


# Install Rust
echo 'Installing Rust'
echo '---------------'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y


# Install and configure neovim
echo 'Installing neovim' 
echo '-----------------'
if $MACOS; then
    brew install neovim
    brew instxall ripgrep
    brew install lazygit
    brew install fd
    brew install gnu-sed
else
    sudo apt install neovim ripgrep fd-find xclip

    # Related deps 
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
fi

source ./nvim/dev
