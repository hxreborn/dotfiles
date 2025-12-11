local M = {}

local messages = {
  up = "↑ disabled → k or Ctrl+u",
  down = "↓ disabled → j or Ctrl+d",
  left = "← disabled → h or b",
  right = "→ disabled → l or w",
}

local function disable_key(mode, key, message)
  vim.keymap.set(mode, key, function()
    vim.notify(message, vim.log.levels.HINT)
  end, { noremap = true, silent = false })
end

function M.setup()
  local modes = { "n", "i", "x" }
  local keys = {
    { "<Up>", messages.up },
    { "<Down>", messages.down },
    { "<Left>", messages.left },
    { "<Right>", messages.right },
  }

  for _, mode in ipairs(modes) do
    for _, key_pair in ipairs(keys) do
      disable_key(mode, key_pair[1], key_pair[2])
    end
  end
end

return M
