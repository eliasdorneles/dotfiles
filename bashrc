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

export EDITOR="nvim -p"

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
	kill -9 "$pid"
	echo "slaughtered."
}

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support
if [ "$TERM" != "dumb" ] && [ "$TERM" != "emacs" ] && [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
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
[ -f /etc/bash_completion ] && source /etc/bash_completion

alias pbcopy='xclip -selection clipboard -in'
alias pbpaste='xclip -selection clipboard -out'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

ls_modified_files(){
    echo $(
    (git ls-files --modified --others --exclude-standard $(git rev-parse --show-toplevel)
    git diff --cached --name-only --relative .) | sort | uniq)
}
ls_files_with_conflicts(){
    git diff --name-only --diff-filter=U --relative .
}
ls_recently_committed(){
    git show --name-only --oneline $1 --relative . | egrep -v "^[a-z0-9]+ "
}

edit_modified_files(){
    $EDITOR $(ls_modified_files)
}
edit_files_with_conflicts(){
    $EDITOR $(ls_files_with_conflicts)
}
edit_recently_committed(){
    $EDITOR $(ls_recently_committed)
}
alias em=edit_modified_files
alias ec=edit_files_with_conflicts
alias er=edit_recently_committed

_git_switch (){ __gitcomp_nl "$(__git_refs)"; }


# Replace current editing line with eval'd echo, via C-t
_replace() { READLINE_LINE="$(eval echo -n "$READLINE_LINE")"; }
bind -m emacs -x '"\C-t": _replace'


time_curl() {
    curl -o /dev/null --silent --write-out "namelookup:%{time_namelookup} connect:%{time_connect} appconnect:%{time_appconnect} pretransfer:%{time_pretransfer} redirect:%{time_redirect} starttransfer:%{time_starttransfer} total:%{time_total}\n" "$@";
}

# my tiny implementation of virtualenvwrapper
mkvenv() {
    [ -n "$1" ] || { echo "Usage: mkvenv VENV_NAME"; return; }
    venv_dir="$HOME/.virtualenvs/$1"
    [ -d "$venv_dir" ] && { echo "$venv_dir already exists, skipping..."; return; }
    python3 -m venv "$venv_dir"
    source "$venv_dir/bin/activate"
}

lsvenv() {
    /bin/ls ~/.virtualenvs | cat
}

rmvenv() {
    [ -n "$1" ] || { echo "Usage: rmvenv VENV_NAME"; return; }
    venv_dir="$HOME/.virtualenvs/$1"
    [ -d "$venv_dir" ] || { echo "$venv_dir does not exist, skipping..."; return; }
    rm -rf "$venv_dir"
}

workon() {
    if [ -n "$1" ]; then
        venv_dir="$HOME/.virtualenvs/$1"
    else
        # if no given virtualenv name, assume "venv" in current dir
        if [ -d venv ]; then
            venv_dir="venv"
        else
            echo "Usage: workon VENV_NAME"
            return
        fi
    fi
    [ -d "$venv_dir" ] || { echo "$venv_dir does not exist, skipping..."; return; }
    source "$venv_dir/bin/activate"
}

mkvenv-project() {
    mkvenv $(basename $(pwd))
}

workon-project() {
    workon $(basename $(pwd))
}

mktmpenv() {
    tmp_venv_dir=$(mktemp -d /tmp/venv-XXXX)
    python3 -m venv "$tmp_venv_dir"
    source "$tmp_venv_dir/bin/activate"
    cd "$VIRTUAL_ENV"
}

destroy_venv() {
    if [ -z "$VIRTUAL_ENV" ]; then
        echo "Not inside a virtualenv, exiting"
        return
    fi
    if [ ! -d "$VIRTUAL_ENV" ]; then
        echo "'$VIRTUAL_ENV' is not a virtualenv, exiting"
        return
    fi
    if [ ! -f "$VIRTUAL_ENV/bin/activate" ]; then
        echo "'$VIRTUAL_ENV' is not a virtualenv, exiting"
        return
    fi
    echo Running: rm -rf "$VIRTUAL_ENV"
    rm -rf "$VIRTUAL_ENV"
    echo Done
    deactivate
}

alias vim=nvim

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
