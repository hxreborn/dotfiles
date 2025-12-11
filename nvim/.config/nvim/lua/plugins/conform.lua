return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      kotlin = { "ktlint" },
    },
    formatters = {
      ktlint = {
        command = "ktlint",
        args = { "-F", "$FILENAME" },
        stdin = false,
      },
    },
  },
}
