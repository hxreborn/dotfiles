return {
  "gbprod/yanky.nvim",
  event = "VeryLazy",

  opts = {
    ring = {
      yank = {
        keys = {
          -- Custom yank keybindings
          -- "y" is default for normal mode yanking
        },
      },
    },
    highlight = {
      -- Highlight yanked text
      on_yank = true,
      on_put = true,
    },
    system_clipboard = {
      sync_with_neovim = true,
    },
  },

  keys = {
    -- Example keybindings (customize as needed)
    { "<leader>p", function() require("yanky").put("p") end, desc = "Paste from yank ring" },
    { "<leader>P", function() require("yanky").put("P") end, desc = "Paste from yank ring (before cursor)" },
  },
}
