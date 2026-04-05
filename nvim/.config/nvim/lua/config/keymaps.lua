-- Keymaps are automatically loaded on VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Disable arrow keys, show helpful hints instead
---@type table<string, string>
local arrow_hints = {
  ["<Up>"] = "↑ disabled → k or Ctrl+u",
  ["<Down>"] = "↓ disabled → j or Ctrl+d",
  ["<Left>"] = "← disabled → h or b",
  ["<Right>"] = "→ disabled → l or w",
}
for key, hint in pairs(arrow_hints) do
  for _, mode in ipairs({ "n", "i", "x" }) do
    vim.keymap.set(mode, key, function()
      vim.notify(hint, vim.log.levels.HINT)
    end, { noremap = true, silent = false })
  end
end

-- Alt+hjkl navigation in insert/command/other modes
for _, mode in ipairs({ "i", "c", "o", "t", "s" }) do
  vim.keymap.set(mode, "<A-h>", "<Left>",  { noremap = true, silent = true, desc = "Move left" })
  vim.keymap.set(mode, "<A-j>", "<Down>",  { noremap = true, silent = true, desc = "Move down" })
  vim.keymap.set(mode, "<A-k>", "<Up>",    { noremap = true, silent = true, desc = "Move up" })
  vim.keymap.set(mode, "<A-l>", "<Right>", { noremap = true, silent = true, desc = "Move right" })
end
