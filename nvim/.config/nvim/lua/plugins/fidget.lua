return {
  "j-hui/fidget.nvim",

  event = "LspAttach",

  opts = {
    -- Progress bars for LSP operations
    notification = {
      override_vim_notify = true,
      window = { winblend = 0 },
    },
    logger = {
      path = vim.fn.stdpath("cache") .. "/fidget.log",
      level = vim.log.levels.WARN,
    },
  },

}
