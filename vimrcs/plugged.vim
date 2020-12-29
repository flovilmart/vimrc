set nocompatible

call plug#begin('~/.vim/plugged')

  " Look and feel
  Plug 'altercation/vim-colors-solarized'
  Plug 'preservim/nerdtree'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  
  " Searching
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  
  " Language support
  " Plug 'sheerun/vim-polyglot'
  Plug 'dense-analysis/ale'
  Plug 'neoclide/coc.nvim', {'branch': 'release' }
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'

  " Additional features
  Plug 'terryma/vim-multiple-cursors'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'ryanoasis/vim-devicons'

call plug#end()

