# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# Ensure certain folders exists in home directory
mkdir -p "$HOME/.local/share/nano"
mkdir -p "$HOME/.cache/bash"


# History Setting
HISTFILE="$HOME/.cache/bash/bash_history"
HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend    # append to the history file

LESSHISTFILE="$HOME/.cache/lesshst"


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# Enable color for ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# Auto completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous off'


# Override apt with nala
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


# Fzf enabled
source /usr/share/doc/fzf/examples/key-bindings.bash


# Alias definitions.
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias vim='nvim'


# Keybindings
bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward'

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

bind '"\e[1;5C":forward-word'
bind '"\e[1;5D":backward-word'

bind -x '"\C-f":"tmux-sessionizer"'

# Starship
eval "$(starship init bash)"

# Ocaml
if command -v ocaml &> /dev/null; then
    . "$HOME/.cargo/env"
    export PATH="/home/osoto/.cargo/bin:/home/osoto/.opam/default/bin:/home/osoto/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/mnt/c/xpressmp/bin:/mnt/c/xpressmp/workbench:/mnt/c/Python311/Scripts/:/mnt/c/Python311/:/mnt/c/Program Files (x86)/Common Files/Oracle/Java/javapath:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:/mnt/c/Windows/System32/OpenSSH/:/mnt/c/ProgramData/chocolatey/bin:/mnt/c/Program Files/Git/cmd:/mnt/c/Program Files/Microsoft VS Code/bin:/mnt/c/Program Files/dotnet/:/mnt/c/Program Files/MATLAB/R2022b/bin:/mnt/c/Program Files/starship/bin/:/mnt/c/Users/osoto/AppData/Roaming/nvm:/mnt/c/Program Files/nodejs:/mnt/c/texlive/2023/bin/windows:/mnt/c/Users/osoto/AppData/Local/Microsoft/WindowsApps:/mnt/c/Users/osoto/AppData/Roaming/nvm:/mnt/c/Program Files/nodejs:/snap/bin"
    export PATH="/home/osoto/.cargo/bin:/home/osoto/.opam/default/bin:/home/osoto/.local/bin:/home/osoto/.cargo/bin:/home/osoto/.opam/default/bin:/home/osoto/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/mnt/c/xpressmp/bin:/mnt/c/xpressmp/workbench:/mnt/c/Python311/Scripts/:/mnt/c/Python311/:/mnt/c/Program Files (x86)/Common Files/Oracle/Java/javapath:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:/mnt/c/Windows/System32/OpenSSH/:/mnt/c/ProgramData/chocolatey/bin:/mnt/c/Program Files/Git/cmd:/mnt/c/Program Files/Microsoft VS Code/bin:/mnt/c/Program Files/dotnet/:/mnt/c/Program Files/MATLAB/R2022b/bin:/mnt/c/Program Files/starship/bin/:/mnt/c/Users/osoto/AppData/Roaming/nvm:/mnt/c/Program Files/nodejs:/mnt/c/texlive/2023/bin/windows:/mnt/c/Users/osoto/AppData/Local/Microsoft/WindowsApps:/mnt/c/Users/osoto/AppData/Roaming/nvm:/mnt/c/Program Files/nodejs:/snap/bin"
fi
