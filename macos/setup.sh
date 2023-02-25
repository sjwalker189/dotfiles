#!/bin/bash

# Hide "last login" line when starting a new terminal session
touch $HOME/.hushlogin

# Install IDE deps
brew install neovim
brew install ripgrep
