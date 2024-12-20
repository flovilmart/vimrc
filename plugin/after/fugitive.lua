-- Custom Browse handler for nushell so we can use `open` properly
-- Netrw fails in those cases
local open = function(args)
  os.execute("open ".. args.args)
end
-- Browser Open is checked here: https://github.com/tpope/vim-fugitive/blob/fcb4db52e7f65b95705aa58f0f2df1312c1f2df2/autoload/fugitive.vim#L7422
vim.api.nvim_create_user_command(
    "Browse", -- string
    open,  -- string or Lua function
    { nargs = 1, desc = "Open Browser with ^open in nushell", bang = true }
)

vim.keymap.set("v", "<leader>g", ":GBrowse<CR>", { silent = true }, "Git browse")
