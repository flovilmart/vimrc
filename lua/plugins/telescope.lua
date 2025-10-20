
function config_telescope()
  local function set_keymap(...) vim.api.nvim_set_keymap(...) end
  set_keymap("n", "<Leader>r", "<cmd>:Telescope grep_string<CR>", {noremap = true})
  set_keymap("n", "<Leader>f", "<cmd>:Telescope live_grep<CR>", {noremap = true})
  set_keymap("n", "<Leader>o", "<cmd>:Telescope find_files hidden=true<CR>", {noremap = true})
  set_keymap("n", ";", "<cmd>:Telescope buffers<CR>", {noremap = true})
  set_keymap("n", "-", "<cmd>:Telescope file_browser path=%:p:h hidden=false<CR>", {noremap = true})

  vim.g.fzf_history_dir = '~/.fzf_history/'
  vim.g.fzf_action = {
    ['ctrl-t'] = 'tab split',
    ['ctrl-i'] = 'split',
    ['ctrl-v'] = 'vsplit' }

  telescope = require('telescope')
  telescope.load_extension "file_browser"
  telescope.setup {
    defaults = {
      file_ignore_patterns = { "^.git/", "node_modules" },
      mappings = {
        i = {
          ['<C-p>'] = require("telescope.actions").cycle_history_next,
          ['<C-o>'] = require("telescope.actions").cycle_history_prev,
        },
      },
    },
    extensions = {
      file_browser = {
        theme = "dropdown",
      },
    },
    pickers = {
      buffers = {
        sort_lastused = true
      },
      live_grep = {
        additional_args = function(opts)
          return {"--hidden", "-i", "-F"}
        end
      },
    },
  }

  -- Launch telescope when opening nvim with a directory
  vim.cmd [[
    augroup ReplaceNetrw
        autocmd VimEnter * silent! autocmd! FileExplorer
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | call luaeval("require('telescope').extensions.file_browser.file_browser({cwd = _A})", argv()[0]) | endif
    augroup END
  ]]
end

return {
  {
    'nvim-lua/plenary.nvim',
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    config = config_telescope,
  }
}
