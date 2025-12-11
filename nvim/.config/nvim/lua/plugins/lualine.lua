return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.sections = opts.sections or {}
    opts.sections.lualine_a = {
      {
        "mode",
        icon = { "", align = "left" },
        separator = { left = "" },
        right_padding = 2,
      },
    }
    return opts
  end,
}
