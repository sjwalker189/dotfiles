# source ~/.local/share/omakub/defaults/bash/rc

export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export GTK_THEME=Adwaita-dark

. "$HOME/.deno/env"
. "$HOME/.cargo/env"
. "$HOME/.local/share/swiftly/env.sh"

PATH="$HOME/.cargo/bin:$PATH"
PATH="/usr/local/go/bin:$PATH"
PATH="$HOME/go/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
PATH="$HOME/.fnm:$PATH"

export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

export PATH="$PATH:/home/swalker/.cache/rebar3/bin"
export PATH="$PATH:/home/swalker/.local/share/coursier/bin"
export PATH="$PATH:/home/swalker/.local/share/JetBrains/Toolbox/scripts"
export PATH="$PATH:/home/swalker/.turso"
export PATH="$PATH:/home/swalker/aviat/bin"

# dune
source $HOME/.local/share/dune/env/env.bash

alias ll='ls -lah --color'
alias lg='lazygit'
alias nah='git reset --hard HEAD; git clean -df'
alias n='nvim'
alias nvim-update='nvim --headless "+Lazy! sync" +qa'
alias nr='npm run'

alias pa='php artisan'
alias cr='composer run'

alias kt='colorScheme toggle'

eval "$(fnm env --use-on-cd)"
eval "$(/usr/bin/mise activate bash)"

function test_undercurl() {
	printf "\x1b[58;2;255;0;0m\x1b[4msingle\x1b[21mdouble\x1b[60mcurly\x1b[61mdotted\x1b[62mdashed\x1b[0m"singledoublecurlydotteddashed~
}

function resource() {
	source $HOME/.bashrc
}

function composite() {
	picom --fade-in-step=1 --fade-out-step=1 --xrender-sync-fence --vsync --backend=glx --dithered-present &
}

export PATH="/home/swalker/.pixi/bin:$PATH"
export PATH="/home/swalker/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/swalker/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

export FLYCTL_INSTALL="/home/swalker/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
