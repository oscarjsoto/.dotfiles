#!/bin/zsh

#                             ______ _____ _    _
#                            |___  // ____| |  | |
#                               / /| (___ | |__| |
#                              / /  \___ \|  __  |
#                             / /__ ____) | |  | |
#                            /_____|_____/|_|  |_|
#
#                            For Non-Login Shells

# =============================================================================
#                              ZAP Plugin Manager
# =============================================================================

[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-completions"
plug "romkatv/powerlevel10k"


# =============================================================================
#                          Power 10k Prompt Settings
# =============================================================================

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh


# =============================================================================
#                               General Settings
# =============================================================================

# Ensure system folders
mkdir -p "$HOME/.local/share/nano"
mkdir -p "$HOME/.cache/zsh"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.ssh"

## Remove beep sound when making a mistake
unsetopt BEEP

# History
HISTSIZE=5000000
SAVEHIST=5000000
HISTFILE=~/.history
setopt INC_APPEND_HISTORY   # History file is updated per command
setopt HIST_IGNORE_DUPS     # Do not record an event twice in a row
setopt HIST_IGNORE_SPACE    # Do not record an event starting with a space.
setopt HIST_FIND_NO_DUPS    # Do not display a previously found event.


# =============================================================================
#                                     fzf
# =============================================================================

if command -v fzf > /dev/null 2> /dev/null ; then
    source /usr/share/fzf/key-bindings.zsh
    # source /usr/share/fzf/completion.zsh
fi


# =============================================================================
#                            Auto Complete Settings
# =============================================================================

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

# Load and initialize the completion system
autoload -Uz compinit bashcompinit
compinit
bashcompinit


# =============================================================================
#                              Alias definitions
# =============================================================================

alias ls='exa --icons --group-directories-first'
alias ll='exa -alhg --icons --group-directories-first'
alias tree='exa --tree'

alias pull_history='fc -RI'

alias gh='cd ~/ohome'

alias cat='bat -pp'
alias less='bat --style=plain --paging=always'

alias mv='mv -i'
alias mkdir='mkdir -p'
alias cp='cp -i'
alias clip='xclip -sel clipboard'

alias tobash="sudo chsh $USER -s /bin/bash && exec /bin/bash"
alias tozsh="sudo chsh $USER -s /bin/zsh && exec /bin/zsh"
alias todash="sudo chsh $USER -s /bin/dash && exec /bin/dash"


# =============================================================================
#                                   VIM Mode
# =============================================================================

# bindkey -v
# export KEYTIMEOUT=1

# zmodload -i zsh/complist
# indkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char
# bindkey '^h' backward-delete-char

# ctrl-w removed word backwards
# bindkey '^w' backward-kill-word
#
# # Edit line in vim with ctrl-e:
# autoload edit-command-line; zle -N edit-command-line
# bindkey '^e' edit-command-line

# Yank to the system clipboard
# function vi-yank-xclip {
#     zle vi-yank
#    echo "$CUTBUFFER" | xclip -sel clipboard
# }
# zle -N vi-yank-xclip
# bindkey -M vicmd 'y' vi-yank-xclip
#
# # Change cursor shape for different vi modes.
# function zle-keymap-select {
#   if [[ ${KEYMAP} == vicmd ]] ||
#      [[ $1 = 'block' ]]; then
#     echo -ne '\e[1 q'
#   elif [[ ${KEYMAP} == main ]] ||
#        [[ ${KEYMAP} == viins ]] ||
#        [[ ${KEYMAP} = '' ]] ||
#        [[ $1 = 'beam' ]]; then
#     echo -ne '\e[5 q'
#   fi
# }
# zle -N zle-keymap-select
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


# =============================================================================
#                                 Keybindings
# =============================================================================

# NOTE: Find keybinding using cat

# Disable vim bindings (Since Editor is set to vim)
bindkey -e

# Fix keybinding
# bindkey "^[[H" beginning-of-line # ctrl-a
# bindkey "^[[F" end-of-line       # ctrl-e
# bindkey "^[[3~" delete-char      # ctrl-d

# Autosugest settings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^y' autosuggest-accept

bindkey "^[[Z" reverse-menu-complete # Shift Tab Reverse

# Quick reload
# bindkey -s '^x' "source ~/.zshrc^M"


# =============================================================================
#                             Syntax Highlighting
# =============================================================================

if [ -d "$ZAP_DIR/plugins/zsh-syntax-highlighting" ]; then 
    source "$ZAP_DIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi


# =============================================================================
#                                     TMUX
# =============================================================================

# if [[ -z "$TMUX" ]]; then
#     tmux attach || tmux new-session -c ~/ohome
# fi

# bindkey -s "^f" "tmux-sessionizer^M"


