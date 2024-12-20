nmap = function(key, cmd, opts, comment)
  opts.desc = comment
  vim.api.nvim_set_keymap("n", key, cmd, opts or {})
end

nmap("<leader>=", "gg=G", { silent = true }, "Reindent")
nmap("<leader>w", ":w!<cr>", { silent = true }, "Save")
nmap("<leader>q", ":q<cr>", { silent = true }, "Close buffer")

return {}
