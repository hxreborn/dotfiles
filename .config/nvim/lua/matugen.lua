local M = {}

function M.setup()
	require('base16-colorscheme').setup({
		base00 = '#121318',
		base01 = '#121318',
		base02 = '#999ba5',
		base03 = '#999ba5',
		base04 = '#eff1ff',
		base05 = '#f8f9ff',
		base06 = '#f8f9ff',
		base07 = '#f8f9ff',
		base08 = '#ff9fb7',
		base09 = '#ff9fb7',
		base0A = '#c4ccff',
		base0B = '#a5ffb4',
		base0C = '#dfe3ff',
		base0D = '#c4ccff',
		base0E = '#ced5ff',
		base0F = '#ced5ff',
	})

	vim.api.nvim_set_hl(0, 'Visual', { bg = '#999ba5', fg = '#f8f9ff', bold = true })
	vim.api.nvim_set_hl(0, 'Statusline', { bg = '#c4ccff', fg = '#121318' })
	vim.api.nvim_set_hl(0, 'LineNr', { fg = '#999ba5' })
	vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#dfe3ff', bold = true })
	vim.api.nvim_set_hl(0, 'Statement', { fg = '#ced5ff', bold = true })
	vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
	vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
	vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })
	vim.api.nvim_set_hl(0, 'Function', { fg = '#c4ccff', bold = true })
	vim.api.nvim_set_hl(0, 'Macro', { fg = '#c4ccff', italic = true })
	vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })
	vim.api.nvim_set_hl(0, 'Type', { fg = '#dfe3ff', bold = true, italic = true })
	vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })
	vim.api.nvim_set_hl(0, 'String', { fg = '#a5ffb4', italic = true })
	vim.api.nvim_set_hl(0, 'Operator', { fg = '#eff1ff' })
	vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#eff1ff' })
	vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
	vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })
	vim.api.nvim_set_hl(0, 'Comment', { fg = '#999ba5', italic = true })
end

if not _G._noctalia_signal then
	_G._noctalia_signal = vim.uv.new_signal()
	_G._noctalia_signal:start('sigusr1', vim.schedule_wrap(function()
		package.loaded['matugen'] = nil
		require('matugen').setup()
	end))
end

return M
