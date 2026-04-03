-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Relative numbers in normal mode, absolute in insert
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function() vim.opt.relativenumber = false end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function() vim.opt.relativenumber = true end,
})

-- Disable diagnostics for markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(args)
    vim.diagnostic.enable(false, { bufnr = args.buf })
  end,
})

-- Auto-format Kotlin files with ktlint on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("ktlint_format", { clear = true }),
  pattern = "*.kt",
  callback = function()
    -- Only format if we're in a Gradle project
    local gradle_file = vim.fn.findfile("build.gradle.kts", ".;")
    if gradle_file == "" then
      gradle_file = vim.fn.findfile("build.gradle", ".;")
    end

    if gradle_file ~= "" then
      vim.lsp.buf.format({
        name = "conform.nvim",
        async = false,
      })
    end
  end,
})

-- Run ktlint check when Kotlin files are saved
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("ktlint_check", { clear = true }),
  pattern = "*.kt",
  callback = function()
    -- Only check if we're in a Gradle project
    local gradle_file = vim.fn.findfile("build.gradle.kts", ".;")
    if gradle_file == "" then
      gradle_file = vim.fn.findfile("build.gradle", ".;")
    end

    if gradle_file ~= "" then
      local lint = require("lint")
      lint.try_lint()
    end
  end,
})
