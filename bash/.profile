#!/bin/bash

#  ____           _____ _    _
# |  _ \   /\    / ____| |  | |
# | |_) | /  \  | (___ | |__| |
# |  _ < / /\ \  \___ \|  __  |
# | |_) / ____ \ ____) | |  | |
# |____/_/    \_\_____/|_|  |_|
#
# For Login shells

# ===============================================
#     Bash Settings for Login Shells
# ===============================================

# If running bash load non-login bash settings
alias tobash="exec /bin/bash"
[ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

# Set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.local/app" ] && PATH="$HOME/.local/app:$PATH"

# Add XDG Base Directory Specification Settings
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"


# ===============================================
#     Ocaml Settings
# ===============================================

# if command -v ocaml &> /dev/null; then
#    eval `opam config env`
#     . "$HOME/.cargo/env"
# fi
