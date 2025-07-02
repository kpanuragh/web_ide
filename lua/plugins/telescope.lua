return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	event = "VeryLazy",
	version = false, -- always latest
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-file-browser.nvim" },
		{ "nvim-telescope/telescope-project.nvim" },
		{ "nvim-telescope/telescope-dap.nvim" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = vim.fn.executable("make") == 1,
		},
		{
			"folke/todo-comments.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = true,
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				prompt_prefix = "🔍 ",
				selection_caret = " ",
				path_display = { "smart" },
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					prompt_position = "top",
					width = 0.95,
					height = 0.85,
					preview_cutoff = 120,
				},
				file_ignore_patterns = {
					"node_modules/",
					".git/",
					"vendor/",
					"target/",
					"build/",
					"dist/",
					"yarn.lock",
					"%.lock",
					"%.min.js",
					"%.min.css",
					"__pycache__/",
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
				},
			},
			pickers = {
				find_files = {
					previewer = false,
					hidden = true,
					follow = true,
					find_command = {
						"fd",
						"--type",
						"f",
						"--strip-cwd-prefix",
						"--hidden",
						"--exclude",
						".git",
					},
				},
				live_grep = {
					additional_args = function()
						return { "--hidden", "--glob", "!.git/*" }
					end,
				},
			},
			buffers = {
				previewer = false,
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
				file_browser = {
					theme = "ivy",
					hijack_netrw = true,
				},
				project = {
					base_dirs = {
						"~/Projects",
					},
					theme = "dropdown",
				},
				dap = {
					theme = "dropdown",
				},
			},
		})
		telescope.load_extension("fzf")
		telescope.load_extension("file_browser")
		telescope.load_extension("project")
		telescope.load_extension("dap")
	end,
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep (Live)" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
		{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
		{ "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in Buffer" },
		{ "<leader>fp", "<cmd>Telescope project<cr>", desc = "Projects" },
		{ "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
		{ "<leader>fdp", "<cmd>Telescope dap commands<cr>", desc = "DAP Commands" },
		{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "TODO Comments" },
	},
}
