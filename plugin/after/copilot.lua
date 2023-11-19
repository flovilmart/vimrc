local function inoremap(rhs, lhs, bufopts, desc)
  bufopts.desc = desc
  vim.keymap.set("i", rhs, lhs, bufopts)
end

inoremap("<C-n>", "<Plug>(copilot-next)", { silent = true }, "Copilot next")
