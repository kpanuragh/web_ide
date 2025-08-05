-- Large project performance optimizations
return {
	-- Treesitter optimizations for large files
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			-- Disable on very large files
			disable = function(lang, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
	},

	-- Optimize CMP for large projects
	{
		"hrsh7th/nvim-cmp",
		opts = {
			performance = {
				debounce = 60,          -- Reduced debounce for better responsiveness 
				throttle = 30,          -- Reduced throttle
				fetching_timeout = 500, -- Increased timeout for large projects
				confirm_resolve_timeout = 80,
				async_budget = 1,
				max_view_entries = 15,  -- Reduced max entries
			},
			sources = {
				{ name = "copilot", max_item_count = 10 },
				{ name = "nvim_lsp", max_item_count = 15 }, -- Limit LSP items
				{ name = "buffer", max_item_count = 8 },    -- Limit buffer items
				{ name = "path", max_item_count = 8 },      -- Limit path items
				{ name = "luasnip", max_item_count = 5 },   -- Limit snippet items
			},
		},
	},

	-- Large file handling
	{
		"LunarVim/bigfile.nvim",
		config = function()
			require("bigfile").setup({
				filesize = 2, -- 2MB threshold
				pattern = { "*" }, -- All files
				features = {
					"indent_blankline",
					"illuminate",
					"lsp",
					"treesitter",
					"syntax",
					"matchparen",
					"vimopts",
					"filetype",
				},
			})
		end,
	},

	-- Memory-efficient file watching
	{
		"nvim-telescope/telescope.nvim",
		opts = {
			defaults = {
				file_ignore_patterns = {
					"vendor/.*",
					"storage/.*",
					"bootstrap/cache/.*",
					"node_modules/.*",
					"%.git/.*",
					"%.log$",
					"%.cache$",
					"%.tmp$",
					"docker/.*",
					"%.docker/.*",
				},
				-- Performance settings
				cache_picker = {
					num_pickers = 3,
				},
			},
			pickers = {
				find_files = {
					find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
				},
				live_grep = {
					additional_args = function()
						return { "--hidden", "--glob", "!{.git,vendor,storage,node_modules,docker}/*" }
					end,
				},
			},
		},
	},

	-- Git performance for large repos
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			max_file_length = 40000, -- Disable for very long files
			update_debounce = 200,   -- Slower updates for performance
			preview_config = {
				border = "single",
				style = "minimal",
			},
		},
	},

	-- LSP progress with rate limiting
	{
		"j-hui/fidget.nvim",
		opts = {
			progress = {
				poll_rate = 1,              -- Slower polling
				suppress_on_insert = true,  -- Don't show during insert
			},
		},
	},

	-- Disable heavy plugins for large files
	{
		"folke/noice.nvim",
		opts = {
			-- Optimize Noice for large projects without breaking functionality
			cmdline = {
				view = "cmdline",
			},
			messages = {
				enabled = true, -- Keep enabled for better UX, but optimize
				view = "mini", -- Use mini view for better performance
				view_error = "mini",
				view_warn = "mini",
			},
			notify = {
				enabled = true,
				view = "mini",
			},
			lsp = {
				progress = {
					enabled = true,
					format = "lsp_progress",
					format_done = "lsp_progress_done",
					throttle = 1000 / 30, -- Throttle LSP progress updates
					view = "mini",
				},
				override = {
					-- Optimize LSP signature help for large projects
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = false, -- Disable for performance
				long_message_to_split = true,
				inc_rename = false, -- Disable for performance
				lsp_doc_border = false,
			},
		},
	},
}
