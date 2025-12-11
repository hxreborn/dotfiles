return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit Status" },
    { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit Commit" },
  },
  opts = {
    disable_hint = false,
    graph_style = "unicode",
    integrations = {
      diffview = true,
    },
    kind = "vsplit",
  },
}
