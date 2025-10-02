#!/bin/bash
# Script to setup my environment

absdirname(){
    (cd `dirname $1` 2>/dev/null && pwd || dirname $1)
}

create_abs_link(){
    local target="$1"
    local origin=${2:-$1}
    local d=$(absdirname $0)
    if (cd && test -e "$target");
    then
        echo "$target already exists, skipping..."
    else
        echo ln -sf "$d/$origin" "$target"
        (cd && ln -sf "$d/$origin" "$target")
    fi
}

create_abs_dotlink(){
    create_abs_link ".$1" "$1"
}

set -e

create_abs_dotlink screenrc
create_abs_dotlink pythonrc
create_abs_dotlink mplayer
create_abs_dotlink gitconfig
create_abs_dotlink gitignore_global
create_abs_dotlink bashrc
create_abs_dotlink bash_aliases
create_abs_dotlink sensible.bash
create_abs_dotlink pythonrc
create_abs_dotlink profile

if [ -d config ]; then
    mkdir -p ~/.config
    for f in config/*;
    do
        target=~/.config/$(basename $f)
        create_abs_link $target $f
    done
fi

# holds plug and my legacy vim settings not yet converted to Lua
create_abs_dotlink vim

echo -n "Copying files to ~/bin... "
mkdir -p ~/bin
(
cd bin;
for f in *; do
    target=~/bin/$f
    cmp --silent $f $target || cp $f $target
done
)
echo done
