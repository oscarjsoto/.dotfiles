# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history.zsh_history

# Basic auto/tab complete:
ZSH_COMPDUMP=~/.cache/zsh/complition/.zcompdump
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Add global scripts to path
export PATH="$HOME/bin:$PATH"
export TMUX_CONFIG="$HOME/.config/tmux/.tmux.conf"


# Add fzf keybinds
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# Nala override
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

# Shortcut Keys
bindkey -s "^f" "tmux-sessionizer^M"
alias vim='nvim'
alias gcc='gcc -ansi -Wall -g -O0 -Wwrite-strings -Wshadow -pedantic-errors -fstack-protector-all -Wextra'
alias tmux='tmux -f $TMUX_CONFIG'


# Add terminal color
export TERM=xterm-256color
