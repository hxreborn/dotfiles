-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Enable Nerd Font icons in statusline and UI
vim.g.have_nerd_font = true

-- markdown-preview.nvim: allow access over SSH/Tailscale
vim.g.mkdp_open_to_the_world = 1
vim.g.mkdp_open_ip = "0.0.0.0"
vim.g.mkdp_port = "8090"
vim.g.mkdp_echo_preview_url = 1
vim.g.mkdp_browserfunc = "MkdpCopyUrl"
vim.g.mkdp_auto_start = 1
vim.g.mkdp_auto_close = 0

-- Copy preview URL to system clipboard via OSC 52 (works over SSH)
vim.cmd([[
  function! MkdpCopyUrl(url)
    call v:lua.vim.fn.setreg('+', a:url)
    echomsg a:url
  endfunction
]])
local ok, osc52 = pcall(require, 'vim.ui.clipboard.osc52')
if ok then
    vim.g.clipboard = {
        name = 'OSC 52',
        copy = { ['+'] = osc52.copy('+'), ['*'] = osc52.copy('*') },
        paste = { ['+'] = osc52.paste('+'), ['*'] = osc52.paste('*') },
    }
end

-- Show clickable Tailscale URL in preview
local ts_ip = vim.fn.system("tailscale ip -4 2>/dev/null"):gsub("%s+", "")
if ts_ip ~= "" then
    vim.g.mkdp_open_ip = ts_ip
end
