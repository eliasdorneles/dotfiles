# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

[ -f ~/.sensible.bash ] && source ~/.sensible.bash


# sensible.bash overrides
shopt -u autocd 2> /dev/null
export HISTFILESIZE=
export HISTSIZE=
set +o noclobber

export EDITOR="vim -p"

# progress 13 40
# 13 of 40 (32.50%)
function progress(){
    if [ -z "$2" ]; then
        echo "Usage: progress CURRENT TOTAL"
        return
    fi
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
    NORMAL="\[\033[m\]"
    [ -f /etc/bash_completion.d/git-prompt ] && . /etc/bash_completion.d/git-prompt
    PROMPT_COMMAND='__git_ps1 "${VIRTUAL_ENV:+[$GRAY`basename $VIRTUAL_ENV`${NORMAL}] }${debian_chroot:+($debian_chroot)}${GREEN}\u${CYAN}@${BLUE}\h${CYAN}:${YELLOW}\w${NORMAL}" "\n\\\$ "'
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

# don't write pyc files by default
export PYTHONDONTWRITEBYTECODE=1
[ -f ~/.pythonrc ] && export PYTHONSTARTUP=~/.pythonrc

# disable terminal locking
bind -r '\C-s'
stty -ixon
alias reset='reset; stty -ixon'

export PATH=~/bin:~/.local/bin:$PATH

copy() {
    xclip -in -selection clipboard
}

copyn() {
    tr -d '\n' | xclip -in -selection clipboard
}

edit_modified_files(){
    $EDITOR $(
    (git ls-files --modified --others --exclude-standard $(git rev-parse --show-toplevel)
    git diff --cached --name-only --relative .) | sort | uniq)
}
edit_files_with_conflicts(){
    $EDITOR $(git diff --name-only --diff-filter=U --relative .)
}
edit_recently_committed(){
    $EDITOR $(git show --name-only --oneline --relative . | egrep -v "^[a-z0-9]+ ")
}
alias em=edit_modified_files
alias ec=edit_files_with_conflicts
alias er=edit_recently_committed
gm(){ EDITOR=gvim edit_modified_files $@; }
gc(){ EDITOR=gvim edit_files_with_conflicts $@; }
gr(){ EDITOR=gvim edit_recently_committed $@; }

_git_switch (){ __gitcomp_nl "$(__git_refs)"; }


# Replace current editing line with eval'd echo, via C-t
_replace() { READLINE_LINE="$(eval echo -n "$READLINE_LINE")"; }
bind -m emacs -x '"\C-t": _replace'
