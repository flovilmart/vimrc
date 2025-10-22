function config()
  local lsp_common = require('lsp_common')
  local nvim_lsp = vim.lsp.config

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = { "ts_ls", "pyright", "bashls", "nushell", "graphql" }
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp] =  {
  	  on_attach = lsp_common.on_attach,
  	  flags = {
  	    debounce_text_changes = 150,
  	  },
      capabilities = capabilities,
    }
    vim.lsp.enable(lsp)
  end

  nvim_lsp['solargraph'] = {
    on_attach = lsp_common.on_attach,
    settings = {
      solargraph = {
        diagnostics = true,
        completion = true
      }
    }
  }
  vim.lsp.enable('solargraph')

  -- GOPls support
  nvim_lsp['gopls'] = {
    cmd = {"gopls", "serve"},
    on_attach = lsp_common.on_attach,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = false, -- breaks current build FIXME
      },
    },
  }
  -- vim.lsp.enable('gopls')

  local rust_tools_ops = {
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

  -- require('rust-tools').setup(opts)
  local border = {
        {"🭽", "FloatBorder"},
        {"▔", "FloatBorder"},
        {"🭾", "FloatBorder"},
        {"▕", "FloatBorder"},
        {"🭿", "FloatBorder"},
        {"▁", "FloatBorder"},
        {"🭼", "FloatBorder"},
        {"▏", "FloatBorder"},
  }
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end
end

return {
  { 'neovim/nvim-lspconfig',
    config = config,
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'mfussenegger/nvim-jdtls' }
},
 --   { 'simrat39/rust-tools.nvim', }
}
