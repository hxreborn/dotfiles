local M = {}

function M.setup()
	require('base16-colorscheme').setup({
		base00 = '{{colors.mSurface}}',
		base01 = '{{colors.mSurface}}',
		base02 = '{{colors.mOnSurfaceVariant}}',
		base03 = '{{colors.mOnSurfaceVariant}}',
		base04 = '{{colors.mOnSurface}}',
		base05 = '{{colors.mOnSurface}}',
		base06 = '{{colors.mOnSurface}}',
		base07 = '{{colors.mOnSurface}}',
		base08 = '{{colors.mError}}',
		base09 = '{{colors.mError}}',
		base0A = '{{colors.mSecondary}}',
		base0B = '{{colors.mPrimary}}',
		base0C = '{{colors.mTertiary}}',
		base0D = '{{colors.mSecondary}}',
		base0E = '{{colors.mPrimary}}',
		base0F = '{{colors.mPrimary}}',
	})

	vim.api.nvim_set_hl(0, 'Visual', { bg = '{{colors.mOnSurfaceVariant}}', fg = '{{colors.mOnSurface}}', bold = true })
	vim.api.nvim_set_hl(0, 'Statusline', { bg = '{{colors.mSecondary}}', fg = '{{colors.mSurface}}' })
	vim.api.nvim_set_hl(0, 'LineNr', { fg = '{{colors.mOnSurfaceVariant}}' })
	vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '{{colors.mTertiary}}', bold = true })
	vim.api.nvim_set_hl(0, 'Statement', { fg = '{{colors.mPrimary}}', bold = true })
	vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
	vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
	vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })
	vim.api.nvim_set_hl(0, 'Function', { fg = '{{colors.mSecondary}}', bold = true })
	vim.api.nvim_set_hl(0, 'Macro', { fg = '{{colors.mSecondary}}', italic = true })
	vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })
	vim.api.nvim_set_hl(0, 'Type', { fg = '{{colors.mTertiary}}', bold = true, italic = true })
	vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })
	vim.api.nvim_set_hl(0, 'String', { fg = '{{colors.mPrimary}}', italic = true })
	vim.api.nvim_set_hl(0, 'Operator', { fg = '{{colors.mOnSurface}}' })
	vim.api.nvim_set_hl(0, 'Delimiter', { fg = '{{colors.mOnSurface}}' })
	vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
	vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })
	vim.api.nvim_set_hl(0, 'Comment', { fg = '{{colors.mOnSurfaceVariant}}', italic = true })
end

if not _G._noctalia_signal then
	_G._noctalia_signal = vim.uv.new_signal()
	_G._noctalia_signal:start('sigusr1', vim.schedule_wrap(function()
		package.loaded['matugen'] = nil
		require('matugen').setup()
	end))
end

return M
