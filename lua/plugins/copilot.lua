
vim.cmd [[
  let g:copilot_filetypes = {
    \ '*': v:true,
    \ 'codecompanion': v:false,
    \ }
]]

return {
  'github/copilot.vim',
  config = function()
    vim.keymap.set("i", "<C-n>", "<Plug>(copilot-next)", { silent = true }, "Copilot next")
  end
}
