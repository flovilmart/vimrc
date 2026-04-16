return {
  {
    "flovilmart/codecompanion.nvim",
    branch = "mistral-tools",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local adapter = "codestral"
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = { name = adapter, model = 'codestral-latest' },
            tools = {
              opts = {
                -- this is needed for mistral to work peroperly
                auto_submit_errors = true, -- Send any errors to the LLM automatically?
                auto_submit_success = true, -- Send any successful output to the LLM automatically?
                default_tools = { "full_stack_dev" },
              },
            }
          },
          inline = {
            adapter = 'azure_openai',
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
          acp = {
                vibe = function()
                  return require("codecompanion.adapters").extend("claude_code", {
                    commands = {
                      default = {
                        "vibe-acp",
                      },
                    },
                  })
                end,
          },
          http = {
            azure_openai = function()
              return require("codecompanion.adapters").extend("azure_openai", {
                env = {
                  api_key = "AZURE_OPENAI_API_KEY",
                  endpoint = "AZURE_OPENAI_ENDPOINT",
                },
                schema = {
                  model = {
                    default = "gpt-5.1",
                  },
                },
              });
            end,
            mistral = function()
              return require("codecompanion.adapters").extend("mistral", {});
            end,
            codestral = function(self)
              return require("codecompanion.adapters").extend("mistral", {
                name = "codestral",
                formatted_name = "CodeStral",
                env = {
                  url = "https://codestral.mistral.ai/",
                  api_key = "CODESTRAL_API_KEY",
                },
                model = "codestral-latest",
                opts = {
                  show_model_choices = false
                },
                schema = {
                  ---@type CodeCompanion.Schema
                  model = {
                    default = "codestral-latest",
                    choices = {
                      "codestral-latest",
                    },
                  },
                }
              })
            end,
            opts = {
              show_defaults = false,
              show_model_choices = true
            }
            --  opts = {
--              allow_insecure = true,
--              proxy = "http://127.0.0.1:4141",
            -- },
          },
        },
        opts = {
          log_level = "DEBUG"
        },
      })
    end,
  }
}
