#!/bin/bash

VIMVER=$(vim --version | head -n1 | sed -r 's/^.*([0-9]+\.[0-9]+).*$/\1/')

if awk "BEGIN{exit ${VIMVER} < 7.4 ? 0 : 1}"; then
  ln -s ~/.vim/vimrc ~/.vimrc
fi  

mkdir -p ~/.vim/bundle
cd ~/.vim/bundle
if [ ! -e Vundle.vim/.git/config ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git Vundle.vim
fi

find ~/.vim/bundle -mindepth 1 -maxdepth 1 -type d -exec /bin/bash -c 'cd {}; git pull' \;

vim +PluginInstall +qall

