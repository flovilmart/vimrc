return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
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
