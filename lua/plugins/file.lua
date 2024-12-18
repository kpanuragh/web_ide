return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		keys = {
			{ "<leader>fe", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			--  "3rd/image.nvim",  -- This is optional based on usage
		},
		config = function()
			require("neo-tree").setup({
				-- Your neo-tree config options here (if any)
			})
		end,
	},

	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({})
		end,
	},
	{
		"olimorris/persisted.nvim",
		lazy = false, -- make sure the plugin is always loaded at startup
		config = function()
			require("persisted").setup({
				use_git_branch = true,
			})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
			{ "<leader>fh", "<cmd>Telescope persisted<cr>", desc = "Session" },
			{ "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },
			{ "<leader>gr", "<cmd>Telescope lsp_references<CR>", desc = "Find References" },
			{ "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", desc = "Go to Definition" },
			{ "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", desc = "Find Implementations" },
			{ "<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>", desc = "Find Type Definitions" },
			{ "<leader>ld", "<cmd>Telescope diagnostics<CR>", desc = "Workspace Diagnostics" },
			{ "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document Symbols" },
			{ "<leader>lw", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "Workspace Symbols" },
		},
		config = function()
			-- Telescope setup
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true, -- enable fuzzy matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- "smart_case" or "ignore_case" or "respect_case"
					},
					project = {}, -- Add your project.nvim settings here if needed
				},
			})

			-- Load Telescope extensions
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("projects")
			require("telescope").load_extension("persisted")
		end,
	},
	{
		"Bekaboo/dropbar.nvim",
		-- optional, but required for fuzzy finder support
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		config = function()
			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
			vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		end,
	},
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" },
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"nvim-orgmode/orgmode",
		event = "VeryLazy",
		ft = { "org" },
		config = function()
			-- Setup orgmode
			require("orgmode").setup({
				org_agenda_files = "~/orgfiles/**/*",
				org_default_notes_file = "~/orgfiles/refile.org",
			})

			-- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
			-- add ~org~ to ignore_install
			-- require('nvim-treesitter.configs').setup({
			--   ensure_installed = 'all',
			--   ignore_install = { 'org' },
			-- })
		end,
	},
}
