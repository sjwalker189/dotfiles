export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

export GTK_THEME=Adwaita-dark

# Tools
PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

# Rust
. "$HOME/.cargo/env"
PATH="$HOME/.cargo/bin:$PATH"

# Go
PATH="/usr/local/go/bin:$PATH"
PATH="$HOME/go/bin:$PATH"

# PHP
PATH="$HOME/.config/composer/vendor/bin:$PATH"


# Node
PATH="$HOME/.fnm:$PATH"
eval "$(fnm env --use-on-cd --shell=bash)"

# Fly path
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

#
# Aliases
#

# General 
alias ll='ls -lah --color'

# PHP/Laravel
alias pa='php artisan'
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

# Docker
alias ld='lazydocker'

# Git
alias lg="lazygit"
alias gp="git pull"
alias gc="git commit -m"
alias gs="git switch"
alias nah="git reset --hard HEAD; git clean -df"

# Neovim
alias n='nvim'
alias nvim-update='nvim --headless "+Lazy! sync" +qa'

# Node
alias nr='npm run'
alias ni="npm install"
alias nci="npm ci"

# Aviat
alias aviat_mount='sudo mount.cifs -o user=swalker,vers=2.0 //nz-fs/common $HOME/aviat/drive/'
alias aviat_unmount='sudo umount $HOME/aviat/drive'


function test_undercurl() {
printf "\x1b[58;2;255;0;0m\x1b[4msingle\x1b[21mdouble\x1b[60mcurly\x1b[61mdotted\x1b[62mdashed\x1b[0m"singledoublecurlydotteddashed~
}

# Shell
# History control
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=32768
HISTFILESIZE="${HISTSIZE}"

# Autocompletion
source /usr/share/bash-completion/bash_completion

if command -v fzf &> /dev/null; then
  source /usr/share/bash-completion/completions/fzf
  source /usr/share/doc/fzf/examples/key-bindings.bash
fi

# inputrc
set meta-flag on
set input-meta on
set output-meta on
set convert-meta off
set completion-ignore-case on
set completion-prefix-display-length 2
set show-all-if-ambiguous on
set show-all-if-unmodified on

# Arrow keys match what you've typed so far against your command history
"\e[A": history-search-backward
"\e[B": history-search-forward
"\e[C": forward-char
"\e[D": backward-char

# Immediately add a trailing slash when autocompleting symlinks to directories
set mark-symlinked-directories on

# Do not autocomplete hidden files unless the pattern explicitly begins with a dot
set match-hidden-files off

# Show all autocomplete results at once
set page-completions off

# If there are more than 200 possible completions for a word, ask to show them all
set completion-query-items 200

# Show extra file information when completing, like `ls -F` does
set visible-stats on

$if Bash
  # Be more intelligent when autocompleting by also looking at the text after
  # the cursor. For example, when the current line is "cd ~/src/mozil", and
  # the cursor is on the "z", pressing Tab will not autocomplete it to "cd
  # ~/src/mozillail", but to "cd ~/src/mozilla". (This is supported by the
  # Readline used by Bash 4.)
  set skip-completed-text on

  # Coloring for Bash 4 tab completions.
  set colored-stats on
$endif

#prompt

# Technicolor dreams
force_color_prompt=yes
color_prompt=yes

# Simple prompt with path in the window/pane title and carat for typing line
PS1=$'\uf0a9 '
PS1="\[\e]0;\w\a\]$PS1"
