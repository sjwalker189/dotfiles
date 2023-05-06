# Rust
PATH=$HOME/.cargo/env:PATH;

# PHP
PATH=$HOME/.config/composer/vendor/bin:$PATH

# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Node version manager
PATH=$HOME/.fnm:$PATH;
eval "$(fnm env --use-on-cd)"

# Better bash experience
eval "$(starship init bash)"