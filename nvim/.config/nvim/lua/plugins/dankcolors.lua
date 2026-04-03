return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#131318',
				base01 = '#131318',
				base02 = '#9a99a5',
				base03 = '#9a99a5',
				base04 = '#f1efff',
				base05 = '#f9f8ff',
				base06 = '#f9f8ff',
				base07 = '#f9f8ff',
				base08 = '#ff9fb5',
				base09 = '#ff9fb5',
				base0A = '#cec9ff',
				base0B = '#a5ffb6',
				base0C = '#e5e2ff',
				base0D = '#cec9ff',
				base0E = '#d7d2ff',
				base0F = '#d7d2ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#9a99a5',
				fg = '#f9f8ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#cec9ff',
				fg = '#131318',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#9a99a5' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#e5e2ff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#d7d2ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#cec9ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#cec9ff',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#e5e2ff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a5ffb6',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#f1efff' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#f1efff' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#9a99a5',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
