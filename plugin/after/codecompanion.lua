local codecompanion_loaded, codecompanion = pcall(function() return require'codecompanion' end)
if not codecompanion_loaded then
  return
end

codecompanion.setup({
  strategies = {
    chat = {
      adapter = "copilot",
    },
    inline = {
      adapter = "copilot",
    },
    agent = {
      adapter = "copilot",
    },
  },
})
