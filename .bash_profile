export EDITOR="$(which nvim)"

PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
PATH="$HOME/.config/composer/vendor/bin:$PATH"
PATH="$HOME/.fnm:$PATH"

# Rust
. "$HOME/.cargo/env"
PATH="$HOME/.cargo/bin:$PATH"

# Go
PATH="/usr/local/go/bin:$PATH"
PATH="$HOME/go/bin:$PATH"

# Fly path
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

eval "$(fnm env --use-on-cd)"
eval "$(starship init bash)"

# General 
alias wezterm='flatpak run org.wezfurlong.wezterm'
alias ll='ls -lah --color'

# PHP/Laravel
alias pa='php artisan'
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

# Git
alias lg='lazygit'
alias nah='git reset --hard HEAD; git clean -df'

# Neovim
alias n='nvim'
alias nvim-update='nvim --headless "+Lazy! sync" +qa'

# Aviat
alias aviat_mount='sudo mount.cifs -o user=swalker,vers=2.0 //nz-fs/common $HOME/aviat/drive/'
alias aviat_unmount='sudo umount $HOME/aviat/drive'

# LLM 
alias ai='ollama run codellama'
function cl() {
	eval "ollama run codellama 'You are an expert programmer that writes simple, concise code and explanations. $1'"
}

