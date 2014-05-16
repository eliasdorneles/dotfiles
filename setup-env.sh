#!/bin/bash
# Script to setup my environment

absdirname(){
    (cd `dirname $1` 2>/dev/null && pwd || dirname $1)
}

cria_link(){
    f="$1"
    f2=${2:-$1}
    d=`absdirname $0`
    if [ -e "$HOME/$f" ]
    then
        echo "~/$f already exists, skipping..."
    else
        echo ln -s "$d/$f2" "$f"
        (cd && ln -s "$d/$f2" "$f")
    fi
}
cria_dotlink(){
    cria_link ".$1" "$1"
}

set -e

cria_dotlink screenrc
cria_dotlink mplayer
cria_dotlink gitconfig
cria_dotlink bashrc
cria_dotlink bash_aliases


cria_dotlink vimrc
cria_dotlink vim
if [ ! -d ~/.vim/bundle ]; then
	mkdir -p ~/.vim/bundle
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    echo "Vundle installed, please remember to run:"
    echo "    vim -c ':BundleInstall'"
fi

echo -n "Copying files to ~/bin... "
mkdir -p ~/bin
for i in bin/*; do
    cp "$i" ~/bin
done
echo done

if [ ! -f ~/bin/zz ]; then
    echo -n "Downloading zz ... "
    wget --quiet http://funcoeszz.net/funcoeszz -O ~/bin/zz && chmod u+x ~/bin/zz
    echo done
fi
