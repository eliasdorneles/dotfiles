# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

[ -f ~/.sensible.bash ] && source ~/.sensible.bash

# don't put duplicate lines in the history
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries
export HISTCONTROL=ignoreboth
# ... and unlimited history
export HISTFILESIZE=
export HISTSIZE=

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# tell history to consider what I've already typed
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

# "repeat" command.  Like:
#	repeat 10 echo foo
repeat() {
    local count="$1" i;
    shift;
    for i in $(seq 1 "$count");
    do
        eval "$@";
    done
}

# progress 13 40
# 13 of 40 (32.50%)
function progress(){
    awk "BEGIN { printf \"$1 of $2 (%.2f%%)\n\", 100 * $1 / $2 }" 
}

# psgrep firef   to check if firefox is running...
psgrep(){
	ps aux | grep $1 | grep -v grep
}
# ... and pskill firef   to kill it!
pskill(){
	local pid
	pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
	echo -n "killing $1 (process $pid)..."
	kill -9 $pid
	echo "slaughtered."
}

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
    *)
    ;;
esac

# enable color support
if [ "$TERM" != "dumb" ] && [ "$TERM" != "emacs" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls -F --color=auto'
    alias grep='grep --color=auto'
    # fancy prompt
    GREEN="\[\033[0;32m\]"
    CYAN="\[\033[0;36m\]"
    GRAY="\[\033[0;37m\]"
    BLUE="\[\033[0;34m\]"
    YELLOW="\[\033[0;33m\]"
    NORMAL="\[\033[m"
    export PS1="${debian_chroot:+($debian_chroot)}${GREEN}\u${CYAN}@${BLUE}\h${CYAN}:${YELLOW}\w${NORMAL}\n\$ "
fi

# some more ls aliases
alias l="ls -l "
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
# aliases to keep your life safer...
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
# load the rest of aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# load my environment specific variables:
[ -f ~/.myenv ] && . ~/.myenv

# load z script:
[ -f ~/bin/z.sh ] && . ~/bin/z.sh

export EDITOR=vim
export PATH=~/bin:~/.local/bin:$PATH

# disable terminal locking
bind -r '\C-s'
stty -ixon

