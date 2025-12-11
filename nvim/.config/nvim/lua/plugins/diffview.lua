return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Diff" },
    {
      "<leader>gh",
      function()
        vim.cmd("DiffviewFileHistory " .. vim.fn.expand("%"))
      end,
      desc = "File History",
    },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Project History" },
  },
  opts = {
    use_icons = true,
    view = {
      default = {
        layout = "diff2_vertical",
      },
      file_history = {
        layout = "diff2_vertical",
      },
    },
  },
}
