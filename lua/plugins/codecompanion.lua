return {
  {
    "flovilmart/codecompanion.nvim",
    branch = "mistral-tools",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local adapter = "mistral"
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter =  { name = adapter, model = "codestral-latest" },
            tools = {
              -- Weather tools stub for development
              ["weather"] = {
                callback = vim.fn.getcwd() .. "/tests/strategies/chat/tools/catalog/stubs/weather.lua",
                description = "Get the latest weather",
              },
              opts = {
                -- this is needed for mistral to work peroperly
                auto_submit_errors = true, -- Send any errors to the LLM automatically?
                auto_submit_success = true, -- Send any successful output to the LLM automatically?
                default_tools = { "full_stack_dev" },
              },
            }
          },
          inline = {
            adapter = "mistral_inline",
          },
          agent = {
            adapter = adapter,
          },
        },
         memory = {
          opts = {
            chat = {
              enabled = true,
            },
          },
        },
        adapters = {
          http = {
            mistral = function()
              return require("codecompanion.adapters").extend("mistral", {
                env = {
                  url = "https://codestral.mistral.ai/",
                  api_key = "CODESTRAL_API_KEY",
                },
                model = "codestral-latest"
              })
            end,
            opts = {
--              allow_insecure = true,
--              proxy = "http://127.0.0.1:4141",
            },
          }
        },
        opts = {
          log_level = "DEBUG"
        },
      })
    end,
  }
}
