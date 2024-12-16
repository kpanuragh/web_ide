return {
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		name = "catppuccin",
		config = function()
			vim.cmd([[colorscheme catppuccin]])
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
			require("config.lualine")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		after = "catppuccin",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					separator_style = "thin",
					highlights = require("catppuccin.groups.integrations.bufferline").get(),
				},
			})
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}

			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			require("ibl").setup({ indent = { highlight = highlight } })
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				-- Configuration options
				stages = "fade_in_slide_out", -- Animation style
				timeout = 3000, -- Notification display time in ms
				background_colour = "#000000", -- Background color for notifications
			})
			vim.notify = require("notify") -- Replace default `vim.notify` with `nvim-notify`
		end,
	},
	{
		"tpope/vim-surround",
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				enable_check_bracket_line = false,
			})
		end,
	},
	{
		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("alpha").setup(require("alpha.themes.theta").config)
		end,
	},
}
