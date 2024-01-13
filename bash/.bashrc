#!/bin/bash

#  ____           _____ _    _
# |  _ \   /\    / ____| |  | |
# | |_) | /  \  | (___ | |__| |
# |  _ < / /\ \  \___ \|  __  |
# | |_) / ____ \ ____) | |  | |
# |____/_/    \_\_____/|_|  |_|
#
# For Non-Login shells

# ===============================================
#     General Settings
# ===============================================

# If not running interactively then do nothing
case $- in *i*) ;; *) return;; esac

# Ensure system folders
mkdir -p "$HOME/.local/share/nano"
mkdir -p "$HOME/.cache/bash"

# Bash History Setting
HISTFILE="$HOME/.cache/bash/bash_history"
HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend    # append to the history file

# Allow dynamic window resize
shopt -s checkwinsize

# Set terminal prompt color and text
export TERM=xterm-256color
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Enable color command prompts
if [ -x /usr/bin/dircolors ]; then
  # Complie Colors
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

  # Add Colors
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Disable Bell sound
set bell-style none

# Default editor
export EDITOR="nano"


# ===============================================
#     Auto complete
# ===============================================

# Auto completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous off'    # Turn menu on or off
bind 'set colored-stats On'
bind 'set colored-completion-prefix On'
bind 'set completion-query-items 1000'  # Max Results
shopt -s cdspell # Auto correct typos in cd

# Allow Regex Pattern Matching for files
shopt -s extglob


# ===============================================
#     Fzf Settings
# ===============================================

if command -v fzf &> /dev/null; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
fi


# ===============================================
#     Less Settings
# ===============================================

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)" # Better non-text input files
LESSHISTFILE="$HOME/.cache/lesshst"


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

  # Remove sudo file from home
  rm ~/.sudo_as_admin_successful
}


# ===============================================
#     Alias definitions.
# ===============================================

alias ls='ls -hN --color=auto --group-directories-first'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias cp='cp -i'
alias vim='nvim'
alias clip='xclip -sel clip'

alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias todash="sudo chsh $USER -s /bin/dash && echo 'Now log out.'"

# ===============================================
#     Keybindings
# ===============================================

bind 'TAB:menu-complete' # Tab
bind '"\e[Z":menu-complete-backward' # Shift tab
bind '"\e[A":history-search-backward' # Up arrow
bind '"\e[B":history-search-forward' # Down arrow
bind '"\e[1;5C":forward-word' # Ctrl right arrow
bind '"\e[1;5D":backward-word' # Ctrl left arrow
bind -x '"\C-f":"tmux-sessionizer"' # Ctrl F
bind -x '"\C-x":"source $HOME/.bashrc && source $HOME/.profile"' # Ctrl X

# ===============================================
#     Starship Settings
# ===============================================

eval "$(starship init bash)"


# ===============================================
#     Ocaml Settings
# ===============================================

if command -v ocaml &> /dev/null; then
    . "$HOME/.cargo/env"
    export PATH="/home/osoto/.cargo/bin:/home/osoto/.opam/default/bin:/home/osoto/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/mnt/c/xpressmp/bin:/mnt/c/xpressmp/workbench:/mnt/c/Python311/Scripts/:/mnt/c/Python311/:/mnt/c/Program Files (x86)/Common Files/Oracle/Java/javapath:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:/mnt/c/Windows/System32/OpenSSH/:/mnt/c/ProgramData/chocolatey/bin:/mnt/c/Program Files/Git/cmd:/mnt/c/Program Files/Microsoft VS Code/bin:/mnt/c/Program Files/dotnet/:/mnt/c/Program Files/MATLAB/R2022b/bin:/mnt/c/Program Files/starship/bin/:/mnt/c/Users/osoto/AppData/Roaming/nvm:/mnt/c/Program Files/nodejs:/mnt/c/texlive/2023/bin/windows:/mnt/c/Users/osoto/AppData/Local/Microsoft/WindowsApps:/mnt/c/Users/osoto/AppData/Roaming/nvm:/mnt/c/Program Files/nodejs:/snap/bin"
    export PATH="/home/osoto/.cargo/bin:/home/osoto/.opam/default/bin:/home/osoto/.local/bin:/home/osoto/.cargo/bin:/home/osoto/.opam/default/bin:/home/osoto/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/mnt/c/xpressmp/bin:/mnt/c/xpressmp/workbench:/mnt/c/Python311/Scripts/:/mnt/c/Python311/:/mnt/c/Program Files (x86)/Common Files/Oracle/Java/javapath:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:/mnt/c/Windows/System32/OpenSSH/:/mnt/c/ProgramData/chocolatey/bin:/mnt/c/Program Files/Git/cmd:/mnt/c/Program Files/Microsoft VS Code/bin:/mnt/c/Program Files/dotnet/:/mnt/c/Program Files/MATLAB/R2022b/bin:/mnt/c/Program Files/starship/bin/:/mnt/c/Users/osoto/AppData/Roaming/nvm:/mnt/c/Program Files/nodejs:/mnt/c/texlive/2023/bin/windows:/mnt/c/Users/osoto/AppData/Local/Microsoft/WindowsApps:/mnt/c/Users/osoto/AppData/Roaming/nvm:/mnt/c/Program Files/nodejs:/snap/bin"
fi
