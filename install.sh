#!/bin/sh
set -e

cd ~/.vim_runtime
if [ -f ~/.vimrc ];
then
  cat ~/.vimrc > ~/.vimrc.bak
  echo "Backed up ~/.vimrc in ~/.vimrc.bak"
  rm ~/.vimrc
fi
ln -s ~/.vim_runtime/vimrcs/vimrc ~/.vimrc

echo "Installed the Ultimate Vim configuration successfully! Enjoy :-)"
