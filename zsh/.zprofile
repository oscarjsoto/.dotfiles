#!/bin/zsh

#                             ______ _____ _    _
#                            |___  // ____| |  | |
#                               / /| (___ | |__| |
#                              / /  \___ \|  __  |
#                             / /__ ____) | |  | |
#                            /_____|_____/|_|  |_|
#
#                               For Login Shells

# =============================================================================
#                                Path Settings
# =============================================================================

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/app:$PATH

export VISUAL=vim
export EDITOR="$VISUAL"
