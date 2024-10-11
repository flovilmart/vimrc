require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "ruby", "typescript", "javascript", "go", "lua", "vim", "query", "vimdoc", "c", "rust" },

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,

    additional_vim_regex_highlighting = false,
  },
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
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "nu",
}
vim.treesitter.language.register("html", "ejs")
