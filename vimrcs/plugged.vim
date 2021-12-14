set nocompatible

call plug#begin('~/.vim/plugged')

  " Look and feel
  Plug 'altercation/vim-colors-solarized'
  Plug 'sheerun/vim-wombat-scheme'
  Plug 'tpope/vim-vinegar'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Searching
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'airblade/vim-gitgutter'

  " Language support
  " Plug 'sheerun/vim-polyglot'
  Plug 'dense-analysis/ale'
  " disable if nvim
  if has('nvim')
    Plug 'neovim/nvim-lspconfig'
  else
    Plug 'neovim/nvim-lspconfig' Plug 'neoclide/coc.nvim', {'branch': 'release' }
  endif
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'

  " Additional features
  Plug 'mg979/vim-visual-multi'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'ryanoasis/vim-devicons'
  Plug 'vim-test/vim-test'
  Plug 'preservim/vimux'
  Plug 'jebaum/vim-tmuxify'
  Plug 'jgdavey/tslime.vim'

  " Syntax coloring
  " Plug 'ap/vim-css-color'
  Plug 'cespare/vim-toml', { 'branch': 'main' }

call plug#end()
