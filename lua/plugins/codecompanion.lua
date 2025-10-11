return {
  {
    "olimorris/codecompanion.nvim",
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
            adapter = adapter,
          },
          agent = {
            adapter = adapter,
          },
        },
      })
    end,
  }
}
