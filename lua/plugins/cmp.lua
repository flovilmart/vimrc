-- Setup nvim-cmp.
return {
  'saghen/blink.cmp',
  dependencies = { "saghen/blink.compat", "giuxtaposition/blink-cmp-copilot" },

  version = "1.*",
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enasbled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      -- preset = 'super-tab',
      preset = 'default',
      ['<Enter>'] = { 'select_and_accept', 'fallback' },
      ['<Tab>'] = { 'insert_next', 'fallback' },
      ['<S-Tab>'] = { 'insert_prev', 'fallback' }
    },
    sources = {
      default = { "copilot", "lsp", "path", "snippets", "buffer" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          async = true,
        },
      },
    },
  }
}
