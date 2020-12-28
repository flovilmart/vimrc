#!/bin/sh
set -e

cd ~/.vim
if [ -f ~/.vimrc ];
then
  cat ~/.vimrc > ~/.vimrc.bak
  echo "Backed up ~/.vimrc in ~/.vimrc.bak"
  rm ~/.vimrc
fi
ln -s ~/.vim/vimrcs/vimrc ~/.vimrc

echo "Installed the Ultimate Vim configuration successfully! Enjoy :-)"
