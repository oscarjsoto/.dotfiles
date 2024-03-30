#!/bin/zsh

#  ______ _____ _    _
# |___  // ____| |  | |
#    / /| (___ | |__| |
#   / /  \___ \|  __  |
#  / /__ ____) | |  | |
# /_____|_____/|_|  |_|
#
# For Non-Login Shells

# ===============================================
#     ZAP Plugin manager
# ===============================================

[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-autosuggestions"
plug "romkatv/powerlevel10k"


# ===============================================
#     Power 10k Prompt Settings
# ===============================================

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Add terminal color
export TERM=xterm-256color


# ===============================================
#    General Settings
# ===============================================

# Ensure system folders
mkdir -p "$HOME/.local/share/nano"
mkdir -p "$HOME/.cache/zsh"

## Remove Beep
unsetopt BEEP

# Colored ls
alias ls='ls --color=auto'

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY HIST_IGNORE_DUPS

# History partial search | up and down
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search


# ===============================================
#     Nala Settings
# ===============================================

apt() {
  command nala "$@"
}

sudo() {
  if [ "$1" = "apt" ]; then
    shift
    command sudo nala "$@"
  else
    command sudo "$@"
  fi
}


# ===============================================
#    Auto Complete Settings
# ===============================================

# Load and initialize the completion system
# mkdir -p "$HOME/.cache/zsh"
autoload -Uz compinit
compinit -C -d "$HOME/.zcompdump"

# Options
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.
setopt ALWAYS_TO_END        # Move cursor to the end of a completed word.
setopt PATH_DIRS            # Perform path search even on command names with slashes.
setopt AUTO_MENU            # Show completion menu on a successive tab press.
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH     # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB        # Needed for file modification glob modifiers with compinit.
setopt MENU_COMPLETE        # Autoselect the first completion entry.
unsetopt FLOW_CONTROL       # Disable start/stop characters in shell editor.
# unsetopt AUTO_LIST          # Hide autocomplete menu
unsetopt pathdirs

#
# Match Settings
#

# Fuzzy match mistyped completions (Errors min 1 to max 7)
zstyle ':completion:*' completer _expand _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'
_comp_options+=(globdots)   # Include hidden files.

# Case-insensitive (all), partial-word, and then substring completion.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
unsetopt CASE_GLOB

# Use caching to make completion for commands such as dpkg and apt usable.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.cache/zsh/zcompcache"

#
# Style Settings
#

# Autocomplete menu style default
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Group matches and describe.
if [[ -o AUTO_LIST ]]; then
  zstyle ':completion:*:*:*:*:*' menu select
  zstyle ':completion:*:matches' group 'yes'
  zstyle ':completion:*:options' description 'yes'
  zstyle ':completion:*:options' auto-description '%d'
  zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
  zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
  zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
  zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
  zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
  zstyle ':completion:*' group-name ''
  zstyle ':completion:*' verbose yes
fi

# Directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true


# ===============================================
#     Alias definitions.
# ===============================================

# alias ls='ls -hN --color=auto'
alias ls='exa --icons'
alias ll='exa -alhg --icons'
alias tree='exa --tree'

alias gh='cd ~/ohome'

alias cat='bat -pp'
alias less='bat --style=plain --paging=always'

alias mv='mv -i'
alias mkdir='mkdir -p'
alias cp='cp -i'
# alias vim='nvim'
alias clip='xclip -sel clipboard'
# alias gcc='gcc -ansi -Wall -g -O0 -Wwrite-strings -Wshadow -pedantic-errors -fstack-protector-all -Wextra'

alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias todash="sudo chsh $USER -s /bin/dash && echo 'Now log out.'"


# ===============================================
#     Keybindings
# ===============================================

# Add fzf keybinds
if command -v fzf > /dev/null 2> /dev/null ; then
    source /usr/share/fzf/key-bindings.zsh
    # source /usr/share/fzf/completion.zsh
fi

bindkey -s "^f" "tmux-sessionizer^M"
bindkey "^[OA" up-line-or-beginning-search   # Up   arrow
bindkey "^[OB" down-line-or-beginning-search # Down arrow
bindkey "^[[Z" reverse-menu-complete # Shift Tab Reverse

# Quick Reload settings
# echo ZSHRC Reloaded
bindkey -s '^x' "source ~/.zshrc^M"

# ===============================================
#     Miscellaneous
# ===============================================

# NVM for Node.js
source /usr/share/nvm/init-nvm.sh
