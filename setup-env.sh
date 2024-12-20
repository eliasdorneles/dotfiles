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

download_file_if_needed(){
    target_dir="$1"
    url="$2"
    filename=$(basename $url)

    mkdir -p $target_dir
    if ! [ -f $target_dir/$filename ]; then
        wget $url -O $target_dir/$filename
    fi
}

# install powerline fonts and reload if needed
fonts_dir=~/.fonts
mkdir -p $fonts_dir
fontconfig_dir=~/.config/fontconfig/conf.d/

fontlist=$(ls ~/.fonts)
download_file_if_needed $fonts_dir \
    https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
download_file_if_needed $fontconfig_dir \
    https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf

if ! diff -q <(echo "$fontlist") <(ls $fonts_dir) >/dev/null; then
    echo -n "Reloading fonts... "
    fc-cache -vf $fonts_dir >/tmp/log-fc-cache.log
    echo "done"
    echo "You may need to restart X for the new fonts to be used"
fi


pip install --user python-dateutil matplotlib
