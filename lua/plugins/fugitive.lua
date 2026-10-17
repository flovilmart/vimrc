-- Custom Browse handler for nushell so we can use `open` properly
-- Netrw fails in those cases
local open = function(args)
  os.execute("open ".. args.args)
end
-- Browser Open is checked here: https://github.com/tpope/vim-fugitive/blob/fcb4db52e7f65b95705aa58f0f2df1312c1f2df2/autoload/fugitive.vim#L7422
vim.api.nvim_create_user_command(
    "Browse", -- string
    open,  -- string or Lua function
    { nargs = 1, desc = "Open Browser with ^open in nushell", bang = true }
)

vim.keymap.set("v", "<leader>g", ":GBrowse<CR>", { silent = true }, "Git browse")

-- The mouse wheel scrolls the window under the pointer without focusing it,
-- and scrollbind only follows the current window. Focus diff windows first so
-- both sides of a diff scroll together.
for _, key in ipairs({ "<ScrollWheelUp>", "<ScrollWheelDown>" }) do
  local termkey = vim.api.nvim_replace_termcodes(key, true, false, true)
  vim.keymap.set({ "n", "v", "i" }, key, function()
    local win = vim.fn.getmousepos().winid
    if win ~= 0 and win ~= vim.api.nvim_get_current_win() and vim.wo[win].diff then
      vim.api.nvim_set_current_win(win)
    end
    vim.api.nvim_feedkeys(termkey, "n", false)
  end, { desc = "Scroll, focusing diff windows so scrollbind applies" })
end

return {
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "airblade/vim-gitgutter",
  {
    "sindrets/diffview.nvim",
    opts = {
      view = {
        -- Side by side. Diffview's naming is inverted: "horizontal" means
        -- the panes sit next to each other, "vertical" stacks them.
        default = { layout = "diff2_horizontal" },
        file_history = { layout = "diff2_horizontal" },
      },
    },
    config = function(_, opts)
      require("diffview").setup(opts)
      -- `:G` opens Diffview. Set on VimEnter so it wins over fugitive's own
      -- `:G`, whichever plugin loads first.
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.api.nvim_create_user_command("G", function(args)
            vim.cmd("DiffviewOpen " .. args.args)
          end, { nargs = "*", desc = "Open Diffview" })
        end,
      })
    end,
  },
}
