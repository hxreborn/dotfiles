return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    -- Override LazyVim's default_format_opts
    opts.default_format_opts = opts.default_format_opts or {}
    opts.default_format_opts.lsp_format = "never"
    opts.default_format_opts.quiet = true

    -- Kotlin uses local ktlint 1.7.1 (1.8.0 has printf bug)
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.kotlin = { "ktlint" }
    opts.formatters_by_ft.qml = { "qmlformat" }

    opts.formatters = opts.formatters or {}
    opts.formatters.ktlint = {
      command = vim.fn.expand("~/.local/bin/ktlint"),
    }
    opts.formatters.qmlformat = {
      command = "/usr/lib/qt6/bin/qmlformat",
    }

    return opts
  end,
}
