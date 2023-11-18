require('plugins.init')
vim.cmd('source ~/.config/nvim/vimrcs/basic.vim')

vim.g.mapleader = ","

require('plugins.lsp')
require('plugins.ale')
require('plugins.telescope')
require('plugins.treesitter')
require('plugins.vimtest')

vim.cmd('source ~/.config/nvim/vimrcs/extended.vim')

print "hello from init.lua"
