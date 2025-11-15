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
        extensions = {
            mcphub = {
              callback = "mcphub.extensions.codecompanion",
              opts = {
                -- MCP Tools
                make_tools = true,              -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
                show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
                add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
                show_result_in_chat = true,      -- Show tool results directly in chat buffer
                format_tool = nil,               -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
                -- MCP Resources
                make_vars = true,                -- Convert MCP resources to #variables for prompts
                -- MCP Prompts
                make_slash_commands = true,      -- Add MCP prompts as /slash commands
              }
            }
          },
        strategies = {
          chat = {
            adapter = { name = adapter, model = "magistral-small-latest" },
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
            adapter = adapter,
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
              return require("codecompanion.adapters").extend("mistral", {});
            end,
            codestral = function(self)
              return require("codecompanion.adapters").extend("mistral", {
                name = "codestral",
                formatted_name = "Mistral",
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
