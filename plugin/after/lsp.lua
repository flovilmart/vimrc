local lspconfig_loaded, nvim_lsp= pcall(function() return require'lspconfig' end)
if not lspconfig_loaded then
  return
end

local lsp_common = require('lsp_common')

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "ts_ls", "solargraph", "pyright", "bashls" }
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
	  on_attach = lsp_common.on_attach,
	  flags = {
	    debounce_text_changes = 150,
	  },
    capabilities = capabilities,
  }
end

-- GOPls support
nvim_lsp.gopls.setup {
  cmd = {"gopls", "serve"},
  on_attach = lsp_common.on_attach,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        on_attach = lsp_common.on_attach,
        settings = {
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                assist = {
                  importGranularity = "module",
                  importPrefix = "by_self",
                },
                cargo = {
                  loadOutDirsFromCheck = true
                },
                procMacro = {
                  enable = true
                },
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
