local set = vim.opt

set.guifont="Fira Code:h14,Hack:h14,Source Code Pro:h15,Menlo:h15"
set.undodir="~/.config/nvim/temp_dirs/undodir_nvim"

set.background = dark
set.clipboard = "unnamed"
set.so = 7
set.langmenu = 'en_US.UTF-8'
set.shell = os.getenv("SHELL")
set.number = true
set.cmdheight = 1
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
vim.o.laststatus = 3

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
  set nofoldenable


  highlight clear SignColumn
  highlight SignColumn ctermbg=none
  highlight GitGutterAdd ctermfg=2 ctermbg=none
  highlight GitGutterChange ctermfg=3 ctermbg=none
  highlight GitGutterDelete ctermfg=1 ctermbg=none
  highlight GitGutterChangeDelete ctermfg=4 ctermbg=none

  map <leader>e :e! ~/.config/nvim<cr>

  autocmd Filetype typescript,javascript,c,cpp,rust,python setlocal foldmethod=expr
  autocmd Filetype typescript,javascript,c,cpp,rust,python setlocal foldexpr=nvim_treesitter#foldexpr()
]]

return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000,
    config = function()
      require("catppuccin").setup {
          custom_highlights = function(colors)
              return {
                  WinSeparator = { fg = colors.blue},
              }
          end
      }
      vim.cmd [[silent! colorscheme catppuccin-macchiato]]
    end
  },
  { 'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          theme = 'nord',
          section_separators = '',
          component_separators = '',
        },
        sections = {
          lualine_b = {
            {}
          },
          lualine_c = {
            {
              'filename',
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
            }
          },
          lualine_x = {'lsp_status', 'filetype'},
        }
      }
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' } }

}
