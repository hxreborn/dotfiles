return {
  -- Disable markdown-preview from LazyVim extras
  { "iamcco/markdown-preview.nvim", enabled = false },

  -- Markdown preview via deno webview
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    keys = {
      {
        "<leader>cp",
        function()
          local peek = require("peek")
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = "Peek (Markdown Preview)",
      },
    },
    opts = {},
  },
}
