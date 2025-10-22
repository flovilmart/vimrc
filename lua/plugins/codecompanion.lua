return {
  {
    "flovilmart/codecompanion.nvim",
    branch = "wip",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local adapter = "mistral"
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = adapter,
          },
          inline = {
            adapter = "copilot",
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
        opts = { log_level = "DEBUG" },
      })
    end,
  }
}
