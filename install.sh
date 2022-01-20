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
[ -f ~/.config/nvim/init.vim ] || ln -s ~/.vim/vimrcs/vimrc ~/.config/nvim/init.vim



# Install Rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup install stable

rustup component add clippy

echo "Installed the Ultimate Vim configuration successfully! Enjoy :-)"
