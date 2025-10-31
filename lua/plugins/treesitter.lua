return {
  "nvim-treesitter/playground",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts_extend = { "ensure_installed" },
    opts = {
      -- A list of parser names, or "all" (the five listed parsers should always be installed)
      ensure_installed = { "ruby", "typescript", "javascript", "go", "lua", "vim", "query", "vimdoc", "c", "rust", "nu", "css", "toml" },

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
    },
    config = function(_, opts)
      require'nvim-treesitter.configs'.setup(opts)

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.ejs = {
        install_info = {
          url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
          files = { "src/parser.c" },
          requires_generate_from_grammar = true,
        },
        filetype = "ejs",
      }
      vim.treesitter.language.register("html", "ejs")

      parser_config.nu = {
        install_info = {
          url = "https://github.com/nushell/tree-sitter-nu",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "main",
        },
        filetype = "nu",
      }
      parser_config.ghostty = {
        install_info = {
          url = "~/src/flovilmart/tree-sitter-ghostty", -- local path or git repo
          -- url = "https://github.com/flovilmart/tree-sitter-ghostty", -- local path or git repo
          files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
          -- optional entries:
          -- branch = "main", -- default branch in case of git repo if different from master
          generate_requires_npm = true, -- if stand-alone parser without npm dependencies
          requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
        },
        filetype = "ghostty", -- if filetype does not match the parser name
      }
    end,
  }
}
