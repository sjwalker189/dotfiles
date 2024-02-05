export EDITOR="$(which nvim)"

. "$HOME/.cargo/env"
PATH="$HOME/.cargo/bin:$PATH"
PATH="/usr/local/go/bin:$PATH"
PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.config/composer/vendor/bin:$PATH"

export DENO_INSTALL="/home/swalker/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export FLYCTL_INSTALL="/home/swalker/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

eval "$(fnm env --use-on-cd)"
eval "$(starship init bash)"

alias e='exit'
alias c='clear'
alias n='nvim'
alias lg='lazygit'
alias pa='php artisan'
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
alias nah='git reset --hard HEAD; git clean -df'
# Neovim
alias nvim-update='nvim --headless "+Lazy! sync" +qa'

# Aviat
alias vpn='bash ~/dev/vpn/vpn.sh'
alias aviat_mount='sudo mount.cifs -o user=swalker,vers=2.0 //nz-fs/common $HOME/aviat/drive/'
alias aviat_unmount='sudo umount $HOME/aviat/drive'

alias ai='ollama run codellama'
