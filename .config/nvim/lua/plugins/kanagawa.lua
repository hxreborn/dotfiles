return {
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		opts = {
			compile = false,
			undercurl = true,
			commentStyle = { italic = true },
			functionStyle = { bold = true },
			keywordStyle = { bold = true },
			statementStyle = { bold = true },
			typeStyle = { bold = true, italic = true },
			transparent = false,
			terminalColors = true,
			theme = "wave", -- "wave" | "dragon" | "lotus"
		},
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "kanagawa",
		},
	},
}
