#!/bin/bash
echo 'Updating Submodules'
git submodule update --init

echo 'Linking files'
here=$( cd "$(dirname "${BASE_SOURCE[0]}" )" && pwd)
for file in .gitconfig .vimrc .vim .zshenv .zshrc .tmux.conf; do
    if [[ $file == '.gitconfig' && $USER != 'ellioth' && $USER != 'elliot' ]]; then
        echo "Not linking personal file $file"
    else
        if [[ $(readlink -f $HOME/$file) != $(readlink -f $here/$file) ]]; then
            ln -i -s -T $here/$file $HOME/$file
            echo "linked $file"
        fi
    fi
done
