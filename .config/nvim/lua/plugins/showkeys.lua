return {
  "nvzone/showkeys",
  cmd = "ShowkeysToggle",
  event = "VeryLazy",
  keys = {
    { "<leader>ks", "<cmd>ShowkeysToggle<CR>", desc = "Toggle Showkeys (Keystroke Display)" },
  },
  opts = {
    timeout = 2,
    maxkeys = 5,
    show_autocmd = true,
  },
  config = function()
    -- Always enable showkeys on startup
    vim.cmd("ShowkeysToggle")
  end,
}
