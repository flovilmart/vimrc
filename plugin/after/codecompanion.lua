require('codecompanion').setup({
  strategies = {
    chat = {
      adapter = "gemini",
    },
    inline = {
      adapter = "copilot",
    },
    agent = {
      adapter = "gemini",
    },
  },
})
