set nocompatible

call plug#begin('~/.config/nvim/plugged')

  " Look and feel
  Plug 'altercation/vim-colors-solarized'
  Plug 'sheerun/vim-wombat-scheme'
  Plug 'tpope/vim-vinegar'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'github/copilot.vim'

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
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'simrat39/rust-tools.nvim'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-file-browser.nvim'
  else
    Plug 'neoclide/coc.nvim', {'branch': 'release' }
  endif
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'

  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

  " Additional features
  Plug 'mg979/vim-visual-multi'
  Plug 'ryanoasis/vim-devicons'
  Plug 'vim-test/vim-test'

  " tmux integration
  if executable("tmux")
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'preservim/vimux'
    Plug 'jebaum/vim-tmuxify'
    Plug 'jgdavey/tslime.vim'
  end

  Plug 'leafgarland/typescript-vim'

  " Syntax coloring
  " Plug 'ap/vim-css-color'
  Plug 'cespare/vim-toml', { 'branch': 'main' }
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'jelera/vim-javascript-syntax'
  Plug 'tpope/vim-markdown'

call plug#end()
