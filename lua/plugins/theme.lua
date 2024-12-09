return {
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				style = "night",
				transparent = false,
				terminal_colors = true,
			})
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = { -- set to setup table
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup()
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({})
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},
	{
		"nvimdev/indentmini.nvim",
		config = function()
			require("indentmini").setup({
				char = "│", -- Character for indent guides, can also be '¦', '┆', or '┊'
				exclude = {
					"help",
					"dashboard",
					"lazy",
					"mason",
					"alpha",
					"NvimTree",
				}, -- Filetypes to exclude
				options = {
					use_treesitter = true, -- Use Tree-sitter for more accurate indentation
					priority = 10, -- Priority for drawing
				},
				level = {
					min = 2, -- Minimum indent level for guides
				},
			})
		end,
	},
}
