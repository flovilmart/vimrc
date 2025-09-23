return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      vim.api.nvim_create_user_command('CC', 'CodeCompanion', { desc = 'alias for CodeCompanion'})
      vim.api.nvim_create_user_command('CCC', 'CodeCompanionChat', { desc = 'alias for CodeCompanionChat'})
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "mistral",
          },
          inline = {
            adapter = "mistral",
          },
          agent = {
            adapter = "mistral",
          },
        },
      })
    end,
  }
}
