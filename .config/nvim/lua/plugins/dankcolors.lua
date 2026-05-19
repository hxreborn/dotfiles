return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require('matugen').setup()
			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				once = true,
				callback = function()
					require('matugen').setup()
				end,
			})
		end,
	}
}
