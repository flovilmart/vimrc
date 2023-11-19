
local function nmap(rhs, lhs, bufopts, desc)
  bufopts.desc = desc
  vim.keymap.set("n", rhs, lhs, bufopts)
end

local on_attach = function(client, bufnr)
  --Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  nmap('gD', vim.lsp.buf.declaration, bufopts, "Go to declaration")
  nmap('gd', vim.lsp.buf.definition, bufopts, "Go to definition")
  nmap('gi', vim.lsp.buf.implementation, bufopts, "Go to implementation")
  nmap('gr', vim.lsp.buf.references, bufopts, "Go to references")
  nmap('K', vim.lsp.buf.hover, bufopts, "Hover text")
  nmap('<space>k', vim.lsp.buf.signature_help, bufopts, "Show signature")
  nmap('<space>wa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
  nmap('<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
  nmap('<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts, "List workspace folders")
  nmap('<space>D', vim.lsp.buf.type_definition, bufopts, "Go to type definition")
  nmap('<space>rn', vim.lsp.buf.rename, bufopts, "Rename")
  nmap('<space>ca', vim.lsp.buf.code_action, bufopts, "Code actions")
  vim.keymap.set('v', "<space>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
    { noremap=true, silent=true, buffer=bufnr, desc = "Code actions" })
  nmap('<space>f', function() vim.lsp.buf.format { async = true } end, bufopts, "Format file")

  nmap('<space>e', vim.diagnostic.open_float, bufopts, "Open diagnostics")
  nmap('[d', vim.lsp.diagnostic.goto_prev, bufopts, "Go to previous diagnostic")
  nmap(']d', vim.lsp.diagnostic.goto_next, bufopts, "Go to next diagnostic")
  nmap('<space>q', vim.lsp.diagnostic.set_loclist, bufopts, "Set loclist")
end

local M = {}

M.on_attach = on_attach
M.nmap = nnoremap

return M
