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
  callback = function()
    vim.opt.relativenumber = false
  end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- Close diffview panels with q
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "DiffviewFiles", "DiffviewFileHistory", "DiffviewFileHistoryPanel" },
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>DiffviewClose<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Disable diagnostics for markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(args)
    vim.diagnostic.enable(false, { bufnr = args.buf })
  end,
})

-- Keep end-of-buffer tildes themed with NonText across colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "EndOfBuffer", { link = "NonText" })
  end,
})

-- CC prompt scaffolds
vim.api.nvim_create_user_command("CCprompt", function()
  vim.api.nvim_put({
    "If anything is unclear or you're not sure, say so. If this turns out harder than expected, name it.",
    "If you see a problem with my approach, flag it.",
    "When the task is complex, suggest a plan before diving in.",
    "Think out loud — show reasoning including the uncertain parts.",
    "",
    "Here's what I need help with:",
    "",
  }, "l", true, true)
end, { desc = "Insert CC task prompt scaffold" })

vim.api.nvim_create_user_command("CCresearch", function()
  vim.api.nvim_put({
    "If patterns are ambiguous, say so — multiple interpretations are more useful than false confidence.",
    "Walk me through what you find, including what's unclear or could go multiple ways.",
    "",
    "Research topic:",
    "",
  }, "l", true, true)
end, { desc = "Insert CC research prompt scaffold" })
