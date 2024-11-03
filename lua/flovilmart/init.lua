local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

  -- Style and coloring
  Plug ('altercation/vim-colors-solarized')
  Plug ('sheerun/vim-wombat-scheme')
  Plug ('Tsuzat/neosolarized.nvim')
  Plug ('vim-airline/vim-airline')
  Plug ('vim-airline/vim-airline-themes')

  --" TreeSitter: Code parsing
  Plug ('nvim-treesitter/nvim-treesitter', { ['do'] = vim.fn['TSUpdate'] })
  Plug ('nvim-treesitter/playground')

  --" Git
  Plug ('tpope/vim-fugitive')
  Plug ('tpope/vim-rhubarb')
  Plug ('airblade/vim-gitgutter')

  -- Language support
  Plug ('dense-analysis/ale')

  -- LSP support, completion and snippets
  Plug ('neovim/nvim-lspconfig')

  Plug ('hrsh7th/nvim-cmp')
  Plug ('hrsh7th/cmp-nvim-lsp')
  Plug ('hrsh7th/cmp-buffer')
  Plug ('hrsh7th/cmp-path')
  Plug ('hrsh7th/cmp-cmdline')
  Plug ('hrsh7th/vim-vsnip')

  Plug ('github/copilot.vim')
  Plug ('olimorris/codecompanion.nvim')


  -- Debugger
  Plug('mfussenegger/nvim-dap')
  Plug('mxsdev/nvim-dap-vscode-js')
  Plug('rcarriga/nvim-dap-ui')
  Plug('nvim-neotest/nvim-nio')

  -- Rust
  Plug ('simrat39/rust-tools.nvim')

  -- Java
  Plug ('mfussenegger/nvim-jdtls')

  -- Rails
  Plug ('tpope/vim-rails')

  -- Navigation
  Plug ('nvim-lua/plenary.nvim')
  Plug ('nvim-telescope/telescope.nvim')
  Plug ('nvim-telescope/telescope-file-browser.nvim')


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

  Plug ('iamcco/markdown-preview.nvim', {
    ['do'] = function() vim.fn["mkdp#util#install"]() end,
    ['for'] = {'markdown', 'vim-plug'} })

vim.call('plug#end')
