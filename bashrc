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

# enable color support
if [ "$TERM" != "dumb" ] && [ "$TERM" != "emacs" ] && [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls -F --color=auto'
    alias grep='grep --color=auto'
    # uncomment if needing colors for other commands
    # GREEN="\[\033[0;32m\]"
    # RED="\[\033[0;31m\]"
    # MAGENTA="\[\033[0;35m\]"
    # CYAN="\[\033[0;36m\]"
    # GRAY="\[\033[0;37m\]"
    # BLUE="\[\033[0;34m\]"
    # YELLOW="\[\033[0;33m\]"
    # NORMAL="\[\033[m\]"
fi

# aliases to keep your life safer...
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
# load the rest of aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

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
    $EDITOR $(ls_recently_committed $1)
}
alias em=edit_modified_files
alias ec=edit_files_with_conflicts
alias er=edit_recently_committed

_git_switch (){ __gitcomp_nl "$(__git_refs)"; }

parse_docker_json_logs(){
    # parse docker logs in JSON format, outputting time and body (colored output if TTY)
    if [ -t 1 ]; then
        # we are writing to a terminal, so we can use colors
        cut -d'|' -f2 | grep '^ {' | jq -r '"[\(.Time)] \(.Body)"' | while IFS= read -r line; do
        # Extract timestamp and message
        timestamp=$(echo "$line" | sed 's/^\[\([^]]*\)\].*/\1/')
        message=$(echo "$line" | sed 's/^\[[^]]*\] //')
        printf "\033[95m[%s]\033[0m %s\n" "$timestamp" "$message"
    done
else
    # output to pipe/file - no colors
    cut -d'|' -f2 | grep '^ {' | jq -r '"[\(.Time)] \(.Body)"'
    fi
} 

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

poenv-destroy() {
    poetry env remove $(poetry env list | cut -d' ' -f1)
}

alias poenv-rm=poenv-destroy

pwgen(){
    # generate a random password of given size, default 20
    size=${1:-20}
    python3 -c "import random, string; print(''.join(random.choice(string.ascii_letters + string.digits) for x in range($size)))"
}

lastdl(){
    # show last N downloads, default 1
    n=1
    [ -n "$1" ] && n=$1
    /bin/ls --sort=time --escape ~/Downloads 2>/dev/null | head -n $n | while read f
    do
        echo "$HOME/Downloads/$f"
    done
}

alias vim=nvim

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# load my environment specific variables:
[ -f ~/.myenv ] && . ~/.myenv

if command -v zoxide &> /dev/null; then
    eval "$(zoxide init bash)"
fi

if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
