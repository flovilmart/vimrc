print "Loading telescope"
local telescope = require("telescope")
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
        return {"--hidden", "-S", "-F"}
      end
    },
  },
}

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

print "Setup telescope"
