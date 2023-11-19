local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

  Plug ('altercation/vim-colors-solarized')
  Plug ('sheerun/vim-wombat-scheme')
  Plug ('tpope/vim-vinegar')

  Plug ('vim-airline/vim-airline')
  Plug ('vim-airline/vim-airline-themes')
  Plug ('github/copilot.vim')

  --" Searching
  Plug ( 'junegunn/fzf', { dir = '~/.fzf', ['do'] = vim.fn['fzf#install']})

  Plug ( 'junegunn/fzf.vim')

  --" TreeSitter: Code parsing
  Plug ('nvim-treesitter/nvim-treesitter', { ['do'] = vim.fn['TSUpdate'] })
  Plug ('nvim-treesitter/playground')

  --" Git
  Plug ('tpope/vim-fugitive')
  Plug ('tpope/vim-rhubarb')
  Plug ('airblade/vim-gitgutter')

  -- Language support
  --" Plug ('sheerun/vim-polyglot')
  Plug ('dense-analysis/ale')

  Plug ('neovim/nvim-lspconfig')
  Plug ('hrsh7th/cmp-nvim-lsp')
  Plug ('hrsh7th/cmp-buffer')
  Plug ('hrsh7th/cmp-path')
  Plug ('hrsh7th/cmp-cmdline')
  Plug ('hrsh7th/nvim-cmp')
  Plug ('hrsh7th/vim-vsnip')
  Plug ('simrat39/rust-tools.nvim')

  -- Java
  Plug ('mfussenegger/nvim-jdtls')

  Plug ('nvim-lua/plenary.nvim')
  Plug ('nvim-telescope/telescope.nvim')
  Plug ('nvim-telescope/telescope-file-browser.nvim')

  --. Plug ('vim-ruby/vim-ruby')
  Plug ('tpope/vim-rails')

  -- " Plug ('fatih/vim-go', { 'do': ':GoUpdateBinaries' }

  -- " Additional features
  Plug ('mg979/vim-visual-multi')
  Plug ('ryanoasis/vim-devicons')
  Plug ('vim-test/vim-test')

  -- " tmux integration
  if vim.fn.executable("tmux") then
    Plug ('christoomey/vim-tmux-navigator')
    Plug ('preservim/vimux')
    Plug ('jebaum/vim-tmuxify')
    Plug ('jgdavey/tslime.vim')
  end

  Plug ('leafgarland/typescript-vim')

  -- " Syntax coloring
  -- " Plug ('ap/vim-css-color')
  Plug ('cespare/vim-toml', { branch = 'main' })
  Plug ('peitalin/vim-jsx-typescript')
  Plug ('jelera/vim-javascript-syntax')
  Plug ('tpope/vim-markdown')

  Plug ('iamcco/markdown-preview.nvim', {
    ['do'] = function() vim.fn["mkdp#util#install"]() end,
    ['for'] = {'markdown', 'vim-plug'} })

vim.call('plug#end')
