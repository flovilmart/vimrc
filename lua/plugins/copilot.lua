
return {
  'github/copilot.vim',
  config = function()
    vim.keymap.set("i", "<C-n>", "<Plug>(copilot-next)", { silent = true }, "Copilot next")
  end
}
