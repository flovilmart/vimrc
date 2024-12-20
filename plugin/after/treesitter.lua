local nvim_ts_loaded, nvim_ts = pcall(function() return require'nvim-treesitter' end)
if not nvim_ts_loaded then
  return
end

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "ruby", "typescript", "javascript", "go", "lua", "vim", "query", "vimdoc", "c", "rust", "nu" },

  sync_install = true,
  auto_install = false,

  highlight = {
    enable = true,

    additional_vim_regex_highlighting = false,
  },
  -- OPTIONAL!! These enable ts-specific textobjects.
  -- So you can hit `yaf` to copy the closest function,
  -- `dif` to clear the content of the closest function,
  -- or whatever keys you map to what query.
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        -- For example:
        -- Nushell only
        ["aP"] = "@pipeline.outer",
        ["iP"] = "@pipeline.inner",

        -- supported in other languages as well
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["aC"] = "@conditional.outer",
        ["iC"] = "@conditional.inner",
        ["iS"] = "@statement.inner",
        ["aS"] = "@statement.outer",
      }, -- keymaps
    }, -- select
  }, --
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.ejs = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
    files = { "src/parser.c" },
    requires_generate_from_grammar = true,
  },
  filetype = "ejs",
}

parser_config.nu = {
  install_info = {
    url = "https://github.com/nushell/tree-sitter-nu",
    files = { "src/parser.c", "src/scanner.c" },
    branch = "main",
  },
  filetype = "nu",
}
vim.treesitter.language.register("html", "ejs")
