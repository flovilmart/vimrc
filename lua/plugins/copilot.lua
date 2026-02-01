
vim.cmd [[
  let g:copilot_filetypes = {
    \ '*': v:true,
    \ 'codecompanion': v:false,
    \ }
]]

return {
  'zbirenbaum/copilot.lua',
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end
}
