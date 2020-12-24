set nocompatible

call plug#begin('~/.vim_runtime/plugged')

  " Look and feel
  Plug 'altercation/vim-colors-solarized'
  Plug 'preservim/nerdtree'
  
  " Searching
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  
  " Language support
  Plug 'sheerun/vim-polyglot'
  Plug 'neoclide/coc.nvim', {'branch': 'release' }
  Plug 'tpope/vim-rails'

  " Additional features
  Plug 'terryma/vim-multiple-cursors'
  Plug 'christoomey/vim-tmux-navigator'

call plug#end()

