export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

export GTK_THEME=Adwaita-dark
# Rust
. "$HOME/.cargo/env"
PATH="$HOME/.cargo/bin:$PATH"

# Go
PATH="/usr/local/go/bin:$PATH"
PATH="$HOME/go/bin:$PATH"

# Swift
PATH="$HOME/swift-6.0.1/usr/bin:$PATH"

export PATH=$HOME/.cache/rebar3/bin:$PATH

PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
PATH="$HOME/.config/composer/vendor/bin:$PATH"
PATH="$HOME/.fnm:$PATH"

# Fly path
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

eval "$(fnm env --use-on-cd)"
# eval "$(starship init bash)"

# General 
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

# Node
alias nr='npm run'

# Aviat
alias aviat_mount='sudo mount.cifs -o user=swalker,vers=2.0 //nz-fs/common $HOME/aviat/drive/'
alias aviat_unmount='sudo umount $HOME/aviat/drive'


function test_undercurl() {
printf "\x1b[58;2;255;0;0m\x1b[4msingle\x1b[21mdouble\x1b[60mcurly\x1b[61mdotted\x1b[62mdashed\x1b[0m"singledoublecurlydotteddashed~
}
