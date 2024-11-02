local set = vim.opt

set.guifont="Fira Code:h14,Hack:h14,Source Code Pro:h15,Menlo:h15"
set.undodir="~/.config/nvim/temp_dirs/undodir_nvim"

set.background = dark
set.clipboard = "unnamed"
set.so = 7
set.langmenu = 'en_US.UTF-8'
set.shell = '/bin/zsh'
set.number = true
set.cmdheight = 2
set.whichwrap = 'b,s,<,>,[,],h,l'
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.showmatch = true
set.magic = true
set.mat = 2
set.tm=500
set.ffs=unix,dos,mac
set.expandtab = true
set.shiftwidth = 2
set.tabstop = 2
set.lbr = true
set.tw = 500  -- textwidth
set.wrap = true
set.ai = true
set.si = true

vim.g.solarized_termcolors = 256
vim.g.solarized_termtrans = 1
vim.g.netrw_liststyle = 0
vim.g.netrw_banner = 0
-- vim.g.netrw_sortsequence = "[\/]$,*"
vim.g.user_zen_mode = 'a'


vim.cmd [[
  filetype plugin on
  filetype indent on
  syntax on
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
  set noswapfile

  highlight clear SignColumn
  highlight SignColumn ctermbg=none
  highlight GitGutterAdd ctermfg=2 ctermbg=none
  highlight GitGutterChange ctermfg=3 ctermbg=none
  highlight GitGutterDelete ctermfg=1 ctermbg=none
  highlight GitGutterChangeDelete ctermfg=4 ctermbg=none

  map <leader>e :e! ~/.config/nvim<cr>

  colorscheme NeoSolarized
]]

-- vim.g.airline_theme = 'solrarized'
-- vim.g.airline_solarized_bg='dark'
-- vim.g["airline#extensions#ale#enabled"] = 0
vim.g["airline#extensions#nvimlsp#enabled"] = 1


local NeoSolarized = require("NeoSolarized")

NeoSolarized.setup {
  style = "dark", -- "dark" or "light"
  transparent = true, -- true/false; Enable this to disable setting the background color
}
